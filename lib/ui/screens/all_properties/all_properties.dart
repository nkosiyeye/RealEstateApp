import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_estate_app/common/widgets/property/sortable/sortable_properties.dart';
import 'package:real_estate_app/ui/controller/all_properties_controller.dart';

import '../../../common/widgets/appbar/appbar.dart';
import '../../../common/widgets/shimmer/vertical_product_shimmer.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/cloud_helper_functions.dart';
import '../../model/property_model.dart';
class AllProperties extends StatelessWidget {
  const AllProperties({super.key, required this.title, this.query, this.futureMethod});

  final String title;
  final Query? query;
  final Future<List<PropertyModel>>? futureMethod;

  @override
  Widget build(BuildContext context) {
    // Initialize controller for managing product fetching
    final controller = Get.put(AllPropertiesController());
    return Scaffold(
      appBar: TAppBar(title: Text(title), showBackArrow: true,),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: FutureBuilder(
              future: futureMethod ?? controller.fetchPropertiesByQuery(query),
              builder: (context, snapshot) {
                //Check the state of the FutureBuilder snapshot
                const loader = TVerticalProductShimmer();
                final widget = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
                if(widget != null) return widget;
                // Products found
                final properties = snapshot.data!;
                return TSortableProperties(properties: properties);
              }
            ),
        ),
      ),
    );
  }
}


