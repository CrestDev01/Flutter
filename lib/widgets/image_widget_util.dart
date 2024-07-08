import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../base_classes/base_text.dart';
import '../translations/locale_keys.g.dart';
import '../utils/colors_utils.dart';
import '../utils/dimensions_utils.dart';
import '../utils/fonts_utils.dart';
import '../utils/validation_utils.dart';
import 'progress_indicator_widget_util.dart';

class ImageUtil {
  static const String pathImages = "assets/graphics/images/";
  static const String pathSvgImages = "assets/graphics/svgs/";
  static const String svgExt = ".svg";
}

//Load SVG image from asset
Widget svgImgAssetWidget(String svgName,
    {double? width,
    double? height,
    Color? color,
    BoxFit boxFit = BoxFit.contain,
    BlendMode colorBlendMode = BlendMode.srcIn,
    bool showLoader = true}) {
  return SvgPicture.asset(
    "${ImageUtil.pathSvgImages}$svgName${ImageUtil.svgExt}",
    width: width,
    height: height,
    color: color,
    fit: boxFit,
    colorBlendMode: colorBlendMode,
    placeholderBuilder: (BuildContext context) => Visibility(
      visible: showLoader,
      child: SizedBox(
        width: width,
        height: height,
        child: Center(
          child: circularProgressIndicatorWidget(),
        ),
      ),
    ),
  );
}

//Load jpg/png/other image from asset
Image imgAssetWidget(String imgName,
    {Key? key,
    double? width,
    double? height,
    Color? color,
    BoxFit boxFit = BoxFit.contain,
    BlendMode colorBlendMode = BlendMode.srcIn}) {
  return Image.asset(
    "${ImageUtil.pathImages}$imgName",
    width: width,
    height: height,
    color: color,
    fit: boxFit,
    colorBlendMode: colorBlendMode,
    key: key,
    errorBuilder: (_, __, ___) {
      return Container(
        width: width,
        height: height,
        color: Colors.red,
        padding: const EdgeInsets.all(dim20),
        child: BaseText(
            text: LocaleKeys.failed_load_img.tr(), myFont: MyFont.bold),
      );
    },
  );
}

//Load image from network (From url)
Image networkImgWidget(String imgUrl,
    {double? width,
    double? height,
    Color? color,
    bool isCustomError = false,
    bool isColorFilter = false,
    BoxFit boxFit = BoxFit.contain}) {
  return Image.network(
    imgUrl,
    width: width,
    height: height,
    color: color,
    fit: boxFit,
    loadingBuilder:
        (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
      if (loadingProgress == null) return child;
      return SizedBox(
        width: width,
        height: height,
        child: Center(
          child: circularProgressIndicatorWidget(),
        ),
      );
    },
    errorBuilder: (_, __, ___) {
      return Container(
        width: width,
        height: height,
        color: Colors.red,
        padding: const EdgeInsets.all(20.0),
        child: BaseText(
          text: LocaleKeys.failed_load_img.tr(),
          myFont: MyFont.bold,
          fontSize: dim14,
          textAlign: TextAlign.center,
        ),
      );
    },
  );
}

//Load image from network (From url) (Cached image)
Widget cachedNetworkImgWidget(
  String imgUrl, {
  double? width,
  double? height,
  Color? color,
  bool isSimmerPlaceholder = false,
  bool isCustomError = false,
  bool isColorFilter = false,
  bool isForProfileImage = false,
  bool isPlanLogo = false,
}) {
  return CachedNetworkImage(
      imageUrl: imgUrl,
      width: width,
      height: height,
      imageBuilder: (context, imageProvider) => Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
                colorFilter: isColorFilter
                    ? ColorFilter.mode(
                        Colors.black.withOpacity(0.5), BlendMode.darken)
                    : null,
              ),
            ),
          ),
      placeholder: (context, url) => (isSimmerPlaceholder)
          ? SizedBox(
              height: height,
              width: width,
              child: LinearProgressIndicator(
                color: Colors.grey.shade200,
                backgroundColor: Colors.grey.shade100,
              ),
            )
          : Center(child: circularProgressIndicatorWidget()),
      errorWidget: (context, url, error) {
        if (isForProfileImage) {
          return svgImgAssetWidget('ic_account_fill',
              height: height, width: width, boxFit: BoxFit.cover);
        } else if (isPlanLogo) {
          return SizedBox(
            width: width,
            height: height,
            child: imgAssetWidget("plan_placeholder.jpg"),
          );
        } else {
          if (isCustomError) {
            return Container(color: ColorsUtils.colorBlack);
          } else {
            return Container(
              color: Colors.red,
              padding: const EdgeInsets.all(dim20),
              child: BaseText(
                  text: LocaleKeys.failed_load_img.tr(), myFont: MyFont.bold),
            );
          }
        }
      });
}

Widget cachedNetworkImgForGridWidget(
  String imgUrl, {
  double? width,
  double? height,
  Color? color,
  bool isSimmerPlaceholder = false,
  bool isCustomError = false,
  bool isColorFilter = false,
  bool isForProfileImage = false,
  bool isPlanLogo = false,
}) {
  return FractionallySizedBox(
    widthFactor: 1,
    heightFactor: 1,
    child: CachedNetworkImage(
      imageUrl: imgUrl,
      // width: width, // Remove width and height to let it take available space
      // height: height,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
            colorFilter: isColorFilter
                ? ColorFilter.mode(
                    Colors.black.withOpacity(0.5),
                    BlendMode.darken,
                  )
                : null,
          ),
        ),
      ),
      placeholder: (context, url) => (isSimmerPlaceholder)
          ? SizedBox(
              height: height,
              width: width,
              child: LinearProgressIndicator(
                color: Colors.grey.shade200,
                backgroundColor: Colors.grey.shade100,
              ),
            )
          : Center(child: circularProgressIndicatorWidget()),
      errorWidget: (context, url, error) {
        if (isForProfileImage) {
          return svgImgAssetWidget(
            'ic_account_fill',
            height: height,
            width: width,
            boxFit: BoxFit.cover,
          );
        } else if (isPlanLogo) {
          return SizedBox(
            width: width,
            height: height,
            child: imgAssetWidget("plan_placeholder.jpg"),
          );
        } else {
          if (isCustomError) {
            return Container(color: ColorsUtils.colorBlack);
          } else {
            return Container(
              color: Colors.red,
              padding: const EdgeInsets.all(dim20),
              child: BaseText(
                  text: LocaleKeys.failed_load_img.tr(), myFont: MyFont.bold),
            );
          }
        }
      },
    ),
  );
}

//Load image from file
Image imgFileWidget(File imgFile, {double? width, double? height}) {
  return Image.file(
    imgFile,
    fit: BoxFit.cover,
    width: width,
    height: height,
    errorBuilder: (_, __, ___) {
      return Container(
        width: width,
        height: height,
        color: Colors.red,
        padding: const EdgeInsets.all(dim20),
        child: BaseText(
            text: LocaleKeys.failed_load_img.tr(), myFont: MyFont.bold),
      );
    },
  );
}

//Circle image
Widget circleImgWidget(
    {String? imgUrl,
    File? file,
    double? radius,
    double? fileRadius,
    double? netWorkHeight,
    double? netWorkWidth}) {
  return !imgUrl.isNullEmptyString()
      ? ClipRRect(
          borderRadius: BorderRadius.circular(radius ?? 100000),
          child: cachedNetworkImgWidget(imgUrl!,
              height: netWorkHeight,
              width: netWorkWidth,
              isSimmerPlaceholder: true,
              isForProfileImage: true),
        )
      : file != null
          ? CircleAvatar(
              backgroundImage: imgFileWidget(file).image,
              radius: fileRadius ?? dim30,
            )
          : Container(
              height: dim60,
              width: dim60,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: ColorsUtils.colorGrey1,
              ),
            );
}
