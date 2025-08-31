import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:real_estate_app/utils/constants/image_strings.dart';
import 'package:get/get.dart';
import '../../../ui/personalization/controller/user_controller.dart';
import '../../../utils/constants/colors.dart';
import '../images/t_circular_image.dart';

class TUserProfileTitle extends StatelessWidget {
  const TUserProfileTitle({
    super.key, required this.onPressed,
  });
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return ListTile(
      leading: TCircularImage(
        image: controller.user.value.profilePicture,
        width: 50,
        height: 50,
        padding: 0,
        isNetworkImage: true,
      ),
      title: Text(controller.user.value.fullName
        ,
        style: Theme.of(context).textTheme.headlineSmall!.apply(color: TColors.textWhite),),
      subtitle: Text(controller.user.value.email
        ,
        style: Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.textWhite),),
      trailing: IconButton(onPressed: onPressed, icon: const Icon(Iconsax.edit), color: TColors.textWhite,),
    );
  }
}