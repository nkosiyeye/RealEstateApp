import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../../common/widgets/icons/t_circular_icon.dart';
import '../../../../../../../utils/constants/colors.dart';
import '../../../../../controller/property/favourites_controller.dart';

class TFavouriteIcon extends StatelessWidget {
  const TFavouriteIcon({
    super.key, required this.propertyId, this.width, this.height,this.size,
  });
  final String propertyId;
  final double? width,height,size;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavouritesController());
    return Obx(
      () => TCircularIcon(
        width: width,
          height: height,
          size: size,
          icon: controller.isFavourite(propertyId) ? Iconsax.heart5 : Iconsax.heart,
          color: controller.isFavourite(propertyId) ? TColors.error : null,
          onPressed: () => controller.toggleFavouriteProduct(propertyId),),
    );
  }
}
