import 'package:flutter/material.dart';
import 'package:real_estate_app/common/widgets/section_heading.dart';
import 'package:real_estate_app/ui/personalization/controller/user_controller.dart';
import 'package:real_estate_app/ui/screens/home/widgets/LocationCard.dart';
import 'package:real_estate_app/ui/screens/home/widgets/home_categories.dart';
import 'package:real_estate_app/ui/screens/home/widgets/home_properties.dart';
import 'package:real_estate_app/ui/screens/home/widgets/home_search.dart';
import 'package:real_estate_app/ui/screens/home/widgets/products_cards/product_card_vertical.dart';
import 'package:real_estate_app/ui/screens/home/widgets/promo_slider.dart';

import '../../../../../common/widgets/shimmer/vertical_product_shimmer.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import '../../../../../../common/widgets/layouts/grid_layout.dart';

import '../../controller/property_controller.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final propertyController = Get.put(PropertyController());
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: darkMode ? TColors.dark : TColors.primaryBackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: TSizes.spaceBtwItems,),
            const LocationCard(),
            const SizedBox(height: TSizes.spaceBtwItems,),
            const HomeSearchField(),
            const SizedBox(height: TSizes.spaceBtwItems,),
            const TPromoSlider(),
            const THomeCategories(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: TSizes.sidePadding),
              child: TSectionHeading(title: "Premium Properties"),
            ),
            Obx((){
              if(propertyController.isLoading.value) return const TVerticalProductShimmer();
              if(propertyController.featuredPremium.isEmpty){
                return Center(child: Text('No Data Found!', style: Theme.of(context).textTheme.bodyMedium));
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: TSizes.sidePadding),
                child: HorizontalPropertyList(properties: propertyController.featuredPremium),
              );
            }),
            /// --- Heading
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: TSizes.sidePadding),
              child: TSectionHeading(title: 'Most Liked Properties'),
            ),
            /// -- Popular Products
            Obx((){
              if(propertyController.isLoading.value) return const TVerticalProductShimmer();
              if(propertyController.featuredProducts.isEmpty){
                return Center(child: Text('No Data Found!', style: Theme.of(context).textTheme.bodyMedium));
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: TSizes.sidePadding),
                child: TGridLayout(
                    itemCount: propertyController.featuredProducts.length, itemBuilder: (_, index) =>
                    TPropertyCardVertical(property: propertyController.featuredProducts[index],
                        width: 190, height: 162,
                        showLikeButton: true,
                        statusButton: StatusButton(label: "For Rent", color: Colors.blue, textColor: Colors.white,)
                    )
                ),
              );
            })
          ],
        ),
      )
    );
  }
}
