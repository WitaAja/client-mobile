import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoaderDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Center(
        child: CupertinoActivityIndicator(),
      ),
    );
  }
}

class Loader {
  static bool isOpen = false;

  static show() {
    isOpen = true;
    Get.dialog(LoaderDialog(), barrierDismissible: false, useRootNavigator: false);
  }

  static dismiss() {
    if (!isOpen) {
      return;
    }
    isOpen = false;
    Get.back();
  }
}
