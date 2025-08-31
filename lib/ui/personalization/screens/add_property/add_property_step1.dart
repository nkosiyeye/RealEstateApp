import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_estate_app/common/widgets/appbar/appbar.dart';
import 'package:real_estate_app/ui/personalization/screens/add_property/add_property_step2.dart';
import 'package:real_estate_app/ui/personalization/screens/add_property/widget/add_property_categories.dart';

import '../../../../utils/constants/sizes.dart';
import '../../controller/add_property_controller.dart';

class AddPropertyStep1 extends StatelessWidget {
  const AddPropertyStep1({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddPropertyController.instance;
    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace, vertical: TSizes.defaultSpace / 2),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              if(controller.selectedPropertyCategory.value.name.isNotEmpty) {
                // Proceed to the next step
                Get.to(() => const AddPropertyStep2());
              }else{
                // Show a message to select a category
                Get.snackbar('Error', 'Please select a property type',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red.withOpacity(0.8),
                  colorText: Colors.white,
                );
              }
            },
            child: const Text('Next'),
          ),
        ),
      ),
      appBar: const TAppBar(
        showBackArrow: true,
        title: Text('Add Property'),
        actions: [
          Text("1/4", style: TextStyle(color: Colors.black54, fontSize: 16)),
        ],
      ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 60.0), // Add padding to avoid overlap
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => TGridCategories(
                    onTapCategory: (category) {
                      controller.selectedPropertyCategory.value = category;
                    },
                    selectedCategory: controller.selectedPropertyCategory.value.name,
                  )),
                ],
              ),
            ),
          ],
        )
    );
  }
}
