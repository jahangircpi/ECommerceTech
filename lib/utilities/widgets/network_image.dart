import 'package:boilerplate/utilities/constants/assets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

networkImagescall(
    {required String src,
    double? height = 100.00,
    double? width = 200,
    BoxFit? fit = BoxFit.cover}) {
  return CachedNetworkImage(
    height: height,
    width: width,
    fit: fit,
    imageUrl: src,
    progressIndicatorBuilder: (context, url, downloadProgress) => Center(
      child: CircularProgressIndicator(
        value: downloadProgress.progress,
        color: Colors.white,
      ),
    ),
    errorWidget: (context, url, error) => Image.asset(
      PAssets.personLogo,
    ),
  );
}
