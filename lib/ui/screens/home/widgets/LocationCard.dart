import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_estate_app/utils/constants/colors.dart';
import 'package:real_estate_app/utils/constants/image_strings.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../personalization/controller/user_controller.dart';

class LocationCard extends StatelessWidget {
  const LocationCard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return Container(
      padding: EdgeInsets.symmetric(horizontal: TSizes.sidePadding),
      margin: EdgeInsets.only(
        top: TSizes.spaceBtwSections,
        left: TSizes.sidePadding,
        right: TSizes.sidePadding,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        /*boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],*/
      ),
      child: Row(
        children: [
          // Location Icon
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.all(8),
            child: Icon(Icons.location_on, color: TColors.primary),
          ),
          SizedBox(width: 12),

          // Location Texts
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Location',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Text(
                  'Mbabane, Hhohho, Eswatini',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),

          // Profile Image
          CircleAvatar(
            radius: 24,
            backgroundImage:
                controller.user.value.profilePicture == ''
                    ? const AssetImage(TImages.profileImage)
                    : NetworkImage(controller.user.value.profilePicture),
          ),
        ],
      ),
    );
  }
}
