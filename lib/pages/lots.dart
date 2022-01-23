import 'package:casting_lots/controllers/casting_controller.dart';
import 'package:casting_lots/service/sqflite.dart';
import 'package:casting_lots/utils/button.dart';
import 'package:casting_lots/utils/colors.dart';
import 'package:casting_lots/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

class Lots extends GetView<CastingController> {
  const Lots({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("my_lots".tr),
          leading: backButton,
        ),
        body: Obx(
          () => controller.myLots.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.myLots.length,
                  itemBuilder: (context, index) {
                    dynamic lot = controller.myLots[index];
                    return Center(
                      child: Dismissible(
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) async {
                          final TodoHelper _td = TodoHelper();
                          await _td.initDatabase();
                          await _td.deleteTask(lot.id);
                          List<TaskModel> allLots = await _td.getAllTask();
                          controller.myLots.value = allLots;
                          showToast("lot_deleted".tr);
                        },
                        key: UniqueKey(),
                        background: Container(
                          color: Colorss.mainColor,
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              LineAwesomeIcons.trash,
                              color: Colorss.white,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
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
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Ink(
                                    child: Material(
                                      color: Colorss.black,
                                      child: InkWell(
                                        onTap: () {
                                          controller.candidateList.clear();

                                          List toBeSend =
                                              lot.kuraList.split(",");
                                          toBeSend.remove(
                                              toBeSend[toBeSend.length - 1]);

                                          controller.candidateList.value =
                                              toBeSend;
                                          Get.back();
                                        },
                                        child: IntrinsicHeight(
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            constraints: BoxConstraints(
                                              maxHeight: double.infinity,
                                            ),
                                            alignment: Alignment.center,
                                            child: Column(
                                              children: [
                                                Text(
                                                  lot.name,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colorss.white,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Text(
                                                  lot.kuraList,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colorss.white,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset("assets/lottie/empty.json"),
                      Text(
                        "no_lots_found".tr,
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
        ));
  }
}
