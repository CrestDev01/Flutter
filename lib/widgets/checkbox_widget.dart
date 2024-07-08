// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../base_classes/base_text.dart';
import '../utils/colors_utils.dart';
import '../utils/dimensions_utils.dart';
import '../utils/fonts_utils.dart';

class CheckboxWidget extends StatefulWidget {
  final String? text;
  final Function(bool) onToggle;
  bool isSelected;
  MyFont myFont;

  CheckboxWidget({
    Key? key,
    required this.text,
    required this.onToggle,
    required this.isSelected,
    this.myFont = MyFont.regular,
  }) : super(key: key);

  @override
  State<CheckboxWidget> createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      //  mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: dim25,
          width: dim30,
          child: Checkbox(
            value: widget.isSelected,
            checkColor: ColorsUtils.colorWhite,
            fillColor: MaterialStateProperty.all(widget.isSelected
                ? ColorsUtils.colorBase
                : ColorsUtils.colorWhite.withOpacity(0.6)),
            //side: const BorderSide(width: 0, color: ColorsUtils.colorBlack),
            onChanged: (value) {
              setState(() {
                widget.isSelected = value!;
                widget.onToggle(widget.isSelected);
              });
            },
          ),
        ),
        const SizedBox(width: dim6),
        InkWell(
          onTap: () {
            setState(() {
              widget.isSelected = !widget.isSelected;
              widget.onToggle(widget.isSelected);
            });
          },
          child: BaseText(
            text: widget.text,
            myFont: widget.myFont,
          ),
        ),
      ],
    );
  }
}
