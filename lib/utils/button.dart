import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

IconButton get backButton => IconButton(
      splashRadius: 20,
      onPressed: Get.back,
      icon: Icon(LineAwesomeIcons.arrow_left),
    );
