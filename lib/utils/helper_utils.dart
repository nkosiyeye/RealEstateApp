import 'dart:convert';
import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';



class HelperUtils {

  static Future<void> precacheSVG(List<String> urls) async {
    bool isSvgUrl(String url) {
      // Convert the URL to lowercase for a case-insensitive check
      final lowercaseUrl = url.toLowerCase();

      // Check if the URL ends with ".svg"
      return lowercaseUrl.endsWith('.svg');
    }

    for (String imageUrl in urls) {
      if (isSvgUrl(imageUrl)) {
        // SvgNetworkLoader loader = SvgNetworkLoader(imageUrl);
        // ByteData byteData = await svg.cache
        //     .putIfAbsent(loader.cacheKey(null), () => loader.loadBytes(null));
        // await precachePicture(
        //   NetworkPicture(
        //     SvgPicture.svgByteDecoderBuilder,
        //     imageUrl,
        //   ),
        //   null,
        // );
      } else {
        continue;
      }
    }
  }


}
