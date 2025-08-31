import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_estate_app/ui/personalization/screens/add_property/widget/icon_container.dart';
import 'package:real_estate_app/ui/screens/home/HomeScreen.dart';
import 'package:real_estate_app/utils/constants/enums.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controller/add_property_controller.dart';
import '../my_property/my_properties.dart';

class AddPropertyStep4 extends StatelessWidget {
  final AddPropertyController controller = AddPropertyController.instance;

  final Map<String, IconData> placeIcons = {
    'Bus Stop': Icons.directions_bus,
    'School': Icons.school,
    'Garden': Icons.park,
    'Hospital': Icons.local_hospital,
    'Supermarket': Icons.store,
    'Mall': Icons.local_mall,
    'Bank/ATM': Icons.account_balance,
    'Gym': Icons.fitness_center,
    'Gas Station': Icons.local_gas_station,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace, vertical: TSizes.defaultSpace / 2),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
                // Proceed to the next step
                controller.saveProperty();
            },
            child: const Text('Next'),
          ),
        ),
      ),
      appBar: const TAppBar(
        showBackArrow: true,
        title: Text('Add Property'),
        actions: [
          Text(
            "4/4",
            style: TextStyle(color: Colors.black54, fontSize: 16),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Select Places", style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),Obx(() => GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              children: controller.availablePlaces.map((placeInfo) {
                final placeName = placeInfo['name'] as String;
                final icon = placeInfo['icon'] as IconData;
                final isSelected = controller.outdoorFacilities.any((f) => f.name == placeName);

                return GestureDetector(
                  onTap: () => controller.togglePlace(placeName),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? TColors.primary : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: TColors.primary),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(icon, color: isSelected ? Colors.white : TColors.primary),
                        const SizedBox(height: 4),
                        Text(placeName, style: TextStyle(color: isSelected ? Colors.white : TColors.primary, fontSize: 12)),
                      ],
                    ),
                  ),
                );
              }).toList(),
            )),
            const SizedBox(height: TSizes.spaceBtwItems),
          // Distance Input Fields
            Obx(() => Column(
              children: controller.outdoorFacilities.map((facility) {
                final icon = controller.availablePlaces.firstWhere((p) => p['name'] == facility.name)['icon'] as IconData;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      TIconContainer(Icons: icon),
                      const SizedBox(width: 8),
                      Expanded(child: Text(facility.name ?? '')),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 80,
                        child: TextField(
                          controller: controller.getDistanceController(facility.name!),
                          keyboardType: TextInputType.number,
                          onChanged: (value) => controller.updateDistance(facility.name!, value),
                          decoration: const InputDecoration(
                            hintText: '0000',
                            isDense: true,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Text('KM'),
                    ],
                  ),
                );
              }).toList(),
            )),

          ],
        ),
      ),
    );
  }
}


