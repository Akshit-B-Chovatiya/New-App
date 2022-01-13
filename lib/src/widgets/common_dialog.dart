import 'package:flutter/material.dart';
import 'package:news_app/src/config/app_colors.dart';
import 'package:news_app/src/widgets/text_view.dart';

void showErrorDialog(
    {BuildContext? context,
    String title = 'Oops',
    String? message,
    String positiveButtonText = 'Okay',
    String? negativeButtonText,
    GestureTapCallback? positiveButtonTap,
    GestureTapCallback? negativeButtonTap}) {
  showDialog(
    context: context!,
    builder: (BuildContext context) => CommonDialog(
      title: title,
      description: message!,
      positiveButtonText: positiveButtonText,
      negativeButtonText: negativeButtonText ?? '',
      positiveButtonTap: positiveButtonTap!,
      negativeButtonTap: negativeButtonTap!,
    ),
  );
}

class CommonDialog extends StatelessWidget {
  final String? title;
  final String? description;
  final String? positiveButtonText;
  final String? negativeButtonText;
  final String image;

  static const double padding = 16.0;
  static const double avatarRadius = 66.0;

  final GestureTapCallback? positiveButtonTap;
  final GestureTapCallback? negativeButtonTap;

  const CommonDialog({
    Key? key,
    @required this.title,
    @required this.description,
    this.positiveButtonText = "",
    this.negativeButtonText = "",
    this.positiveButtonTap,
    this.negativeButtonTap,
    this.image = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(padding),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: dialogContent(context),
      ),
      onWillPop: () => Future.value(false),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(padding),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5),
                boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 2.0, offset: Offset(0.0, 2.0))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min, // To make the card compact
                children: <Widget>[
                  textLarge(data: title, fontSize: 18, textColor: AppColors.redColor, maxLines: 100),
                  const SizedBox(
                    height: 10,
                  ),
                  textRegular(data: description, textAlign: TextAlign.start, maxLines: 100),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: <Widget>[
                      if (positiveButtonText!.isNotEmpty)
                        Expanded(
                          child: InkWell(
                            onTap: positiveButtonTap ?? () => Navigator.pop(context, true),
                            child: Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(padding / 1.5),
                              decoration: BoxDecoration(
                                color: AppColors.accentColor,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 2.0, offset: Offset(0.0, 2.0))],
                              ),
                              child: textRegular(data: positiveButtonText, textColor: AppColors.whiteColor),
                            ),
                          ),
                        ),
                      if (positiveButtonText!.isNotEmpty && negativeButtonText!.isNotEmpty)
                        const SizedBox(
                          width: 10,
                        ),
                      if (negativeButtonText!.isNotEmpty)
                        Expanded(
                          child: InkWell(
                            onTap: negativeButtonTap ?? () => Navigator.pop(context, false),
                            child: Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(padding / 1.5),
                              decoration: BoxDecoration(
                                color: AppColors.redColor,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 2.0, offset: Offset(0.0, 2.0))],
                              ),
                              child: textRegular(data: negativeButtonText, textColor: AppColors.whiteColor),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
