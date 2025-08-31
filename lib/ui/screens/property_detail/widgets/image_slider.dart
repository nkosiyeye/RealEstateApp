import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../controller/property/images_controller.dart';
import '../../../model/property_model.dart';

class ImageSlider extends StatelessWidget {
  const ImageSlider({
    super.key,
    required this.property,
  });
  final PropertyModel property;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(ImagesController());
    return Positioned(
      right: 0,
      bottom: 25,
      left: TSizes.defaultSpace,
      child: SizedBox(
        height: 76, // Fixed height for the slider
        child: Obx(() {
          final images = controller.getAllPropertyImage(property);
          final maxVisibleImages = 4; // Maximum number of images to display
          final hasMoreImages = images.length > maxVisibleImages;

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: hasMoreImages ? maxVisibleImages : images.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 8.0), // Add spacing between items
                child: hasMoreImages && index == maxVisibleImages - 1
                    ? Stack(
                  children: [
                    TRoundedImage(
                      width: 76,
                      height: 76,
                      backgroundColor: dark ? TColors.black : TColors.textWhite,
                      isNetworkImage: true,
                      imageUrl: images[index],
                    ),
                    Positioned.fill(
                      child: Container(
                        color: Colors.black.withOpacity(0.5),
                        child: Center(
                          child: Text(
                            '+${images.length - maxVisibleImages + 1}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
                    : TRoundedImage(
                  width: 76,
                  height: 76,
                  backgroundColor: dark ? TColors.black : TColors.textWhite,
                  isNetworkImage: true,
                  imageUrl: images[index],
                  onPressed: () => controller.showEnlargedImage(images[index]),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}