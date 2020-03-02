import 'package:cached_network_image/cached_network_image.dart';
import 'package:extra/utils/colors.dart';
import 'package:extra/utils/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

class ImageNetwork extends StatelessWidget {
  String url;
  double w;
  double h;


  ImageNetwork(this.url,
      {this.w = Sizes.IMAGE_SIZE_PROFILE, this.h = Sizes.IMAGE_SIZE_PROFILE});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        height: h,
        width: w,
        imageUrl: url,
        imageBuilder: (context, imageProvider) =>
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                    colorFilter:
                    ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
              ),
            ),
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error)
    );
  }
}
