import 'package:flutter/material.dart';
import 'package:news_app/src/config/app_colors.dart';

Widget bottomBarView({
  @required int? index,
  @required Function()? onOnePressed,
  @required Function()? onSecondPressed,
  @required Function()? onThirdPressed,
}) {
  return Container(
    decoration: BoxDecoration(color: AppColors.accentColor, borderRadius: BorderRadius.circular(50)),
    padding: const EdgeInsets.symmetric(vertical: 10),
    margin: const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        bottomBarTabView(
          isSelected: index == 1,
          title: "Home",
          iconData: Icons.home,
          onPressed: onOnePressed,
        ),
        bottomBarTabView(
          isSelected: index == 2,
          title: "Search",
          iconData: Icons.explore,
          onPressed: onSecondPressed,
        ),
        bottomBarTabView(
          isSelected: index == 3,
          title: "Filter",
          iconData: Icons.sort_rounded,
          onPressed: onThirdPressed,
        ),
      ],
    ),
  );
}

Widget bottomBarTabView({
  @required bool? isSelected,
  @required String? title,
  @required IconData? iconData,
  @required Function()? onPressed,
}) {
  return InkWell(
    onTap: onPressed,
    borderRadius: BorderRadius.circular(8),
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            colors: isSelected! ? [AppColors.lightRedColor, AppColors.skinColor] : [AppColors.iconColor, AppColors.iconColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )),
      child: Icon(
        iconData,
        size: 30,
        color: AppColors.whiteColor,
      ),
    ),
  );
}
