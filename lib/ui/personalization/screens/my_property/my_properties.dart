import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:real_estate_app/common/widgets/appbar/appbar.dart';
import 'package:real_estate_app/ui/personalization/controller/add_property_controller.dart';
import 'package:real_estate_app/ui/personalization/controller/my_properties_controller.dart';
import 'package:real_estate_app/ui/personalization/screens/add_property/add_property_step1.dart';
import 'package:real_estate_app/ui/screens/personalization/profile/screens/SettingsScreen.dart';
import 'package:real_estate_app/utils/constants/colors.dart';

import '../../../../common/widgets/property/property_card_horizontal.dart';
import '../../../../navigation_menu.dart';

class MyProperties extends StatelessWidget {
  const MyProperties({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AddPropertyController());
    var myPropertiesController = Get.put(MyPropertiesController());

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: TAppBar(
          title: Text('My Properties'),
          actions: [
            IconButton(
              icon: const Icon(Icons.house),
              onPressed: () {
                Get.to(() => const NavigationMenu());
              },
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                myPropertiesController.refreshProperties();
              },
            ),
          ],
        ),
        body: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(text: 'For Sale'),
                Tab(text: 'For Rent'),
              ],
            ),
            Expanded(
              child: Obx(() {
                final properties = myPropertiesController.properties;
                final forSale = properties.where((p) => p.properyType == 'Sale').toList();
                final forRent = properties.where((p) => p.properyType == 'Rent').toList();

                return RefreshIndicator(
                  onRefresh: () async {
                    await myPropertiesController.refreshProperties();
                  },
                  child: TabBarView(
                    children: [
                      // For Sale Tab
                      ListView.builder(
                        itemCount: forSale.length,
                        itemBuilder: (context, index) {
                          final property = forSale[index];
                          return TPropertyCardHorizontal(property: property);
                        },
                      ),
                      // For Rent Tab
                      ListView.builder(
                        itemCount: forRent.length,
                        itemBuilder: (context, index) {
                          final property = forRent[index];
                          return TPropertyCardHorizontal(property: property);
                        },
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          backgroundColor: TColors.primary,
          foregroundColor: Colors.white,
          overlayOpacity: 0.4,
          children: [
            SpeedDialChild(
              child: const Icon(Icons.sell, color: Colors.white),
              backgroundColor: TColors.primary,
              label: 'For Sale',
              labelStyle: const TextStyle(fontSize: 16.0, color: Colors.white),
              labelBackgroundColor: Colors.teal.shade700,
              onTap: () {
                controller.propertyType.value = 'Sale';
                Get.to(() => const AddPropertyStep1());
              },
            ),
            SpeedDialChild(
              child: const Icon(Icons.car_rental, color: Colors.white),
              backgroundColor: TColors.primary,
              label: 'For Rent',
              labelStyle: const TextStyle(fontSize: 16.0, color: Colors.white),
              labelBackgroundColor: Colors.teal.shade700,
              onTap: () {
                controller.propertyType.value = 'Rent';
                Get.to(() => const AddPropertyStep1());
              },
            ),
          ],
        ),
      ),
    );
  }
}
