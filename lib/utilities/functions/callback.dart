import 'package:flutter/material.dart';

void callBack(Function callback) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    callback();
  });
}
