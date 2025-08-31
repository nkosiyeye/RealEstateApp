import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:real_estate_app/utils/constants/string_extenstion.dart';
import 'package:real_estate_app/utils/extensions/build_context.dart';
import 'package:real_estate_app/utils/extensions/textWidgetExtention.dart';

import '../../../../../../common/style/shadows.dart';
import '../../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../../common/widgets/promoted_widget.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/constant.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/helpers/helper_functions.dart';
import '../../../../../../utils/ui_utils.dart';
import '../../../../controller/property_controller.dart';
import '../../../../model/property_model.dart';
import '../../../property_detail/product_detail.dart';
import 'favourite_icon/favourite_icon.dart';

class TPropertyCardVertical extends StatelessWidget {
  const TPropertyCardVertical({super.key, required this.property, this.statusButton, this.additionalImageWidth, this.showLikeButton, this.width, this.height});

  final PropertyModel property;
  final StatusButton? statusButton;
  final double? additionalImageWidth;
  final double? width;
  final double? height;
  final bool? showLikeButton;

  @override
  Widget build(BuildContext context) {
    String rentPrice = (property.price
        .priceFormate(
      //disabled: Constant.isNumberWithSuffix == false,
    )
        .toString()
        .formatAmount(prefix: true)
    );

    if (property.rentduration != "" && property.rentduration != null) {
      rentPrice =
          ("$rentPrice / ") + (property.rentduration?? "");
    }
    //final controller = PropertyController.instance;
    //final salePercentage = controller.calculateSalePercentage(product.price, product.salePrice);
    final dark = THelperFunctions.isDarkMode(context);return GestureDetector(
      onTap: () {}, // Add your navigation logic here
      child: GestureDetector(
        onTap: () => Get.to(() => PropertyDetail(property: property)),
        child: Container(
          width: width ?? 220,
          height: height ?? 300,
          decoration: BoxDecoration(
            color: dark ? TColors.darkerGrey : TColors.textWhite,
            borderRadius: BorderRadius.circular(TSizes.productImageRadius),
            boxShadow: [TShadowStyle.verticalProductShadow],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image with tags
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(TSizes.productImageRadius),
                    ),
                    child: UiUtils.getImage(
                      property.titleImage ?? "",
                      height: 157,
                      width: width ?? 220,
                      fit: BoxFit.cover,
                    ),
                  ),
                  if (property.promoted ?? false)
                    const Positioned(
                      top: 8,
                      left: 8,
                      child: PromotedCard(type: PromoteCardType.icon),
                    ),
                  /// --- Favourite Icon Button
                  Positioned(// Reduced by half
                    top: 0,
                    right: 0,
                    child: TFavouriteIcon(propertyId: property.id,size: 15, height: 30,width: 30,),
                  ),
                  Positioned(
                    bottom: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        property.properyType ?? '',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: context.font.smaller,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Details
              Padding(
                padding: const EdgeInsets.all(TSizes.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category
                    Row(
                      children: [
                        UiUtils.imageType(
                          property.category.image,
                          width: TSizes.fontSizeXs,
                          height: TSizes.fontSizeXs,
                          color: TColors.accent,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            property.category.name,
                            style: const TextStyle(
                              fontSize: TSizes.fontSizeXs,
                              fontWeight: FontWeight.w300,
                              color: TColors.textSecondary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),

                    // Price
                    Text(
                      (property.properyType?.toLowerCase() == "rent"
                          ? rentPrice
                          : property.price
                          .priceFormate(disabled: !Constant.isNumberWithSuffix)
                          .toString()
                          .formatAmount(prefix: true)) ??
                          '',
                      style: TextStyle(
                        fontSize: TSizes.fontSizeSm,
                        fontWeight: FontWeight.w700,
                        color: TColors.primary,
                      ),
                      maxLines: 1,
                    ),
                    const SizedBox(height: 4),

                    // Title
                    Text(
                      property.title.firstUpperCase(),
                      style: TextStyle(
                        fontSize: TSizes.fontSizeSm,
                        color: TColors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),

                    // City
                    if ((property.city ?? '').isNotEmpty)
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: TSizes.fontSizeXs,
                            color: TColors.textSecondary,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              property.city!.trim(),
                              style: TextStyle(
                                fontSize: TSizes.fontSizeXs,
                                color: TColors.textSecondary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}

class StatusButton {
  final String label;
  final Color color;
  final Color? textColor;
  StatusButton({
    required this.label,
    required this.color,
    this.textColor,
  });
}










