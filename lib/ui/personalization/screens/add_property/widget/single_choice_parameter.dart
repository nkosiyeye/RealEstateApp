import 'package:flutter/material.dart';
import 'package:real_estate_app/ui/personalization/screens/add_property/widget/icon_container.dart';
import 'package:real_estate_app/utils/constants/sizes.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../controller/add_property_controller.dart';
import 'package:get/get.dart';
class TChoiceParameter extends StatelessWidget {
  const TChoiceParameter({
    super.key,
    required this.options,
    required this.controller,
    required this.parameter,
    required this.heading, required this.Icons,
  });

  final List<String> options;
  final TextEditingController parameter;
  final String heading;
  final IconData Icons;
  final AddPropertyController controller;

  @override
  Widget build(BuildContext context) {
    controller.initParameter(heading); // Initialize parameter state

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            TIconContainer(Icons: Icons),
            SizedBox(width: TSizes.spaceBtwItems,),
            Text(heading, style: TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
        const SizedBox(height: 8),
        Obx(() => Wrap(
          spacing: 8,
          children: options.map((label) {
            final isSelected = controller.selectedParameters[heading]?.value == label;
            return ChoiceChip(
              label: Text(label, style: TextStyle(color: isSelected ? TColors.primary : Colors.black)),
              selected: isSelected,
              onSelected: (selected) async {
                if (label == '5+') {
                  await controller.showCustomBedroomDialog(context, parameter, heading);
                } else {
                  controller.selectedParameter = int.tryParse(label);
                  parameter.text = label;
                  controller.updateParameter(heading, label);
                }
              },
              backgroundColor: Colors.white,
              selectedColor: TColors.accent,
            );
          }).toList(),
        )),
      ],
    );
  }
}