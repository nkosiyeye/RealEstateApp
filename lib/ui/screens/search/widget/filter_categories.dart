import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_estate_app/utils/constants/colors.dart';
import 'package:real_estate_app/utils/constants/sizes.dart';
import '../../../../../common/widgets/shimmer/category_shimmer.dart';
import '../../../controller/category_controller.dart';
import '../../../model/category_model.dart';

class TFilterCategories extends StatelessWidget {
  final Function(CategoryModel category) onTapCategory;
  final String selectedCategory;

  const TFilterCategories({
    super.key,
    required this.onTapCategory,
    required this.selectedCategory,
  });

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());
    return Obx(() {
      if (categoryController.isLoading.value) return const TCategoryShimmer();
      if (categoryController.featuredCategories.isEmpty) {
        return Center(
          child: Text(
            'No Data Found',
            style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white),
          ),
        );
      }
      return SizedBox(
        height: 80,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: categoryController.featuredCategories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            final category = categoryController.featuredCategories[index];
            final isSelected = selectedCategory == category.name;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: ChoiceChip(
                label: Text(category.name),
                selected: isSelected,
                onSelected: (selected) {
                  if (selected) {
                    onTapCategory(category);
                  }
                },
                selectedColor: TColors.primary,
                backgroundColor: TColors.textWhite,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            );
          },
        ),
      );
    });
  }
}