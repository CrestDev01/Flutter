import 'package:flutter/widgets.dart';

class CheckoutQuestionModel {
  TextEditingController questionValue = TextEditingController();
  TextEditingController ansValue = TextEditingController();
  int? id;

  CheckoutQuestionModel({
    required this.questionValue,
    required this.ansValue,
    this.id,
  });
}
