import 'package:flutter/material.dart';
import 'package:ud_design/ud_design.dart';

import '../constants/colors.dart';
import '../constants/themes.dart';

class PButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final double height;
  final double width;
  final Color backgroundColor;
  const PButton({
    Key? key,
    this.height = PThemes.height,
    this.width = double.infinity,
    required this.text,
    this.onTap,
    this.backgroundColor = PColors.primary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: UdDesign.pt(height),
      width: width,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  PThemes.borderRadius), // radius you want
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
        ),
        onPressed: onTap,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
