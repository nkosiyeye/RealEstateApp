import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_estate_app/ui/screens/property_detail/product_detail.dart';
import 'package:real_estate_app/utils/constants/string_extenstion.dart';
import 'package:real_estate_app/utils/extensions/build_context.dart';
import 'package:real_estate_app/utils/ui_utils.dart';

import '../../../ui/model/property_model.dart';
import '../../../ui/screens/home/widgets/products_cards/favourite_icon/favourite_icon.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/constant.dart';
import '../../../utils/constants/sizes.dart';
import '../custom_shapes/containers/rounded_container.dart';
import '../images/t_rounded_image.dart';
import '../promoted_widget.dart';



class TPropertyCardHorizontal extends StatelessWidget {
  const TPropertyCardHorizontal({super.key, required this.property});

  final PropertyModel property;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
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

    return GestureDetector(
      onTap: () => Get.to(() => PropertyDetail(property: property)),
      child: Container(
        height: 120,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: dark ? TColors.darkerGrey : TColors.lightContainer,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start, // Ensure proper alignment
          children: [
            /// Thumbnail, Wishlist Button, Promoted Tag
            TRoundedContainer(
              height: 120,
                padding: const EdgeInsets.all(TSizes.sm),
                backgroundColor: dark ? TColors.dark : TColors.light,
                child: Stack(
                  children: [
                    /// -- Thumbnail Image
                    TRoundedImage(
                      width: 130,
                      height: 120,
                      isNetworkImage: true,
                      imageUrl: property.titleImage ?? '',
                      applyImageRadius: true,
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
              ),

            /// Details
            Expanded( // Use Expanded to ensure proper layout in Row
              child: Padding(
                padding: const EdgeInsets.only(top: TSizes.sm, left: TSizes.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Title and Address
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          property.title,
                          style: Theme.of(context).textTheme.bodyLarge,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: TSizes.spaceBtwItems / 3),
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
                        const SizedBox(height: TSizes.spaceBtwItems / 3),
                        Row(
                          children: [
                            const Icon(Icons.location_on_outlined,
                                size: 14, color: Colors.grey),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                "${property.address}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .apply(color: Colors.grey),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems/2,),
                    // Price
                    Text(
                      (property.properyType?.toLowerCase() == "rent"
                          ? rentPrice
                          : property.price
                          .priceFormate(disabled: !Constant.isNumberWithSuffix)
                          .toString()
                          .formatAmount(prefix: true)) ??
                          '',
                      style: const TextStyle(
                        fontSize: TSizes.fontSizeSm,
                        fontWeight: FontWeight.w700,
                        color: TColors.primary,
                      ),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}