import 'package:casting_lots/controllers/casting_controller.dart';
import 'package:casting_lots/utils/button.dart';
import 'package:casting_lots/utils/colors.dart';
import 'package:casting_lots/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Results extends GetView<CastingController> {
  const Results({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("results".tr),
          leading: backButton,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              Obx(
                () => Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: controller.winnerList.length,
                    itemBuilder: (context, index) {
                      return Center(
                        child: CustomContainer(index),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 10,
                      );
                    },
                  ),
                ),
              ),
              Row(
                children: [
                  _button("try_again"),
                  SizedBox(width: 8),
                  _button("new_chance")
                ],
              ),
            ],
          ),
        ));
  }

  Expanded _button(String text) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: text == "new_chance" ? Colorss.green : Colorss.mainColor,
          onPrimary: Colorss.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {
          if (text == "try_again") controller.candidateList.clear();
          Get.back();
        },
        child: Text(text.tr),
      ),
    );
  }
}
