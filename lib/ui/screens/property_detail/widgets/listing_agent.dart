
import 'package:flutter/material.dart';

import '../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../model/property_model.dart';

class ListingAgentTile extends StatelessWidget {
  const ListingAgentTile({
    super.key,
    required this.dark,
    required this.property,
  });

  final bool dark;
  final PropertyModel property;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start, // Ensure proper alignment
      children: [
        /// Thumbnail, Wishlist Button, Promoted Tag
        TRoundedContainer(
          height: 70,
          padding: const EdgeInsets.all(TSizes.sm),
          backgroundColor: dark ? TColors.dark : TColors.light,
          child: Stack(
            children: [
              /// -- Thumbnail Image
              TRoundedImage(
                width: 70,
                height: 70,
                isNetworkImage: true,
                imageUrl: property.user?.profilePicture == '' ? TImages.profileImage : property.user!.profilePicture,
                applyImageRadius: true,
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
                      property.user?.fullName ?? "",
                      style: Theme.of(context).textTheme.bodyLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems / 3),
                    Row(
                      children: [
                        const Icon(Icons.phone,
                            size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            property.user?.phoneNumber ?? '',
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
              ],
            ),
          ),
        ),
      ],
    );
  }
}