import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../utils/colors_utils.dart';
import '../utils/dimensions_utils.dart';

Widget circularProgressIndicatorWidget({Color? color}) {
  return kIsWeb
      ? Container()
      : Platform.isIOS
          ? iOSProgressIndicator(color: color)
          : androidProgressIndicator(color: color);
}

//Android circular progress indicator (Material)
Widget androidProgressIndicator({Color? color}) {
  return CircularProgressIndicator(
    color: color ?? ColorsUtils.colorBlue,
    backgroundColor: ColorsUtils.colorBase,
  );
}

//iOS circular progress indicator (Cupertino)
Widget iOSProgressIndicator({Color? color}) {
  return CupertinoActivityIndicator(
    color: color ?? ColorsUtils.colorBase,
    radius: dim25,
  );
}
