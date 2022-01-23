import 'dart:ui';
import 'package:casting_lots/controllers/casting_controller.dart';
import 'package:casting_lots/pages/lots.dart';
import 'package:casting_lots/pages/results.dart';
import 'package:casting_lots/service/localization_service.dart';
import 'package:casting_lots/service/sqflite.dart';
import 'package:casting_lots/utils/colors.dart';
import 'package:casting_lots/utils/toast.dart';
import 'package:casting_lots/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends GetView<CastingController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("appName".tr),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: _changeLang,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(
                  () => Text(
                    controller.currentLocale.value == "Türkçe"
                        ? "🇹🇷"
                        : "🏴󠁧󠁢󠁥󠁮󠁧󠁿",
                    style: TextStyle(fontSize: 40),
                  ),
                )),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
        child: Column(
          children: [
            CustomTextField(
              textEditingController: controller.controllerCandidate,
              hintText: "candidate_not_entered".tr,
              showPrefix: true,
              numberOrString: true,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(
                () => Row(
                  children: [
                    _button(Colorss.green, "add".tr),
                    SizedBox(
                      width: controller.candidateList.isEmpty ? 0 : 8,
                    ),
                    controller.candidateList.isEmpty
                        ? const SizedBox()
                        : _button(Colorss.mainColor, "clear".tr)
                  ],
                ),
              ),
            ),
            Obx(
              () => Text(
                "added_candidate_count".tr +
                    "${controller.candidateList.length}",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
            Obx(
              () => Expanded(
                child: controller.candidateList.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.candidateList.length,
                        itemBuilder: (context, index) {
                          return Center(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("${index + 1}:  "),
                                  Text(controller.candidateList[index]),
                                  IconButton(
                                    highlightColor: Colorss.mainColor,
                                    splashRadius: 20,
                                    iconSize: 20,
                                    icon: const Icon(LineAwesomeIcons.trash),
                                    onPressed: () {
                                      controller.candidateList.remove(
                                          controller.candidateList[index]);
                                    },
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset("assets/lottie/empty.json"),
                          Text(
                            "nothing_added".tr,
                            style: TextStyle(
                              color: Colorss.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(
                () => Row(
                  children: [
                    controller.candidateList.isEmpty
                        ? _button(Colorss.mainColor, "show_lots".tr)
                        : _button(Colorss.mainColor, "save_lot".tr),
                    SizedBox(
                      width: controller.candidateList.isEmpty ? 0 : 8,
                    ),
                    controller.candidateList.isEmpty
                        ? const SizedBox()
                        : _button(Colorss.green, "start_lots".tr)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _changeLang() {
    if (controller.currentLocale.value == "English") {
      LocalizationService().changeLocale("Türkçe");
      controller.currentLocale.value = "Türkçe";
    } else {
      LocalizationService().changeLocale("English");
      controller.currentLocale.value = "English";
    }
  }

  Expanded _button(Color color, String text) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color,
          onPrimary: Colorss.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () async {
          if (text == "add".tr) {
            final cont = controller.controllerCandidate.text.trim();
            if (cont.isNotEmpty) {
              if (!cont.contains(",")) {
                if (!controller.candidateList.contains(cont)) {
                  controller.candidateList.add(cont);
                  controller.controllerCandidate.clear();
                } else {
                  showToast("already_exists".tr);
                }
              } else {
                showToast("cannot_have".tr);
              }
            } else {
              showToast("candidate_not_entered".tr);
            }
          } else if (text == "clear".tr) {
            controller.candidateList.clear();
            showToast("clear_added".tr);
          } else if (text == "show_lots".tr) {
            final TodoHelper _td = TodoHelper();
            await _td.initDatabase();
            List<TaskModel> listLots = await _td.getAllTask();
            controller.myLots.value = listLots;
            Get.to(const Lots());
          } else if (text == "start_lots".tr) {
            startLots;
          } else if (text == "cancel".tr) {
            Get.back();
          } else if (text == "save_lot".tr) {
            saveLots;
          } else if (text == "save".tr) {
            String send = "";
            final TodoHelper _td = TodoHelper();
            await _td.initDatabase();

            for (var i = 0; i < controller.candidateList.length; i++) {
              send += controller.candidateList[i] + ", ";
            }

            _td.insertTask(
              TaskModel(
                kuraList: send,
                name: controller.controllerField.text.trim(),
              ),
            );
            Get.back();
            showToast("lot_saved".tr);
          } else if (text == "continue".tr) {
            final cont = controller.controllerField.text.trim();
            if (cont.isNotEmpty) {
              try {
                int contN = int.parse(cont);
                if (contN > controller.candidateList.length || contN <= 0) {
                  showToast("enter_valid_value".tr);
                } else {
                  List shuffle = controller.candidateList;
                  controller.winnerList.clear();
                  shuffle.shuffle();

                  for (var i = 0; i < shuffle.length; i++) {
                    if ((controller.winnerList.length == contN)) break;
                    controller.winnerList.add(shuffle[i]);
                  }

                  Get.back();
                  Get.to(const Results());
                }
              } catch (_) {
                showToast("enter_valid_value".tr);
              }
            }
          }
        },
        child: Text(text),
      ),
    );
  }

  Future<String?> get startLots => showDialog<String>(
        context: Get.context!,
        builder: (BuildContext context) {
          return BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 4.0,
              sigmaY: 4.0,
            ),
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              title: Text(
                "choice_question".trParams(
                    {"value": controller.candidateList.length.toString()}),
                style: TextStyle(fontSize: 17),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextField(
                    textEditingController: controller.controllerField,
                    hintText: "number_candidate".tr,
                    showPrefix: false,
                    numberOrString: false,
                  )
                ],
              ),
              actions: [
                _button(Colorss.mainColor, "cancel.tr"),
                _button(Colorss.green, "continue".tr),
              ],
            ),
          );
        },
      ).whenComplete(() => controller.controllerField.clear());

  Future<String?> get saveLots => showDialog<String>(
        context: Get.context!,
        builder: (BuildContext context) {
          return BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 4.0,
              sigmaY: 4.0,
            ),
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              title: Text(
                "enter_lot_name".tr,
                style: TextStyle(fontSize: 17),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextField(
                    textEditingController: controller.controllerField,
                    hintText: "lot_name".tr,
                    showPrefix: false,
                    numberOrString: true,
                  )
                ],
              ),
              actions: [
                _button(Colorss.mainColor, "cancel".tr),
                _button(Colorss.green, "save".tr),
              ],
            ),
          );
        },
      ).whenComplete(() => controller.controllerField.clear());
}
