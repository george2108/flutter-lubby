import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

enum TypeSnackbar { success, warning, error }

class CustomSnackBarWidget extends SnackBar {
  final String title;
  final String? description;
  final TypeSnackbar type;
  final Duration durationSnackBar;

  CustomSnackBarWidget({
    super.key,
    required this.title,
    this.description,
    this.type = TypeSnackbar.success,
    this.durationSnackBar = const Duration(seconds: 3),
  }) : super(
          content: _showCustomSnackBarWidget(
            title: title,
            content: description,
            type: type,
            duration: durationSnackBar,
          ),
          duration: durationSnackBar,
          dismissDirection: DismissDirection.down,
          backgroundColor: Colors.transparent,
          elevation: 0,
          margin: const EdgeInsets.only(
            left: 20.0,
            right: 10.0,
          ),
          behavior: SnackBarBehavior.floating,
        );
}

_showCustomSnackBarWidget({
  required String title,
  String? content,
  TypeSnackbar type = TypeSnackbar.success,
  Duration? duration = const Duration(seconds: 3),
}) {
  final mainColor = type == TypeSnackbar.success
      ? const Color.fromARGB(255, 108, 237, 188)
      : type == TypeSnackbar.error
          ? Colors.red
          : Colors.yellow;

  final Color mainForegroundColor =
      type == TypeSnackbar.error ? Colors.white : Colors.black;

  final mainLottieFile = type == TypeSnackbar.success
      ? 'assets/done.json'
      : type == TypeSnackbar.error
          ? 'assets/failed.json'
          : 'assets/warning.json';

  return Stack(
    clipBehavior: Clip.none,
    children: [
      Container(
        padding: const EdgeInsets.all(5),
        width: double.infinity,
        height: 90,
        decoration: BoxDecoration(
          color: mainColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 45),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: mainForegroundColor,
                    ),
                  ),
                  Text(
                    content ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: mainForegroundColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      Positioned(
        top: -10,
        left: -20,
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: mainColor,
            shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                blurRadius: 5,
                offset: Offset(5, 5),
              ),
            ],
          ),
          child: Lottie.asset(
            mainLottieFile,
            repeat: false,
            width: 50,
            height: 50,
            fit: BoxFit.fill,
          ),
        ),
      ),
    ],
  );
}
