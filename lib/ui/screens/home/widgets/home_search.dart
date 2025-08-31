import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:real_estate_app/utils/constants/colors.dart';
import 'package:real_estate_app/utils/responsiveSize.dart';

import '../../../../../utils/constants/AppIcon.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/ui_utils.dart';
import '../../search/SearchScreen.dart';

class HomeSearchField extends StatelessWidget {
  const HomeSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildSearchIcon() {
      return Padding(
          padding: const EdgeInsets.all(8.0),
          child: UiUtils.getSvg(AppIcons.search,
              color: TColors.primary));
    }

    return Padding(
      padding:
      const EdgeInsets.symmetric(horizontal: TSizes.sidePadding),
      child: Row(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: ()=> Get.to(() => SearchScreen()),
            child: AbsorbPointer(
              absorbing: true,
              child: Container(
                  width: 285.rw(
                    context,
                  ),
                  height: 50.rh(
                    context,
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 1, color: TColors.light),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: TColors.textWhite),
                  child: TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        border: InputBorder.none, //OutlineInputBorder()
                        fillColor: TColors.textWhite,
                        hintText: "Search for properties",
                        prefixIcon: buildSearchIcon(),
                        prefixIconConstraints:
                        const BoxConstraints(minHeight: 5, minWidth: 5),
                      ),
                      enableSuggestions: true,
                      onEditingComplete: () {
                        FocusScope.of(context).unfocus();
                      },
                      onTap: () {
                        //change prefix icon color to primary
                      })),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              //Navigator.pushNamed(context, Routes.propertyMapScreen);
            },
            child: Container(
              width: 50.rw(context),
              height: 50.rh(context),
              decoration: BoxDecoration(
                border:
                Border.all(width: 1.5, color: TColors.borderSecondary),
                color: TColors.textWhite,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: UiUtils.getSvg(
                  AppIcons.propertyMap,
                  color: TColors.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}