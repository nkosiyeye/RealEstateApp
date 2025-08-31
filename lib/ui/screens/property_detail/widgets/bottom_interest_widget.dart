import 'package:flutter/material.dart';
import 'package:real_estate_app/ui/model/property_model.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';

class BottomInterestWidget extends StatelessWidget {
  const BottomInterestWidget({super.key, required this.propertyModel});

  final PropertyModel propertyModel;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace, vertical: TSizes.defaultSpace / 2),
      decoration: BoxDecoration(
          color: dark ? TColors.darkerGrey : TColors.light,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(TSizes.cardRadiusLg),
              topRight: Radius.circular(TSizes.cardRadiusLg)
          )
      ),
      child:
            ElevatedButton(
                onPressed: (){},
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(TSizes.md),
                    backgroundColor: TColors.primary,
                    side: const BorderSide(color: TColors.black)
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.center, // This aligns children vertically in the center
                  mainAxisAlignment: MainAxisAlignment.center, // Or .center, .end, etc. for horizontal alignment
                  children:  [
                    Icon(Icons.thumb_up),
                    SizedBox(width: 8),
                    Text('Interest'),
                  ],
                )
            )
      );
  }
}
