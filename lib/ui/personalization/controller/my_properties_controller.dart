import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../data/repositories/property/property_repository.dart';
import '../../model/property_model.dart';

class MyPropertiesController extends GetxController {
  final RxList<PropertyModel> properties = <PropertyModel>[].obs;
  var repository = Get.put(PropertyRepository());
  final RxBool hasMoreForSale = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPropertiesForSale();
  }
  void onReady() {
    super.onReady();
    fetchPropertiesForSale();
    // Optionally, you can call fetchPropertiesForSale() here if you want to ensure data is loaded when the controller is ready.
  }

  Future<void> fetchPropertiesForSale() async {
    try {
      // Fetch properties from the repository
      final myProperties = await repository.getAllProperties();

      // Clear and update the properties list
      properties.clear();
      properties.addAll(myProperties);

      // Debugging: Print fetched properties
      print("Fetched properties: ${properties.length}");
    } catch (e) {
      print("Error fetching For Sale properties: $e");
    }
  }

  Future<void> refreshProperties() async {
    try {
      // Clear the current list
      properties.clear();

      // Fetch fresh data
      await fetchPropertiesForSale();
    } catch (e) {
      print('Error refreshing properties: $e');
    }
  }
}
