import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:real_estate_app/common/widgets/section_heading.dart';
import 'package:real_estate_app/ui/personalization/controller/add_property_controller.dart';
import 'package:real_estate_app/ui/personalization/screens/add_property/widget/multi_choice_parameter.dart';
import 'package:real_estate_app/ui/personalization/screens/add_property/widget/single_choice_parameter.dart';
import 'package:real_estate_app/utils/constants/colors.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/validators/validation.dart';
import 'add_property_step4.dart';

class AddPropertyStep3 extends StatelessWidget {
  const AddPropertyStep3({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddPropertyController.instance;
    final List<String> bedroomOptions = ['1', '2', '3', '4', '5+'];
    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace, vertical: TSizes.defaultSpace / 2),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              if (controller.addPropertyValuesFormKey.currentState!.validate()) {
                // Proceed to the next step
                Get.to(() => AddPropertyStep4());
              }
            },
            child: const Text('Next'),
          ),
        ),
      ),
      appBar: const TAppBar(
        showBackArrow: true,
        title: Text('Add Property'),
        actions: [
          Text(
            "3/4",
            style: TextStyle(color: Colors.black54, fontSize: 16),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(
            children:[
              Padding(
                padding: const EdgeInsets.only(bottom: 60.0, left: TSizes.sidePadding,right: TSizes.sidePadding),
                child: Form(
                  key: controller.addPropertyValuesFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TChoiceParameter(options: bedroomOptions, controller: controller, parameter: controller.bedrooms, heading: "No. of Bedrooms", Icons: Icons.bedroom_parent,),
                      const SizedBox(
                        height: TSizes.spaceBtwInputFields/2,
                      ),
                      TChoiceParameter(options: bedroomOptions, controller: controller, parameter: controller.bathrooms, heading: "No. of Bathrooms", Icons: Icons.bathroom,),
                      const SizedBox(
                        height: TSizes.spaceBtwInputFields/2,
                      ),
                      TChoiceParameter(options: bedroomOptions, controller: controller, parameter: controller.kitchen, heading: "No. of Kitchen",Icons: Icons.kitchen,),
                      const SizedBox(
                        height: TSizes.spaceBtwInputFields/2,
                      ),
                      TChoiceParameter(options: bedroomOptions, controller: controller, parameter: controller.parking, heading: "No. of Parking", Icons: Icons.local_parking,),
                      const SizedBox(
                        height: TSizes.spaceBtwInputFields,
                      ),
                      /// Name
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: controller.plotArea,
                        validator: (value) => TValidator.validateEmptyText('Plot Area', value),
                        decoration: const InputDecoration(
                          labelText: "Plot Area (sqft)",
                          prefixIcon: Icon(Icons.square_foot),
                        ),
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwInputFields,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: controller.hectaArea,
                        validator: (value) => TValidator.validateEmptyText('Hecta Area', value),
                        decoration: const InputDecoration(
                          labelText: "Hecta Area (sqft)",
                          prefixIcon: Icon(Icons.square),
                        ),
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwInputFields,
                      ),
                      TChoiceParameter(options: const ["Fully Furnished" , "Semi-Furnished"], controller: controller, parameter: controller.furnishing, heading: "Furnishing",Icons: Icons.room,),
                      const SizedBox(
                        height: TSizes.spaceBtwInputFields,
                      ),
                      TChoiceParameter(options: const ["Ready to Move" , "Under Construction","New Launch"], controller: controller, parameter: controller.constructionStatus, heading: "Construction Status", Icons: Icons.construction,),
                      const SizedBox(
                        height: TSizes.spaceBtwInputFields,
                      ),
                      TMultiChoiceParameter(options: ["Gym","Pool","Main Road"], controller: controller, heading: "Extra Facilities")

                    ],
                  ),

                ),

              ),
            ]
        ),
      ),
    );
  }
}



