import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../data/repositories/property/property_repository.dart';
import '../../utils/popups/loaders.dart';
import '../model/property_model.dart';

class AllPropertiesController extends GetxController{
  static AllPropertiesController get instance => Get.find();

  final repository = PropertyRepository.instance;
  final RxString selectedSortOption = 'Name'.obs;
  final RxList<PropertyModel> properties = <PropertyModel>[].obs;
  Future<List<PropertyModel>> fetchPropertiesByQuery(Query? query) async{
    try{
      if(query == null) return [];

      final properties = await repository.fetchPropertiesByQuery(query);
      return properties;
      
    }catch(e){
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
      return [];
    }
  }

  void sortProducts(String sortOption){
    selectedSortOption.value = sortOption;

    switch(sortOption){
      case 'Name':
        properties.sort((a,b) => a.title.compareTo(b.title));
        break;
      case 'Higher Price':
        properties.sort((a,b) => b.price.compareTo(a.price));
        break;
      case 'Lower Price':
        properties.sort((a,b) => a.price.compareTo(b.price));
        break;
      // case 'Newest':
      //   products.sort((a,b) => a.date!.compareTo(b.date!));
      //   break;
      // case 'Sale':
      //   products.sort((a,b){
      //     if(b.salePrice > 0){
      //       return b.salePrice.compareTo(a.salePrice);
      //     }else if(a.salePrice > 0){
      //       return -1;
      //     }else{
      //       return 1;
      //     }
      //   });
        break;
      default:
        // Default sorting option Name
        properties.sort((a,b) => a.title.compareTo(b.title));
    }
  }
  void assignProducts(List<PropertyModel> properties){
    // Assign products to the 'products' list
    this.properties.assignAll(properties);
    sortProducts('Name');
  }
}