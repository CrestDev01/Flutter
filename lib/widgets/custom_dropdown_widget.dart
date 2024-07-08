import 'package:flutter/material.dart';

import '../base_classes/base_decoration.dart';
import '../base_classes/base_text.dart';
import '../utils/dimensions_utils.dart';
import '../utils/fonts_utils.dart';

Widget customDropDownWidget({
  required String title,
  required BuildContext context,
  required List<DropdownMenuItem> items,
  required dynamic value,
  required Function(dynamic) onChanged,
  bool isValidationRequired = true,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      BaseText(
        text: title,
        myFont: MyFont.medium,
      ),
      const SizedBox(height: dim6),
      DropdownButtonFormField(
        decoration: BaseInputDecoration(
          context,
          borderRadius: BorderRadius.circular(8),
        ),
        items: items,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (val) {
          if (isValidationRequired) {
            if (val == null) {
              return "Please select $title";
            }
          }
        },
        value: value,
        onChanged: (value) {
          if (value != null) {
            onChanged(value);
          }
        },
      ),
    ],
  );
}
