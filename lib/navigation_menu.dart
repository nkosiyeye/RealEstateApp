import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:real_estate_app/ui/personalization/screens/settings.dart';
import 'package:real_estate_app/ui/screens/home/HomeScreen.dart';
import 'package:real_estate_app/ui/screens/properties/PropertiesScreen.dart';
import 'package:real_estate_app/ui/screens/wishlist/FavouritesScreen.dart';
import 'package:real_estate_app/utils/constants/colors.dart';
import 'package:real_estate_app/utils/helpers/helper_functions.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: Obx(
            () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.selectedIndex.value = index,
          backgroundColor: darkMode ? TColors.black : Colors.white,
          indicatorColor: darkMode ? TColors.light.withOpacity(0.1) : TColors.black.withOpacity(0.1),
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            NavigationDestination(icon: Icon(Iconsax.clipboard), label: 'Properties'),
            NavigationDestination(icon: Icon(Iconsax.heart), label: 'Favourites'),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
          ],
        ),
      ),
      body:Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}


class NavigationController extends GetxController{
  final Rx<int> selectedIndex = 0.obs;

  final screens = [const HomeScreen(),const PropertiesScreen(),const FavouriteScreen(),const SettingScreen()];
}