import 'package:flutter/material.dart';
import 'package:get/get.dart';

showSnackBarWidget({required String title, String? message}) {
  Get.snackbar(
    title,
    message ?? '',
    animationDuration: Duration(milliseconds: 500),
    margin: EdgeInsets.only(bottom: 50, right: 20, left: 20),
    icon: Icon(
      Icons.done_outline_rounded,
      color: Colors.green,
    ),
  );
}
