import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_estate_app/utils/constants/sizes.dart';
import '../../../../../common/widgets/shimmer/category_shimmer.dart';
import '../../../controller/category_controller.dart';
import '../../../model/category_model.dart';
import '../../all_properties/all_properties.dart';
import 'category_card.dart';

class THomeCategories extends StatelessWidget {
  const THomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());
    return Obx((){
        if(categoryController.isLoading.value) return const TCategoryShimmer();
        if(categoryController.featuredCategories.isEmpty){
          return Center(child: Text('No Data Found', style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white)));
        }
        return SizedBox(
          height: 80,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: categoryController.featuredCategories.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                final category = categoryController.featuredCategories[index];
                return CategoryCard(category: category, frontSpacing: true, onTapCategory: (CategoryModel category) {
                  Get.to(() =>
                      AllProperties(
                        title: '${category.name} Properties',
                        query: FirebaseFirestore.instance.collection('Properties').where('category.name', isEqualTo: category.name),
                      )
                  );
                },
                );
              }),
        );
      },
    );
  }
}