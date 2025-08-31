import 'package:flutter/material.dart';
import 'package:real_estate_app/ui/screens/home/widgets/products_cards/product_card_vertical.dart';

import '../../../model/property_model.dart';

class HorizontalPropertyList extends StatelessWidget {
  final List<PropertyModel> properties;

  const HorizontalPropertyList({
    super.key,
    required this.properties,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent, // Transparent background
      child: SizedBox(
        height: 270, // Fixed height for the horizontal list
        child: ListView.builder(
          scrollDirection: Axis.horizontal, // Horizontal scrolling
          itemCount: properties.length,
          itemBuilder: (context, index) {
            final property = properties[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0), // Spacing between cards
              child: TPropertyCardVertical(
                property: property,
                additionalImageWidth: 120,
                showLikeButton: true,
                statusButton: StatusButton(
                  label: "For Rent", // Example label
                  color: Colors.blue, // Background color of the button
                  textColor: Colors.white, // Text color of the button
                ), // Default to true // Default additional width
              ),
            );
          },
        ),
      ),
    );
  }
}