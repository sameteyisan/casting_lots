import 'package:casting_lots/controllers/casting_controller.dart';
import 'package:get/get.dart';

class GlobalBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(CastingController());
  }
}
