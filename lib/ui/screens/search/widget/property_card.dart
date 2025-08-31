import 'package:flutter/material.dart';
import 'package:real_estate_app/ui/screens/home/widgets/products_cards/favourite_icon/favourite_icon.dart';
import 'package:real_estate_app/utils/constants/colors.dart';

import '../../../model/property_model.dart';

class PropertyCard extends StatelessWidget {
  final PropertyModel item;

  const PropertyCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)),
            child: item.titleImage != null
                ? Image.network(
              item.titleImage!,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            )
                : Container(
              width: 100,
              height: 100,
              color: Colors.grey[300],
              child: Icon(Icons.home, size: 40),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (item.promoted == true)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: TColors.accent,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text('Featured', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                  const SizedBox(height: 4),
                  Text(item.price, style: const TextStyle(color: TColors.primary, fontWeight: FontWeight.bold)),
                  Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          "${item.address ?? ''}",
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: TFavouriteIcon(propertyId: item.id),
          ),
        ],
      ),
    );
  }
}
