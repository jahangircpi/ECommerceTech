import 'package:boilerplate/utilities/constants/colors.dart';
import 'package:boilerplate/utilities/services/navigation.dart';
import 'package:flutter/material.dart';
import 'package:ud_design/ud_design.dart';

class CustomDialog extends StatelessWidget {
  final Widget? widget;
  const CustomDialog({Key? key, required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: dialogContent(widget));
  }

  Widget dialogContent(Widget? widgt) {
    return Container(
      margin: const EdgeInsets.only(left: 0.0, right: 0.0),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: UdDesign.pt(18),
            ),
            margin: EdgeInsets.only(
              top: UdDesign.pt(13.0),
              right: UdDesign.pt(8.0),
            ),
            decoration: BoxDecoration(
              color: PColors.backgroundColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 0.0,
                  offset: Offset(0.0, 0.0),
                ),
              ],
            ),
            child: widget!,
          ),
          Positioned(
            right: 0.0,
            child: GestureDetector(
              onTap: () {
                pop();
              },
              child: const Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  radius: 14.0,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.close, color: Colors.red),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
