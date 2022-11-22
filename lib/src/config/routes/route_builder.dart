import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteBuilder {
  static navigate(Widget pageView) {
    return Platform.isIOS
        ? CupertinoPageRoute(builder: (_) => pageView)
        : MaterialPageRoute(builder: (_) => pageView);
    /* return Platform.isIOS
        ? CupertinoPageRoute(builder: (_) => pageView)
        : PageRouteBuilder(
            pageBuilder: ((context, animation, _) => FadeTransition(
                  opacity: animation,
                  child: pageView,
                )),
          ); */
  }
}
