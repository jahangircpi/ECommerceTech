import 'package:boilerplate/utilities/constants/colors.dart';
import 'package:boilerplate/utilities/constants/themes.dart';
import 'package:flutter/material.dart';
import 'package:ud_design/ud_design.dart';

class PTextField extends StatelessWidget {
  final double height;
  final double width;
  final String? label;
  final Widget? suffixIcon;
  final String hintText;
  final bool obsecureText;
  final TextEditingController controller;
  final void Function(String)? onChanged;
  const PTextField(
      {Key? key,
      this.label,
      this.suffixIcon,
      required this.hintText,
      required this.controller,
      this.height = PThemes.height,
      this.onChanged,
      this.width = double.infinity,
      this.obsecureText = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   label ?? "",
        //   style: TextStyle(
        //     fontSize: UdDesign.fontSize(16),
        //   ),
        // ),
        // gapY(10),
        Container(
          height: UdDesign.pt(height),
          padding: const EdgeInsets.only(left: PThemes.padding),
          width: width,
          decoration: const BoxDecoration(
            color: PColors.textFieldColor,
            borderRadius: BorderRadius.all(
              Radius.circular(
                PThemes.borderRadius,
              ),
            ),
          ),
          child: Center(
            child: TextField(
              obscureText: obsecureText,
              onChanged: onChanged,
              controller: controller,
              decoration: InputDecoration(
                  suffixIcon: suffixIcon,
                  hintText: hintText,
                  border: InputBorder.none),
            ),
          ),
        ),
      ],
    );
  }
}
