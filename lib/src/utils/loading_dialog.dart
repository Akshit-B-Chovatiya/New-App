import 'package:flutter/material.dart';
import 'package:news_app/src/config/app_colors.dart';

void showLoadingDialog({@required BuildContext? context}) {
  Future.delayed(const Duration(seconds: 0), () {
    showDialog(
        context: context!,
        barrierDismissible: false,
        builder: (context) {
          return Center(
            child: Material(
              color: AppColors.transparentColor,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(10)),
                child: CircularProgressIndicator(
                  strokeWidth: 4.0,
                  color: AppColors.backgroundColor,
                  backgroundColor: AppColors.accentColor.withOpacity(0.2),
                  valueColor: const AlwaysStoppedAnimation(AppColors.accentColor),
                ),
              ),
            ),
          );
        });
  });
}

void hideLoadingDialog({@required BuildContext? context}) {

  Navigator.pop(context!);
}
