import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_estate_app/ui/controller/search_controller.dart';
import 'package:real_estate_app/utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../home/widgets/home_categories.dart';
import 'filter_categories.dart';

class FilterScreen extends StatelessWidget {
  final controller = Get.put(CustomSearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter'),
        actions: [
          TextButton(
            onPressed: () {
              controller.clearFilter();
            },
            child: const Text("Clear Filter"),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Obx(() => ToggleButtons(
                  selectedColor: TColors.textWhite,
                  focusColor: TColors.primary,
                  fillColor: TColors.primary,
                  constraints: BoxConstraints.tightFor(width: constraints.maxWidth / 2),
                  isSelected: [!controller.isRentSelected.value, controller.isRentSelected.value],
                  onPressed: (index) {
                    controller.isRentSelected.value = (index == 1);
                  },
                  children: const [
                    Center(child: Text("Sell")),
                    Center(child: Text("Rent")),
                  ],
                )),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            const Text("Type of Property"),
            Obx(() => TFilterCategories(
              onTapCategory: (category) {
                controller.selectedPropertyType.value = category.name;
              },
              selectedCategory: controller.selectedPropertyType.value,
            )),
            const SizedBox(height: TSizes.spaceBtwSections),
            const Text("Budget (Price)"),
            const SizedBox(height: TSizes.spaceBtwItems),
            Obx(() => RangeSlider(
              values: RangeValues(controller.minPrice.value.toDouble(), controller.maxPrice.value.toDouble()),
              min: 0,
              max: 1000000, // Adjust max value as needed
              divisions: 100,
              labels: RangeLabels(
                controller.minPrice.value.toString(),
                controller.maxPrice.value.toString(),
              ),
              onChanged: (values) {
                controller.minPrice.value = values.start.toInt();
                controller.maxPrice.value = values.end.toInt();
              },
            )),
            const SizedBox(height: TSizes.spaceBtwSections),
            TextField(
              decoration: const InputDecoration(
                labelText: "Select Location (Optional)",
                suffixIcon: Icon(Icons.my_location),
              ),
              onChanged: (val) => controller.selectedLocation.value = val,
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await controller.applyFilters(); // Apply filters and fetch data
                  Get.back(); // Go back to the main list
                },
                child: const Text("Apply Filter"),
              ),
            )
          ],
        ),
      ),
    );
  }
}