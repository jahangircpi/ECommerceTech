import 'dart:io';
import 'package:boilerplate/controllers/auth/auth_controller.dart';
import 'package:boilerplate/utilities/constants/keys.dart';
import 'package:boilerplate/utilities/widgets/snacbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';
import '../../utilities/constants/enums.dart';
import '../../utilities/functions/print.dart';

class CEditProfile extends GetxController {
  DataState editProfileStatepDataState = DataState.initial;

  DataState imageTakingState = DataState.initial;
  File? profileImage;

  notify() {
    update();
  }

  updateProfile({
    required String? fullName,
    required String? phoneNumber,
    required String? userId,
    String? previousImage,
  }) async {
    final CAuth authController = Get.put(CAuth());
    editProfileStatepDataState = DataState.loading;
    notify();
    try {
      if (profileImage != null) {
        UploadTask task = await uploadImage(profileImage!, previousImage);
        TaskSnapshot storageTaskSnapshot = await task;

        storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) async {
          await PKeys.userCollection.doc(authController.user!.uid).update(
            {
              "name": fullName,
              "phoneNumber": phoneNumber,
              'profileImage': downloadUrl,
            },
          );
        });
        deleteFireBaseStorageItem(previousImage!);
      } else {
        await PKeys.userCollection.doc(authController.user!.uid).update(
          {
            "name": fullName,
            "phoneNumber": phoneNumber,
          },
        );
      }

      editProfileStatepDataState = DataState.loaded;
      pSnacbar(
          text: "Opps!",
          title: "Your Profile is updated.",
          snackBarType: SnackBarType.success);
      notify();
    } on FirebaseAuthException catch (e) {
      editProfileStatepDataState = DataState.error;
      pSnacbar(
          text: "Opps!",
          title: e.message.toString(),
          snackBarType: SnackBarType.success);

      notify();
      return e.message;
    } catch (e) {
      editProfileStatepDataState = DataState.error;
      pSnacbar(
          text: "Opps!",
          title: 'Something went wrong!',
          snackBarType: SnackBarType.warning);

      notify();
      printer(e);
    }
  }

  static void deleteFireBaseStorageItem(String fileUrl) {
    FirebaseStorage.instance.refFromURL(fileUrl).delete();
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

  Future<UploadTask> uploadImage(File file, previousPhoto) async {
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
