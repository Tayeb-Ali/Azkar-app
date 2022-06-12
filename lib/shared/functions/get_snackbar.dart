import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

getSnackbar({String title = "رسالة", required String message}) {
  Get.snackbar(
    title,
    message,
    duration: const Duration(seconds: 1),
    icon: Image.asset("assets/images/app_icon.png"),
  );
}
