
import 'dart:convert';
import 'package:get/get.dart';
import 'package:real_estate_app/data/repositories/property/property_repository.dart';
import 'package:real_estate_app/ui/model/property_model.dart';

import '../../../utils/local_storage/storage_utility.dart';
import '../../../utils/popups/loaders.dart';
import '../property_controller.dart';

class FavouritesController extends GetxController{
  static FavouritesController get instance => Get.find();

  /// Variables
  final favourites = <String, bool>{}.obs;
  final propertyController = PropertyController();
  final repository = PropertyRepository.instance;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    initFavourites();
  }

  void initFavourites() {
    final json = TLocalStorage.instance().readData('favorites');
    if(json != null){
      final storedFavourites = jsonDecode(json) as Map<String, dynamic>;
      favourites.assignAll(storedFavourites.map((key, value) => MapEntry(key, value as bool)));
    }
  }

  bool isFavourite(String productId){
    return favourites[productId] ?? false;
  }

  void toggleFavouriteProduct(String productId){
    if(!favourites.containsKey(productId)){
      favourites[productId] = true;
      TLoaders.customToast(message: 'Property has been added to the Wishlist');
    } else {
      favourites.remove(productId);  // Only remove from map, not storage
      TLoaders.customToast(message: 'Property has been removed from the Wishlist');
    }
    saveFavouritesToStorage(); // Resave the entire 'favorites' map
  }


  void saveFavouritesToStorage() {
    final encodedFavorites = json.encode(favourites);
    TLocalStorage.instance().saveData('favorites', encodedFavorites);
  }

  Future<List<PropertyModel>> favoriteProperties() async{
    final properties = repository.getFavoriteProperties(favourites.keys.toList());
    return properties;
   //return await PropertyModel.instance.getFavoriteProperties(favourites.keys.toList());
 }

}