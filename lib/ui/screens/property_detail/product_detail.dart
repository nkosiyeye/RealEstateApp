import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:real_estate_app/ui/model/property_model.dart';
import 'package:real_estate_app/ui/personalization/screens/add_property/widget/icon_container.dart';
import 'package:real_estate_app/ui/screens/property_detail/widgets/bottom_interest_widget.dart';
import 'package:real_estate_app/ui/screens/property_detail/widgets/image_slider.dart';
import 'package:real_estate_app/ui/screens/property_detail/widgets/listing_agent.dart';
import 'package:real_estate_app/ui/screens/property_detail/widgets/outdoor_facility.dart';
import 'package:real_estate_app/ui/screens/property_detail/widgets/product_detail_image_slider.dart';
import 'package:real_estate_app/ui/screens/property_detail/widgets/property_meta_data.dart';
import 'package:real_estate_app/utils/constants/image_strings.dart';
import 'package:real_estate_app/utils/extensions/build_context.dart';

import '../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../common/widgets/images/t_rounded_image.dart';
import '../../../common/widgets/layouts/grid_layout.dart';
import '../../../common/widgets/section_heading.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import 'package:readmore/readmore.dart';
import 'package:get/get.dart';

import '../all_properties/all_properties.dart';


class PropertyDetail extends StatelessWidget {
  const PropertyDetail({super.key, required this.property});
  final PropertyModel property;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      bottomNavigationBar: BottomInterestWidget(propertyModel: property),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPropertyImageSlider(property: property,),
            Padding(
              padding: const EdgeInsets.only(right: TSizes.defaultSpace, left: TSizes.defaultSpace, bottom: TSizes.defaultSpace),
              child: Column(
                children: [
                  PropertyMetaData(property: property,),
                  const SizedBox(height: TSizes.spaceBtwItems,),
                  /// Description
                  const TSectionHeading(title: 'About This Property', showActionButton: false,),
                  const SizedBox(height: TSizes.spaceBtwItems - 2,),
                  ReadMoreText(
                    property.description ?? '',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: ' Show more',
                    trimExpandedText: ' Less',
                    moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: TColors.primary),
                    lessStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: TColors.primary),
                  ),


                  const SizedBox(height: TSizes.spaceBtwSections,),
                  TSectionHeading(title: 'Listing Agent', showActionButton: true, onPressed: (){
                    Get.to(() =>
                        AllProperties(
                          title: '${property.user?.fullName} Properties',
                          query: FirebaseFirestore.instance.collection('Properties').where('addedBy', isEqualTo: property.user?.id),
                        )
                    );
                  },),
                  ListingAgentTile(dark: dark, property: property),
                  const SizedBox(height: TSizes.spaceBtwItems,),
                  const TSectionHeading(title: 'Outdoor Facilities', showActionButton: false,),
                  const SizedBox(height: TSizes.spaceBtwItems,),
                  OutdoorFacility(property: property,),
                  const SizedBox(height: TSizes.spaceBtwItems,),
                  const TSectionHeading(title: 'Gallery', showActionButton: false,),
                  const SizedBox(height: TSizes.spaceBtwItems,),
                  ImageSlider(property: property),
                  const SizedBox(height: TSizes.spaceBtwItems,),
                ],
              ),
            )

          ]
        ),
      ),
    );
  }
}

