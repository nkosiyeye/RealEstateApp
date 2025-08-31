
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_estate_app/common/widgets/property/property_card_horizontal.dart';
import 'package:real_estate_app/common/widgets/shimmer/horizontal_product_shimmer.dart';
import 'package:real_estate_app/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:real_estate_app/ui/screens/search/widget/filter_screen.dart';
import 'package:real_estate_app/ui/screens/search/widget/property_card.dart';

import '../../../common/widgets/appbar/appbar.dart';
import '../../../utils/constants/sizes.dart';
import '../../controller/property_controller.dart';
import '../search/SearchScreen.dart';

class PropertiesScreen extends StatelessWidget {
  const PropertiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PropertyController());

    return Scaffold(
      appBar: TAppBar(
        title: Text(
          'Explore Properties',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => Get.to(() => SearchScreen()),
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => Get.to(() => FilterScreen()),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Obx(() {
          if (controller.isLoading.value && controller.properties.isEmpty) {
            return const TVerticalProductShimmer(itemCount: 5);
          }

          if (controller.properties.isEmpty && !controller.hasMore.value && !controller.isLoading.value) {
            return const Center(child: Text("No properties found."));
          }

          return RefreshIndicator(
            onRefresh: () async {
              await controller.fetchProperties(isInitialFetch: true); // Refresh logic
            },
            child: NotificationListener<ScrollNotification>(
              onNotification: (scrollInfo) {
                if (scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent - 200 &&
                    !controller.isFetchingMore.value &&
                    controller.hasMore.value) {
                  controller.fetchProperties(isInitialFetch: false);
                }
                return false;
              },
              child: ListView.builder(
                itemCount: controller.properties.length + (controller.hasMore.value && controller.isFetchingMore.value ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < controller.properties.length) {
                    final property = controller.properties[index];
                    return TPropertyCardHorizontal(property: property);
                  } else {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                },
              ),
            ),
          );
        }),
      ),
    );
  }
}
