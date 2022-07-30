import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PKeys {
  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
  static BuildContext? context = navigatorKey!.currentContext!;
  static final userCollection = FirebaseFirestore.instance.collection('user');
  static const categoryLists = 'categoryLists';
  static const latestProducts = 'latestProducts';
  static const productsLists = 'productsLists';
}
