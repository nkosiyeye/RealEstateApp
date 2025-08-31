import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:real_estate_app/ui/personalization/controller/add_property_controller.dart';
import 'package:real_estate_app/utils/constants/colors.dart';
import 'package:real_estate_app/utils/constants/sizes.dart';
import '../../../../../common/widgets/shimmer/category_shimmer.dart';
import '../../../../model/category_model.dart';

class TGridCategories extends StatelessWidget {
  final Function(CategoryModel category) onTapCategory;
  final String selectedCategory;

  const TGridCategories({
    super.key,
    required this.onTapCategory,
    required this.selectedCategory, this.mainAxisExtent = 100, this.crossAxisSpacing = 10, this.mainAxisSpacing = 10,
  });

  final double? mainAxisExtent;
  final double? crossAxisSpacing;
  final double? mainAxisSpacing ;

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(AddPropertyController());
    return Obx(() {
      if (categoryController.isLoading.value) return const TCategoryShimmer();
      if (categoryController.allCategories.isEmpty) {
        return Center(
          child: Text(
            'No Data Found',
            style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white),
          ),
        );
      }
      return GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: categoryController.allCategories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_, index) {
          final category = categoryController.allCategories[index];
          final isSelected = selectedCategory == category.name;

          return GestureDetector(
            onTap: () => onTapCategory(category),
            child: Container(
              decoration: BoxDecoration(
                color: isSelected ? TColors.primary : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? TColors.primary : Colors.grey.shade300,
                  width: 1,
                ),
                boxShadow: [
                  if (isSelected)
                    BoxShadow(
                      color: TColors.primary.withOpacity(0.2),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.network(
                    category.image,
                    width: 32,
                    height: 32,
                    fit: BoxFit.contain,
                    color: isSelected ? Colors.white : null,),
                  const SizedBox(height: 8),
                  Text(
                    category.name,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      );

      /*GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 4,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero, // Ensure no padding is applied
            children: const [
              Feature(icon: Icons.bed, label: 'Bedroom', value: '4 Rooms'),
              Feature(icon: Icons.garage, label: 'Parking', value: '1 Garage'),
              Feature(icon: Icons.bathtub, label: 'Bathroom', value: '3 Rooms'),
              Feature(icon: Icons.weekend, label: 'Reception', value: '1 Reception'),
              Feature(icon: Icons.kitchen, label: 'Kitchen', value: '1 Kitchen'),
              Feature(icon: Icons.square_foot, label: 'Area', value: '1,079 sqft'),
            ],
          ),*/
    });
  }
}