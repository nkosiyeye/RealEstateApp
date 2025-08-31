import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:real_estate_app/ui/screens/home/widgets/products_cards/product_card_vertical.dart';

import '../../../../ui/controller/all_properties_controller.dart';
import '../../../../ui/model/property_model.dart';
import '../../../../utils/constants/sizes.dart';
import '../../layouts/grid_layout.dart';

class TSortableProperties extends StatelessWidget {
  const TSortableProperties({
    super.key, required this.properties,
  });
  final List<PropertyModel> properties;

  @override
  Widget build(BuildContext context) {
    // Initialize controller for managing product sorting
    final controller = Get.put(AllPropertiesController());
    controller.assignProducts(properties);
    return Column(
      children: [
        /// Dropdown
        DropdownButtonFormField(
            decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
            items: ['Name', 'Higher Price', 'Lower Price']
                .map((option) => DropdownMenuItem(value: option,child: Text(option)),
            ).toList(),
            value: controller.selectedSortOption.value,
            onChanged: (value){
              // sort products based on the selected option
              controller.sortProducts(value!);
            }
        ),
        const SizedBox(height: TSizes.spaceBtwItems,),
        Obx(() => TGridLayout(itemCount: controller.properties.length, itemBuilder: (_, index) => TPropertyCardVertical(property: controller.properties[index]) ))
      ],
    );
  }
}

