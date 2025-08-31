import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:real_estate_app/common/widgets/section_heading.dart';
import 'package:real_estate_app/ui/personalization/controller/add_property_controller.dart';
import 'package:real_estate_app/ui/personalization/screens/add_property/widget/map_screen.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/validators/validation.dart';
import 'add_property_step3.dart';

class AddPropertyStep2 extends StatelessWidget {
  const AddPropertyStep2({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddPropertyController.instance;
    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace, vertical: TSizes.defaultSpace / 2),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              if (controller.addPropertyFormKey.currentState!.validate()) {
                // Proceed to the next step
                Get.to(() => const AddPropertyStep3());
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
            "2/4",
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
              key: controller.addPropertyFormKey,
              child: Column(
                children: [
                  /// Name
                  TextFormField(
                    controller: controller.name,
                    validator: (value) => TValidator.validateEmptyText('Name', value),
                    decoration: const InputDecoration(
                      labelText: "Name",
                      prefixIcon: Icon(Iconsax.user),
                    ),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwInputFields,
                  ),
        
                  /// Description
                  TextFormField(
                    controller: controller.description,
                    validator: (value) => TValidator.validateEmptyText('Description', value),
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: "Description",
                      helperMaxLines: 3,
                    ),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwInputFields,
                  ),
                  SizedBox(height: TSizes.spaceBtwItems,),
                  TSectionHeading(title: "Address", showActionButton: true, buttonTitle: "choose location", onPressed:() => Get.to(() => GoogleMapPage()),),
                  /// City
                  TextFormField(
                    controller: controller.city,
                    validator: (value) => TValidator.validateEmptyText('City', value),
                    decoration: const InputDecoration(
                      labelText: "City",
                      prefixIcon: Icon(Iconsax.location),
                    ),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwInputFields,
                  ),
        
                  /// Region
                  TextFormField(
                    controller: controller.region,
                    validator: (value) => TValidator.validateEmptyText('Region', value),
                    decoration: const InputDecoration(
                      labelText: "Region",
                      prefixIcon: Icon(Iconsax.map),
                    ),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwInputFields,
                  ),
        
                  /// Country
                  TextFormField(
                    controller: controller.country,
                    validator: (value) => TValidator.validateEmptyText('Country', value),
                    decoration: const InputDecoration(
                      labelText: "Country",
                      prefixIcon: Icon(Iconsax.global),
                    ),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwInputFields,
                  ),
        
                  /// Address
                  TextFormField(
                    controller: controller.address,
                    maxLines: 3,
                    validator: (value) => TValidator.validateEmptyText('Address', value),
                    decoration: const InputDecoration(
                      labelText: "Address",
                    ),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwInputFields,
                  ),
                  /// Price
                  TextFormField(
                    controller: controller.price,
                    keyboardType: TextInputType.number,
                    validator: (value) => TValidator.validateEmptyText('Price', value),
                    decoration: const InputDecoration(
                      labelText: "Price",
                      prefixIcon: Icon(Iconsax.money),
                    ),
                  ),
                  Obx(() {
                    final imageFile = controller.uploadedMainImage.value;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: TSizes.spaceBtwInputFields),
                        const Text("Main Picture", style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        if (imageFile != null)
                          Stack(
                            children:[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  imageFile,
                                  height: 200,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),

                              Positioned(
                                top: 4,
                                right: 4,
                                child: GestureDetector(
                                  onTap: () => controller.removeMainImage(),
                                  child: const CircleAvatar(
                                    radius: 12,
                                    backgroundColor: Colors.white,
                                    child: Icon(Icons.close, size: 16, color: Colors.black),
                                  ),
                                ),
                              ),
                            ]
                          )
                        else
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              onPressed: controller.pickScreenshotImage,
                              icon: const Icon(Icons.upload),
                              label: const Text("Add Main Picture"),
                            ),
                          ),
                      ],
                    );
                  }),
                  Obx(() {
                    final images = controller.otherImages; // Your list of image paths/URLs
                    const maxImages = 5;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: TSizes.spaceBtwInputFields),
                        const Text("Add Other Pictures", style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            childAspectRatio: 1,
                          ),
                          itemCount: images.length < maxImages ? images.length + 1 : maxImages,
                          itemBuilder: (context, index) {
                            // Upload photo slot
                            if (index == images.length && images.length < maxImages) {
                              return GestureDetector(
                                onTap: controller.pickOtherImage,
                                child: const DottedBorder(
                                  options:  RoundedRectDottedBorderOptions(
                                    radius: Radius.circular(16),
                                    dashPattern: [6, 3],
                                    color: Colors.grey,
                                  ),
                                  child: Center(
                                    child: Text('Upload Photo', style: TextStyle(color: Colors.grey)),
                                  ),
                                ),
                              );
                            }

                            // Display uploaded image with 'X'
                            return Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.file( // Use Image.file if local
                                    images[index].imageFile!,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                                ),
                                Positioned(
                                  top: 4,
                                  right: 4,
                                  child: GestureDetector(
                                    onTap: () => controller.removeOtherImage(index),
                                    child: const CircleAvatar(
                                      radius: 12,
                                      backgroundColor: Colors.white,
                                      child: Icon(Icons.close, size: 16, color: Colors.black),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    );
                  }),

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
