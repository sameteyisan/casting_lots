import 'package:casting_lots/controllers/casting_controller.dart';
import 'package:casting_lots/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomContainer extends GetView<CastingController> {
  const CustomContainer(
    this.index, {
    Key? key,
  }) : super(key: key);
  final index;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IntrinsicHeight(
          child: Container(
            padding: EdgeInsets.all(8),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colorss.black,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              "${index + 1}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colorss.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(
          width: 16,
        ),
        Expanded(
          child: IntrinsicHeight(
            child: Container(
              padding: const EdgeInsets.all(8),
              constraints: BoxConstraints(
                maxHeight: double.infinity,
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colorss.black,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                controller.winnerList[index],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colorss.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
