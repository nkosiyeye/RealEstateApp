import 'package:flutter/material.dart';
import 'package:real_estate_app/common/widgets/layouts/grid_layout.dart';
import 'package:real_estate_app/ui/model/property_model.dart';
import 'package:real_estate_app/utils/constants/string_extenstion.dart';
import 'package:real_estate_app/utils/ui_utils.dart';

import '../../../../common/widgets/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/constant.dart';
import '../../../../utils/constants/sizes.dart';

class PropertyMetaData extends StatelessWidget {
  const PropertyMetaData({super.key, required this.property});
  final PropertyModel property;

  @override
  Widget build(BuildContext context) {
    String rentPrice = (property.price
        .priceFormate(
      //disabled: Constant.isNumberWithSuffix == false,
    )
        .toString()
        .formatAmount(prefix: true)
    );

    if (property.rentduration != "" && property.rentduration != null) {
      rentPrice =
          ("$rentPrice / ") + (property.rentduration?? "");
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Category and Sell badge
          Row(
            children: [
              // Category
              Row(
                children: [
                  UiUtils.imageType(
                    property.category.image,
                    width: TSizes.fontSizeSm,
                    height: TSizes.fontSizeSm,
                    color: TColors.accent,
                  ),
                  const SizedBox(width: 5),
                  Text(
                      property.category.name,
                      style: const TextStyle(
                        fontSize: TSizes.fontSizeSm,
                        fontWeight: FontWeight.w300,
                        color: TColors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: TColors.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${property.properyType}',
                  style: const TextStyle(color: TColors.textWhite, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwItems/2,),

          // Title and posted time
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                property.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const Text(
                '4 months ago',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwItems/2,),
          // Price
          Text(
            (property.properyType?.toLowerCase() == "rent"
                ? rentPrice
                : property.price
                .priceFormate(disabled: !Constant.isNumberWithSuffix)
                .toString()
                .formatAmount(prefix: true)) ??
                '',
            style: const TextStyle(
              fontSize: TSizes.fontSizeSm,
              fontWeight: FontWeight.w700,
              color: TColors.primary,
            ),
            maxLines: 1,
          ),

          const SizedBox(height: TSizes.spaceBtwItems/2,),

// Completely remove the SizedBox or reduce its height
          Container(
            alignment: Alignment.center,
            child: TGridLayout(
                mainAxisExtent: 50,
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
                itemCount: property.parameters!.length,
                itemBuilder: (_,index) => Feature(label: property.parameters![index].name!,
                    value: property.parameters![index].value!.toString())),
          )
          /*GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 4,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero, // Ensure no padding is applied
            children: const [
              Feature(icon: Icons.bed, label: 'Bedroom', value: '4 Rooms'),
              Feature(icon: Icons.garage, label: 'Parking', value: '1 Garage'),
              Feature(icon: Icons.bathtub, label: 'Bathroom', value: '3 Rooms'),
              Feature(icon: Icons.weekend, label: 'Reception', value: '1 Reception'),
              Feature(icon: Icons.kitchen, label: 'Kitchen', value: '1 Kitchen'),
              Feature(icon: Icons.square_foot, label: 'Area', value: '1,079 sqft'),
            ],
          ),*/
        ],
      ),
    );
  }
}

class Feature extends StatelessWidget {
  //final IconData icon;
  final String label;
  final String value;

  const Feature({
    super.key,
    //required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
            label == 'Bedrooms' ? Icons.bed :
            label == 'Bathrooms' ? Icons.bathtub :
            label == 'Parking' ? Icons.garage :
            label == 'Reception' ? Icons.weekend :
            label == 'Kitchen' ? Icons.kitchen :
            label == 'Area' ? Icons.square_foot :
            Icons.perm_device_information
            ,
            size: 20, color: TColors.primary),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label, style: TextStyle(fontSize: 11, color: Colors.grey[700])),
            Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          ],
        ),
      ],
    );
  }
}