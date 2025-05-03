import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_cloud_vision/app/widgets/app_shimmer.dart';

class AppImageAsset extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit? fit;
  final bool isFile;
  final bool isError;
  final bool isLoading;

  const AppImageAsset({
    super.key,
    required this.image,
    this.fit,
    this.height,
    this.width,
    this.color,
    this.isFile = false,
    this.isError = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? AppShimmerEffectView(height: height, width: width)
        : ((image.isEmpty) || (image.contains('http')))
            ? CachedNetworkImage(
                imageUrl: image,
                height: height,
                width: width,
                fit: fit ?? BoxFit.cover,
                placeholder: (context, url) => AppShimmerEffectView(height: height, width: width),
                errorWidget: (context, url, error) => const SizedBox.shrink(),
              )
            : isFile
                ? Image.file(File(image), height: height, width: width, color: color, fit: fit)
                : image.split('.').last != 'svg'
                    ? Image.asset(image, fit: fit, height: height, width: width, color: color)
                    : SvgPicture.asset(
                        image,
                        height: height,
                        width: width,
                        colorFilter: color != null ? ColorFilter.mode(color ?? Colors.transparent, BlendMode.srcIn) : null,
                      );
  }
}
