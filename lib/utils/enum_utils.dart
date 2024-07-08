import 'package:flutter/material.dart';

import 'colors_utils.dart';
import 'constant_utils.dart';

//Flavor Enum
enum FlavorEnum { dev, prod }

extension FlavorEnumExt on FlavorEnum {
  String get value {
    switch (this) {
      case FlavorEnum.dev:
        return "dev";
      case FlavorEnum.prod:
        return "prod";
    }
  }
}

enum QuestionType { textfield, number, option, date }

extension QuestionTypeExt on QuestionType {
  String get value {
    switch (this) {
      case QuestionType.textfield:
        return CheckListType.TEXT_FIELD;
      case QuestionType.number:
        return CheckListType.NUMBER;
      case QuestionType.option:
        return CheckListType.OPTIONS;
      case QuestionType.date:
        return CheckListType.DATE;
      default:
        return StringUtils.TEXT_FIELD;
    }
  }
}

extension StringExtension on String? {
  QuestionType toEnum() {
    switch (this) {
      case CheckListType.TEXT_FIELD:
        return QuestionType.textfield;
      case CheckListType.NUMBER:
        return QuestionType.number;
      case CheckListType.OPTIONS:
        return QuestionType.option;
      case CheckListType.DATE:
        return QuestionType.date;
      default:
        return QuestionType.textfield;
    }
  }
}

//Message status Enum
enum MessageStatusEnum { success, error, warning }

extension MessageStatusExt on MessageStatusEnum {
  Color get color {
    switch (this) {
      case MessageStatusEnum.success:
        return ColorsUtils.colorGreen;
      case MessageStatusEnum.error:
        return ColorsUtils.colorRed;
      case MessageStatusEnum.warning:
        return ColorsUtils.colorAmber;
    }
  }
}
