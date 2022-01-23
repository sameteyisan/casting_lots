import 'package:casting_lots/service/sqflite.dart';
import 'package:get/get.dart';

class CastingController extends GetxController {
  RxList candidateList = [].obs;
  RxList winnerList = [].obs;
  RxList myLots = <TaskModel>[].obs;

  RxString currentLocale = "English".obs;
}
