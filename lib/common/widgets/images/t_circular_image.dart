import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../shimmer/shimmer.dart';

class TCircularImage extends StatelessWidget {
  const TCircularImage({
    super.key,
    this.width = 56,
    this.height = 56,
    this.padding = TSizes.sm,
    this.fit = BoxFit.cover,
    required this.image,
    this.isNetworkImage = false,
    this.overlayColor,
    this.backgroundColor,
  });

  final double width, height, padding;
  final BoxFit? fit;
  final String image;
  final bool isNetworkImage;
  final Color? overlayColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
          color: backgroundColor ?? (dark ? TColors.black : TColors.textWhite),
          borderRadius: BorderRadius.circular(100)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Center(
          child: isNetworkImage
          ? CachedNetworkImage(
            imageUrl: image,
            fit: fit,
            color: overlayColor,
            progressIndicatorBuilder: (context, url, downloadProgress) => const TShimmerEffect(width: 55, height: 55, radius: 55,),
            errorWidget: (context, url, error) => const Icon(Iconsax.warning_2),
          )
          : Image(
            fit: fit,
            image: AssetImage(image),
            color: overlayColor,
          ),
        ),
      ),
    );
  }
}
