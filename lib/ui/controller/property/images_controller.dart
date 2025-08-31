import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants/sizes.dart';
import '../../model/property_model.dart';

class ImagesController extends GetxController{
  static ImagesController get instance => Get.find();

  /// Variables
  RxString selectedPropertyImage = ''.obs;
  RxString ThumbnailImage = ''.obs;

  /// -- Get All Images from product and variation
  String getPropertyImage(PropertyModel property){
    // Check if the property has a title image
    ThumbnailImage.value = property.titleImage!;

    return property.titleImage!;
  }

  List<String> getAllPropertyImage(PropertyModel property) {
    // Use Set to add unique images only
    Set<String> images = {};

    // Load title image
    if (property.titleImage != null && property.titleImage!.isNotEmpty) {
      images.add(property.titleImage!);
      // Set the title image as the selected image if not already set
      if (selectedPropertyImage.value.isEmpty) {
        selectedPropertyImage.value = property.titleImage!;
      }
    }

    // Get all images from the gallery if not null
    if (property.gallery != null && property.gallery!.isNotEmpty) {
      images.addAll(property.gallery!.map((galleryItem) => galleryItem.imageUrl));


    }
    print(property.gallery);

    return images.toList();
  }

  /// -- Show Image Popup
  void showEnlargedImage(String image){
    Get.to(
      fullscreenDialog: true,
        () => Dialog.fullscreen(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(padding: const EdgeInsets.symmetric(vertical: TSizes.defaultSpace * 2, horizontal: TSizes.defaultSpace),
                child: CachedNetworkImage(imageUrl: image),
              ),
              const SizedBox(height: TSizes.spaceBtwItems,),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 150,
                  child: OutlinedButton(onPressed: () => Get.back(), child: const Text('Close'),),
                ),
              )
            ],
          ),
        )
    );
  }
}