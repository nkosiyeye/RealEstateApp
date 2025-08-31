import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:real_estate_app/ui/personalization/screens/add_property/add_property_step1.dart';
import 'package:real_estate_app/ui/personalization/screens/profile/profile.dart';
import '../../../common/widgets/appbar/appbar.dart';
import '../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../common/widgets/list_tiles/settings_menu_tiles.dart';
import '../../../common/widgets/list_tiles/user_profile_title.dart';
import '../../../common/widgets/section_heading.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../controller/logout_controller.dart';
import 'my_property/my_properties.dart';
class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LogoutController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// -- Header
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  TAppBar(
                    title: Text('Account', style: Theme.of(context).textTheme.headlineMedium!.apply(color: TColors.textWhite),),),
                  const SizedBox(height: TSizes.spaceBtwItems/3,),

                  /// User Profile Card
                  TUserProfileTitle(onPressed: ()=> Get.to(() => const ProfileScreen()),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections,)
                ],
              ),
            ),
            /// -- Body
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  /// -- Account Settings
                  const TSectionHeading(title: 'Account Settings', showActionButton: false,),
                  const SizedBox(height: TSizes.spaceBtwItems,),

                  TSettingMenuTile(
                    icon: Iconsax.message,
                    title: "My Enquiry",
                    subTitle: "View and manage your inquiries",
                    onTap: (){},
                  ),
                  TSettingMenuTile(
                    icon: Iconsax.heart,
                    title: "Favourites",
                    subTitle: "View your saved properties",
                    onTap: (){},
                  ),
                  TSettingMenuTile(
                    icon: Iconsax.notification_bing,
                    title: "Notification",
                    subTitle: "Manage your notification preferences",
                    onTap: (){},
                  ),
                  TSettingMenuTile(
                    icon: Iconsax.additem,
                    title: "My Properties",
                    subTitle: "Manage your properties",
                    onTap: () => Get.to(() => const MyProperties()),
                  ),
                  TSettingMenuTile(
                    icon: Iconsax.shield_tick,
                    title: "Account Privacy",
                    subTitle: "Control your privacy settings",
                    onTap: (){},
                  ),

                  /// -- App Settings
                  const SizedBox(height: TSizes.spaceBtwSections,),
                  const TSectionHeading(title: 'App Settings', showActionButton: false,),
                  const SizedBox(height: TSizes.spaceBtwItems,),
                  const TSettingMenuTile(icon: Iconsax.document_upload, title: "Load Data", subTitle: 'Upload Data to your Cloud Firebase'),
                  TSettingMenuTile(icon: Iconsax.location, title: "Geolocation", subTitle: 'Set recommendation based on location', trailing: Switch(value: true, onChanged: (value){}),),
                  TSettingMenuTile(icon: Iconsax.security, title: "Safe Mode", subTitle: 'Search result is safe for all ages', trailing: Switch(value: false, onChanged: (value){}),),
                  TSettingMenuTile(icon: Iconsax.image, title: "HD Image quality", subTitle: 'set image quality to be seen', trailing: Switch(value: false, onChanged: (value){}),),

                  /// -- Logout Button
                  const SizedBox(height: TSizes.spaceBtwSections,),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(onPressed: () => controller.logout()
                        ,
                        child: const Text('Logout')
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}