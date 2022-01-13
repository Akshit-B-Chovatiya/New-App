import 'package:flutter/material.dart';
import 'package:news_app/src/config/app_colors.dart';

Widget textRegular({
  @required String? data,
  TextAlign textAlign = TextAlign.start,
  double fontSize = 14,
  Color textColor = AppColors.blackColor,
  FontWeight fontWeight = FontWeight.normal,
  int maxLines = 1,
  double rightPadding = 0,
  double leftPadding = 0,
  double topPadding = 0,
  double bottomPadding = 0,
}) {
  return Container(
    padding: EdgeInsets.only(
      right: rightPadding,
      left: leftPadding,
      bottom: bottomPadding,
      top: topPadding,
    ),
    child: Text(data!,
        style: TextStyle(
          fontSize: fontSize,
          color: textColor,
          fontWeight: fontWeight,
          overflow: TextOverflow.ellipsis,
        ),
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        textAlign: textAlign),
  );
}

Widget textLarge({
  @required String? data,
  TextAlign textAlign = TextAlign.start,
  double fontSize = 18,
  Color textColor = AppColors.blackColor,
  FontWeight fontWeight = FontWeight.w400,
  int maxLines = 1,
  double rightPadding = 0,
  double leftPadding = 0,
  double topPadding = 0,
  double bottomPadding = 0,
}) {
  return Container(
    padding: EdgeInsets.only(
      right: rightPadding,
      left: leftPadding,
      bottom: bottomPadding,
      top: topPadding,
    ),
    child: Text(data!,
        style: TextStyle(
          fontSize: fontSize,
          color: textColor,
          fontWeight: fontWeight,
          overflow: TextOverflow.ellipsis,
        ),
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        textAlign: textAlign),
  );
}

Widget textSmall({
  @required String? data,
  TextAlign textAlign = TextAlign.start,
  double fontSize = 12,
  Color textColor = AppColors.blackColor,
  FontWeight fontWeight = FontWeight.normal,
  int maxLines = 1,
  double rightPadding = 0,
  double leftPadding = 0,
  double topPadding = 0,
  double bottomPadding = 0,
}) {
  return Container(
    padding: EdgeInsets.only(
      right: rightPadding,
      left: leftPadding,
      bottom: bottomPadding,
      top: topPadding,
    ),
    child: Text(data!,
        style: TextStyle(
          fontSize: fontSize,
          color: textColor,
          fontWeight: fontWeight,
          overflow: TextOverflow.ellipsis,
        ),
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        textAlign: textAlign),
  );
}
