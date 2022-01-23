import 'package:casting_lots/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'controllers/global_bindings.dart';
import 'service/localization_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: LocalizationService().locale,
      fallbackLocale: LocalizationService().fallbackLocale,
      translations: LocalizationService(),
      debugShowCheckedModeBanner: false,
      initialBinding: GlobalBindings(),
      builder: EasyLoading.init(),
      title: 'Casting Lots',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomeScreen(),
    );
  }
}
