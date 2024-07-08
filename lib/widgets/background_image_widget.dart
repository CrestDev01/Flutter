import 'package:flutter/material.dart';

import '../utils/functions_utils.dart';
import 'image_widget_util.dart';
import 'responsive_widget.dart';

class BackgroundImageWidget extends StatelessWidget {
  final String image;

  const BackgroundImageWidget({Key? key, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: getWindowHeight(),
      width: getWindowWidth(),
      child: Stack(
        children: [
          imgAssetWidget(
            '$image.png',
            width: double.infinity,
            boxFit: BoxFit.cover,
          ),
          imgAssetWidget(
            'img_splash_overlay.png',
            width: double.infinity,
            boxFit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}

class BackgroundImageContentWidget extends StatelessWidget {
  final Widget child;
  final String image;

  const BackgroundImageContentWidget(
      {Key? key, required this.image, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      child: Stack(
        fit: StackFit.expand,
        children: [
          //Background Image
          // Positioned(
          //   top: 0,
          //   child: BackgroundImageWidget(
          //     image: image,
          //   ),
          // ),
          //Content
          child
        ],
      ),
    );
  }
}
