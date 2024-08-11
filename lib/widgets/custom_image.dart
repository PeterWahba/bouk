import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final String? placeholder;

  const CustomImage(
      {Key? key, required this.image, this.height, this.width, this.fit = BoxFit
          .cover, this.placeholder = 'assets/placeHolder.png'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(

      placeholder: (context, url) =>
          Image.asset(placeholder ?? 'assets/placeHolder.png', height: height,
              width: width,
              fit: BoxFit.cover),
      imageUrl: image,
      fadeInDuration: const Duration(milliseconds: 200),
      fit: fit ?? BoxFit.cover,
      height: height,
      width: width,
      errorWidget: (c, o, s) =>
          Image.asset(placeholder?? 'assets/placeHolder.png', height: height,
              width: width,
              fit: BoxFit.cover),
    );
  }
}