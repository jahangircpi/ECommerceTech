import 'package:flutter/material.dart';
import 'package:ud_design/ud_design.dart';
import '../services/navigation.dart';

backbutton({required context, required title, bool? showbackbutton = false}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      InkWell(
        onTap: () {
          pop();
        },
        child: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
      ),
      Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: UdDesign.fontSize(15),
        ),
      ),
      const SizedBox.shrink()
    ],
  );
}
