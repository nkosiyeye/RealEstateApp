import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../common/widgets/appbar/appbar.dart';
import '../../../common/widgets/icons/t_circular_icon.dart';
import '../../../common/widgets/layouts/grid_layout.dart';
import '../../../common/widgets/shimmer/vertical_product_shimmer.dart';
import '../../../navigation_menu.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/cloud_helper_functions.dart';
import '../../../utils/loaders/animation_loader.dart';
import '../../controller/property/favourites_controller.dart';
import '../home/HomeScreen.dart';
import '../home/widgets/products_cards/product_card_vertical.dart';


class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavouritesController());
    return Scaffold(
      appBar: TAppBar(
        title: Text('Favourite Properties', style: Theme.of(context).textTheme.headlineMedium,),
        actions: [
          TCircularIcon(icon: Iconsax.add, onPressed: () => Get.to(const HomeScreen()),)
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              Obx(() {
                if (controller.isLoading.value) {
                  return const TVerticalProductShimmer();
                }
                return FutureBuilder(
                  future: controller.favoriteProperties(),
                  builder: (context, snapshot) {
                    /// Nothing found
                    final emptyWidget = TAnimationLoaderWidget(
                      text: 'Whoops Wishlist is Empty...',
                      animation: TImages.pencilAnimation,
                      showAction: true,
                      actionText: 'Let\'s add some',
                      onActionPressed: () => Get.off(() => const NavigationMenu()),
                    );
                    const loader = TVerticalProductShimmer();
                    final widget = TCloudHelperFunctions.checkMultiRecordState(
                      snapshot: snapshot,
                      loader: loader,
                      nothingFound: emptyWidget,
                    );
                    if (widget != null) return widget;
                    // Products found
                    final properties = snapshot.data!;
                    return TGridLayout(
                      itemCount: properties.length,
                      itemBuilder: (_, index) => TPropertyCardVertical(property: properties[index]),
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
