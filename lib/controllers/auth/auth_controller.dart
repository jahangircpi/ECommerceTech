import 'dart:io';
import 'package:boilerplate/utilities/constants/keys.dart';
import 'package:boilerplate/utilities/widgets/snacbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import '../../utilities/constants/enums.dart';
import '../../utilities/functions/print.dart';
import '../../utilities/services/navigation.dart';
import '../../views/auth/sign_in.dart';
import '../../views/home/home_screen.dart';

class CAuth extends ChangeNotifier {
  DataState signUpDataState = DataState.initial;
  DataState signInDataState = DataState.initial;
  DataState imageTakingState = DataState.initial;
  File? profileImage;
  bool passwordVisible = false;
  User? user;
  final FirebaseAuth auth = FirebaseAuth.instance;

  getPassVisiblity(bool? value) {
    passwordVisible = value!;
    notify();
  }

  notify() {
    notifyListeners();
  }

  Future signIn({String? email, String? password}) async {
    signInDataState = DataState.loading;
    notify();
    try {
      user = await auth
          .signInWithEmailAndPassword(email: email!, password: password!)
          .then((value) async {
        if (value.user == null) {
          await auth.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
        }
        return user;
      });
      pushAndRemoveUntil(
        screen: const HomeScreen(),
      );
      signInDataState = DataState.loaded;
      notify();
      return user;
    } on FirebaseAuthException catch (e) {
      signInDataState = DataState.error;

      pSnacbar(
          text: "Opps!",
          title: e.message.toString(),
          snackBarType: SnackBarType.warning);
      notify();
      return e.message;
    }
  }

  signUp({
    required String? email,
    required String? password,
    required String? fullName,
    required String? phoneNumber,
  }) async {
    signInDataState = DataState.loading;
    notify();
    try {
      user = await auth
          .createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      )
          .then((value) async {
        UploadTask task = await uploadFile2(profileImage!);
        TaskSnapshot storageTaskSnapshot = await task;
        storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) {
          dataEntry(
            userId: auth.currentUser!.uid,
            fullName: fullName!,
            phoneNumber: phoneNumber,
            email: email,
            profileImage: downloadUrl,
          );
        });
        return user;
      });
      pushAndRemoveUntil(
        screen: const HomeScreen(),
      );
      signInDataState = DataState.loaded;
      notify();
      return user;
    } on FirebaseAuthException catch (e) {
      signInDataState = DataState.error;
      pSnacbar(
          text: "Opps!",
          title: e.message.toString(),
          snackBarType: SnackBarType.warning);

      notify();
      return e.message;
    }
  }

  Future signOut() async {
    await auth.signOut();
    pushAndRemoveUntil(
      screen: const SignInScreen(),
    );

    printer('signout');
  }

  dataEntry({
    userId,
    String? fullName,
    String? phoneNumber,
    String? email,
    String? profileImage,
  }) async {
    try {
      await PKeys.userCollection.doc(userId).set({
        "userId": userId,
        "name": fullName,
        "phoneNumber": phoneNumber,
        "email": email,
        'profileImage': profileImage,
      }, SetOptions(merge: true)).then((value) {});
    } catch (e) {
      printer(e);
      signInDataState = DataState.error;
    }
    notify();
  }

  getProfileImage({bool? cameraOrGallery}) async {
    imageTakingState = DataState.loading;
    notify();
    XFile? image = await ImagePicker().pickImage(
      source:
          cameraOrGallery == true ? ImageSource.gallery : ImageSource.camera,
      imageQuality: 90,
    );
    if (image != null) {
      profileImage = File(image.path);
      imageTakingState = DataState.loaded;
    } else {
      imageTakingState = DataState.error;
    }
    notify();
  }

  Future<UploadTask> uploadFile2(File file) async {
    UploadTask uploadTask;
    var timeKey = DateTime.now();
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('profileImages')
        .child('/$timeKey.jpg');

    final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': file.path});

    if (kIsWeb) {
      uploadTask = ref.putData(await file.readAsBytes(), metadata);
    } else {
      uploadTask = ref.putFile(File(file.path), metadata);
    }
    return Future.value(uploadTask);
  }
}
