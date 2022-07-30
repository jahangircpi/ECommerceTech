import 'package:boilerplate/utilities/constants/assets.dart';
import 'package:flutter/material.dart';

networkImagescall(
    {required String src,
    double? height = 100.00,
    double? width = 200,
    BoxFit? fit = BoxFit.cover}) {
  return Image.network(
    src,
    fit: fit,
    height: height,
    width: width,
    loadingBuilder:
        (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
      if (loadingProgress == null) return child;
      return Center(
        child: CircularProgressIndicator(
          value: loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded /
                  loadingProgress.expectedTotalBytes!
              : null,
        ),
      );
    },
    errorBuilder: (context, exception, stackTrace) {
      return Center(
        child: Image.asset(PAssets.personLogo,),
      );
    },
  );
}
