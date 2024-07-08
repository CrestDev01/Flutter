import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../base_classes/base_text.dart';
import '../utils/colors_utils.dart';
import '../utils/dimensions_utils.dart';
import '../utils/fonts_utils.dart';

class RadioButtonWidget extends StatefulWidget {
  final String? text;
  final Function(String) onToggle;
  MyFont myFont;
  String value;
  String groupValue;
  Widget? childWidget;

  RadioButtonWidget({
    Key? key,
    required this.text,
    required this.onToggle,
    required this.value,
    required this.groupValue,
    this.childWidget,
    this.myFont = MyFont.regular,
  }) : super(key: key);

  @override
  State<RadioButtonWidget> createState() => _RadioButtonWidgetState();
}

class _RadioButtonWidgetState extends State<RadioButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: dim20,
          width: dim30,
          child: Radio(
            value: widget.value,

            fillColor: MaterialStateColor.resolveWith(
                (states) => ColorsUtils.colorBase),

            //side: const BorderSide(width: 0, color: ColorsUtils.colorBlack),
            onChanged: (value) {
              setState(() {
                widget.value = value!;
                widget.onToggle(widget.value);
              });
            },
            groupValue: widget.groupValue,
          ),
        ),
        const SizedBox(width: dim6),
        widget.childWidget != null
            ? Expanded(
                child: InkWell(
                  child: widget.childWidget,
                  onTap: () {
                    widget.onToggle(widget.value);
                  },
                ),
              )
            : InkWell(
                onTap: () {
                  widget.onToggle(widget.value);
                },
                child: widget.childWidget ??
                    BaseText(
                      text: widget.text,
                      myFont: widget.myFont,
                    ),
              ),
      ],
    );
  }
}
