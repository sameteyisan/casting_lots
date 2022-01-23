import 'package:casting_lots/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.textEditingController,
    required this.hintText,
    required this.showPrefix,
    required this.numberOrString,
  }) : super(key: key);

  final TextEditingController textEditingController;
  final String hintText;
  final bool showPrefix;
  final bool numberOrString;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      keyboardType: numberOrString ? TextInputType.text : TextInputType.number,
      decoration: InputDecoration(
          suffixIcon: IconButton(
            splashRadius: 20,
            onPressed: textEditingController.clear,
            icon: const Icon(
              LineAwesomeIcons.broom,
              color: Colorss.mainColor,
            ),
          ),
          prefixIcon: showPrefix
              ? const Icon(
                  LineAwesomeIcons.plus,
                  color: Colorss.mainColor,
                  size: 20,
                )
              : null,
          border: UnderlineInputBorder(borderRadius: BorderRadius.circular(8)),
          hintText: hintText),
    );
  }
}
