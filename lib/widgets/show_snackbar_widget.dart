import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

enum TypeSnackbar { success, warning, error }

showCustomSnackBarWidget({
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

  return SnackBar(
    content: Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: EdgeInsets.all(5),
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
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      content ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.black,
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
              'assets/done.json',
              repeat: false,
              width: 50,
              height: 50,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ],
    ),
    duration: duration!,
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


/* showCustomSnackBarWidget({
  required String title,
  String? content,
  TypeSnackbar type = TypeSnackbar.success,
  Duration? duration = const Duration(seconds: 2),
}) {
  return SnackBar(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          type == TypeSnackbar.success
              ? Icons.done_outline_rounded
              : type == TypeSnackbar.error
                  ? Icons.cancel_outlined
                  : Icons.warning_amber_outlined,
          color: type == TypeSnackbar.success
              ? Colors.green
              : type == TypeSnackbar.error
                  ? Colors.red
                  : Colors.yellow,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.maxFinite,
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Container(
                width: double.maxFinite,
                child: Visibility(
                  visible: content != null,
                  child: Text(content ?? ''),
                ),
              )
            ],
          ),
        ),
      ],
    ),
    duration: duration!,
    dismissDirection: DismissDirection.down,
    margin: const EdgeInsets.only(
      // bottom: mediaQuery.size.height - mediaQuery.viewInsets.bottom - 100,
      bottom: 50,
      left: 10.0,
      right: 10.0,
    ),
    behavior: SnackBarBehavior.floating,
  );
}
 */