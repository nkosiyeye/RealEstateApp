import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import '../../../../../common/widgets/icons/t_circular_icon.dart';
import '../../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../controller/property/images_controller.dart';
import '../../../model/property_model.dart';
import '../../../screens/home/widgets/products_cards/favourite_icon/favourite_icon.dart';

class TPropertyImageSlider extends StatelessWidget {
  const TPropertyImageSlider({
    super.key, required this.property,
  });

  final PropertyModel property;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(ImagesController());
    //final images = controller.getAllProductImages(product);
    return TCustomEdgeWidget(
      child: Container(
        color: dark ? TColors.black : TColors.textWhite,
        child: Stack(
          children: [
            /// Main Large Image
            SizedBox(
              height: 400,
              child: Center(
                child: Obx(
                        (){
                      controller.ThumbnailImage.value = controller.getPropertyImage(property);
                      return GestureDetector(
                        onTap: () => controller.showEnlargedImage(controller.ThumbnailImage.value),
                        child: CachedNetworkImage(
                            height: 400,
                            width: double.infinity,
                            fit: BoxFit.fill,
                            imageUrl: controller.ThumbnailImage.value,
                            progressIndicatorBuilder: (_, __, downloadProgress) =>
                                SizedBox(height:40, width: 40,child: CircularProgressIndicator(value: downloadProgress.progress, color: TColors.primary,))
                        ),
                      );
                    }),
              ),
            ),

            /// Appbar Icons
            TAppBar(
              showBackArrow: true,
              showCircleIcon: true,
              actions: [TFavouriteIcon(propertyId: property.id,)],
            )
          ],
        ),
      ),
    );
  }
}