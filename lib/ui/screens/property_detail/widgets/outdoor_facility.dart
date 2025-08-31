import 'package:flutter/material.dart';
import 'package:real_estate_app/ui/model/property_model.dart';

import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../personalization/screens/add_property/widget/icon_container.dart';


class OutdoorFacility extends StatelessWidget {
  const OutdoorFacility({super.key, required this.property});

  final PropertyModel property;

  @override
  Widget build(BuildContext context) {
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
    return Container(
      alignment: Alignment.center,
      child: TGridLayout(
          mainAxisExtent: 90,
          mainAxisSpacing: 0,
          crossAxisSpacing: 0,
          crossAxisCount: 3,
          itemCount: property.assignedOutdoorFacility!.length,
          itemBuilder: (_,index) =>
              Column(
                children: [
                  TIconContainer(Icons:
                  placeIcons[property.assignedOutdoorFacility![index].name] ?? Icons.location_on
                  ),
                  const SizedBox(height: 5,),
                  Text(
                    property.assignedOutdoorFacility![index].name!,
                    style: const TextStyle(
                      fontSize: TSizes.fontSizeSm,
                      fontWeight: FontWeight.w400,
                      color: TColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 1,),
                  Text(
                    "${property.assignedOutdoorFacility![index].distance.toString()} km",
                    style: const TextStyle(
                      fontSize: TSizes.fontSizeSm,
                      fontWeight: FontWeight.w400,
                      color: TColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              )
        // Feature(label: property.parameters![index].name!,
        // value: property.parameters![index].value!.toString())
      ),
    );
  }
}
