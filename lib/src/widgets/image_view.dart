import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_app/src/config/app_colors.dart';
import 'package:news_app/src/widgets/text_view.dart';

Widget imageView({
  @required BuildContext? context,
  @required imageURL,
  @required String? title,
  bool? isAssetsImage = false,
  bool? isSvgImage = false,
  Color? borderColor,
  Color? backgroundColor,
  double? height,
  double? width,
  double? rightMargin,
  double? topMargin,
  double? bottomMargin,
  double? leftMargin,
  BoxShape? shape,
  BoxFit? fit,
  Color? svgBackgroundColor,
  BorderRadius? borderRadius,
}) {
  return Container(
    height: height,
    width: width ?? MediaQuery.of(context!).size.width,
    margin: EdgeInsets.only(right: rightMargin ?? 0, bottom: bottomMargin ?? 0, left: leftMargin ?? 0, top: topMargin ?? 0),
    decoration: BoxDecoration(
        shape: shape ?? BoxShape.rectangle,
        color: backgroundColor ?? AppColors.transparentColor,
        borderRadius: shape == null || shape != BoxShape.circle ? borderRadius ?? BorderRadius.circular(10) : null,
        border: Border.all(color: borderColor ?? AppColors.transparentColor, width: borderColor == null ? 0 : 3)),
    child: imageURL != null && imageURL != "null" && imageURL != "" && imageURL.toString().isNotEmpty
        ? (imageURL!.toString().startsWith("http") || imageURL!.toString().startsWith("https"))
            ? ClipRRect(
                borderRadius: borderRadius ?? BorderRadius.circular(shape == null || shape != BoxShape.circle ? 10 : 500),
                child: CachedNetworkImage(
                  height: height ?? MediaQuery.of(context!).size.width / 4,
                  width: width ?? MediaQuery.of(context!).size.width,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => Center(
                    child: textLarge(
                      data: title == null || title == "" ? " " : title[0],
                      textAlign: TextAlign.center,
                    ),
                  ),
                  imageUrl: imageURL,
                  filterQuality: FilterQuality.high,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
                    ),
                  ),
                  placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(
                    color: AppColors.accentColor,
                  )),
                ))
            : isAssetsImage!
                ? ClipRRect(
                    borderRadius: borderRadius ?? BorderRadius.circular(shape == null || shape != BoxShape.circle ? 10 : 500),
                    child: Image.asset(imageURL!,
                        height: height ?? MediaQuery.of(context!).size.width / 4,
                        width: width ?? MediaQuery.of(context!).size.width,
                        fit: BoxFit.fill))
                : isSvgImage!
                    ? ClipRRect(
                        borderRadius: borderRadius ?? BorderRadius.circular(shape == null || shape != BoxShape.circle ? 0 : 500),
                        child: SvgPicture.asset(
                          imageURL!,
                          height: height ?? MediaQuery.of(context!).size.width / 4,
                          width: width ?? MediaQuery.of(context!).size.width,
                          fit: fit ?? BoxFit.fill,
                          color: svgBackgroundColor,
                        ))
                    : ClipRRect(
                        borderRadius: borderRadius ?? BorderRadius.circular(shape == null || shape != BoxShape.circle ? 10 : 500),
                        child: Image.file(
                          File(imageURL!),
                          height: height ?? MediaQuery.of(context!).size.width / 4,
                          width: width ?? MediaQuery.of(context!).size.width,
                          fit: BoxFit.fill,
                        ),
                      )
        : Center(
            child: textLarge(
                data: title == null || title == "" ? " " : title[0], textAlign: TextAlign.center, textColor: AppColors.accentColor, fontSize: 25),
          ),
  );
}
