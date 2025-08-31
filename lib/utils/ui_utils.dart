import 'dart:math';

//import 'package:ebroker/exports/main_export.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:real_estate_app/utils/constants/colors.dart';

import 'constants/constant.dart';
import 'network_to_localsvg.dart';

class UiUtils {
  static BuildContext? _context;

  static void setContext(BuildContext context) {
    _context = context;
  }

  static SvgPicture getSvg(String path,
      {Color? color, BoxFit? fit, double? width, double? height}) {
    return SvgPicture.asset(
      path,
      color: color,
      fit: fit ?? BoxFit.contain,
      width: width,
      height: height,
    );
  }

  static SvgPicture networkSvg(String url, {Color? color, BoxFit? fit, double? width, double? height}) {
    return SvgPicture.network(
      url,
      color: color,
      fit: fit ?? BoxFit.contain,
      width: width,
      height: height,
    );
  }
  static String removeDoubleSlashUrl(String url) {
    Uri uri = Uri.parse(url);
    List<String> segments = List.from(uri.pathSegments);
    segments.removeWhere((element) => element == "");
    return Uri(
        host: uri.host,
        pathSegments: segments,
        scheme: uri.scheme,
        fragment: uri.fragment,
        queryParameters: uri.queryParameters,
        port: uri.port,
        query: uri.query,
        userInfo: uri.userInfo)
        .toString();
  }
  static Widget imageType(String url,
      {double? width, double? height, BoxFit? fit, Color? color}) {
    String? ext = url.split(".").last.toLowerCase();
    if (ext == "svg") {
      return NetworkToLocalSvg().svg(
        UiUtils.removeDoubleSlashUrl(url) ?? "",
        color: color,
        width: 20,
        height: 20,
      );
    } else {
      return getImage(
        url,
        fit: fit,
        height: height,
        width: width,
      );
    }
  }
  static Widget getImage(String url,
      {double? width,
        double? height,
        BoxFit? fit,
        String? blurHash,
        bool? showFullScreenImage}) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: fit,
      width: width,
      height: height,
      placeholder: (context, url) {
        return Container(
          width: width,
          color: TColors.primary.withOpacity(0.1),
          height: height,
          alignment: Alignment.center,
          child: FittedBox(
            child: SizedBox(
              width: 70,
              height: 70,
              child: SvgPicture.asset(
                'assets/images/placeholder_logo.svg', // Replace with your placeholder asset path
                color: TColors.primary,
              ),
            ),
          ),
        );
      },
      errorWidget: (context, url, error) {
        return Container(
          width: width,
          color: TColors.primary.withOpacity(0.1),
          height: height,
          alignment: Alignment.center,
          child: FittedBox(
            child: SizedBox(
              width: 70,
              height: 70,
              child: SvgPicture.asset(
                'assets/images/placeholder_logo.svg', // Replace with your placeholder asset path
                color: TColors.primary, // Replace with a valid tertiary color
              ),
            ),
          ),
        );
      },
    );
  }



}
extension FormatAmount on String {
  String formatAmount({bool prefix = false}) {
    return (prefix)
        ? "${Constant.currencySymbol}${toString()}"
        : "${toString()}${Constant.currencySymbol}"; // \u{20B9}"; //currencySymbol
  }

  String formatDate({
    String? format,
  }) {
    DateFormat dateFormat = DateFormat(format ?? "MMM d, yyyy");
    String formatted = dateFormat.format(DateTime.parse(this));
    return formatted;
  }

  String formatPercentage() {
    return "${toString()} %";
  }

  String formatId() {
    return " # ${toString()} "; // \u{20B9}"; //currencySymbol
  }

  String firstUpperCase() {
    String upperCase = "";
    var suffix = "";
    if (isNotEmpty) {
      upperCase = this[0].toUpperCase();
      suffix = substring(1, length);
    }
    return (upperCase + suffix);
  }
}


