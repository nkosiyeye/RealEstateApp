import 'package:get/get.dart';
import 'package:real_estate_app/ui/controller/property_controller.dart';
import 'package:real_estate_app/ui/screens/search/SearchScreen.dart';
import 'package:real_estate_app/utils/local_storage/storage_utility.dart';

import '../../data/repositories/property/property_repository.dart';
import '../model/category_model.dart';
import '../model/property_model.dart';

class CustomSearchController extends GetxController {
  var propertiesController = PropertyController.instance;
  var searchText = ''.obs;
  var filteredProperties = <PropertyModel>[].obs;
  var recentSearches = <String>[].obs;

  // Search filters
  var isRentSelected = true.obs;
  var selectedPropertyType = ''.obs;
  var minPrice = 0.obs;
  var maxPrice = 0.obs;
  var postedSince = ''.obs;
  var selectedLocation = ''.obs;
  final PropertyRepository propertyRepository = PropertyRepository();


  //var searchText = ''.obs;
  //var recentSearches = <String>[].obs;

  // Replace with real data source
  var allProperties = <PropertyModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    debounce(searchText, (_) => performSearch(), time: const Duration(milliseconds: 500));
  }
  Future<void> performSearch() async {
    if (searchText.value.isEmpty) {
      filteredProperties.clear();
      return;
    }

    try {
      final results = await propertyRepository.getSearched(searchText.value);
      filteredProperties.assignAll(results);

      // Add to recent searches
      if (!recentSearches.contains(searchText.value)) {
        recentSearches.add(searchText.value);
      }
    } catch (e) {
      print('Error during search: $e');
    }
  }

  void clearFilter() {
    isRentSelected.value = false;
    selectedPropertyType.value = '';
    minPrice.value = 0;
    maxPrice.value = 1000000;
    selectedLocation.value = '';
  }

  Future<void> applyFilters() async {
    try {
      final results = await propertyRepository.getFilteredProperties(
        isRent: isRentSelected.value,
        propertyType: selectedPropertyType.value,
        minPrice: minPrice.value,
        maxPrice: maxPrice.value,
        location: selectedLocation.value,
      );
      filteredProperties.assignAll(results);
      Get.to(() => SearchScreen());
    } catch (e) {
      print('Error applying filters: $e');
    }
  }


  void loadRecentSearches() {
    final savedSearches = TLocalStorage.instance().readData('recentSearches') ?? [];
    recentSearches.assignAll(savedSearches.cast<String>());
  }

  void removeRecent(String search) {
    recentSearches.remove(search);
    saveRecentSearches(); // Update local storage
  }

  void saveRecentSearches() {
    // Ensure only the latest 5 searches are saved
    if (recentSearches.length > 5) {
      recentSearches.removeAt(0); // Remove the oldest search
    }
    TLocalStorage.instance().saveData('recentSearches', recentSearches.toList());
  }

  // Simulate loading from a backend or local DB
  void loadProperties(List<PropertyModel> properties) {
    allProperties.assignAll(properties);
  }

  void clearSearch() {
    searchText.value = '';
  }
}
