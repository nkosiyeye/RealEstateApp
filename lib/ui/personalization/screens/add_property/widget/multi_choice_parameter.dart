import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../controller/add_property_controller.dart';
import 'package:get/get.dart';


class TMultiChoiceParameter extends StatelessWidget {
  const TMultiChoiceParameter({
    super.key,
    required this.options,
    required this.controller,
    required this.heading,
  });

  final List<String> options;
  final String heading;
  final AddPropertyController controller;

  @override
  Widget build(BuildContext context) {
    controller.initOption(heading); // Initialize

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(heading, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Obx(() => Wrap(
          spacing: 8,
          children: options.map((label) {
            final isSelected = controller.selectedExtraFacilities[heading]?.contains(label) ?? false;
            return FilterChip(
              label: Text(label, style: TextStyle(color: isSelected ? Colors.white : Colors.black)),
              selected: isSelected,
              onSelected: (selected) {
                controller.toggleOption(heading, label);
              },
              backgroundColor: Colors.white,
              selectedColor: TColors.primary,
            );
          }).toList(),
        )),
      ],
    );
  }
}
