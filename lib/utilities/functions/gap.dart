import 'package:flutter/cupertino.dart';
import 'package:ud_design/ud_design.dart';

Widget gapX(double value) {
  return SizedBox(
    width: UdDesign.pt(value),
  );
}

Widget gapY(double value) {
  return SizedBox(
    height: UdDesign.pt(value),
  );
}

Widget textFieldGap() {
  return gapY(15);
}
