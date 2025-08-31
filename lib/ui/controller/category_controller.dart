

import 'package:get/get.dart';
import 'package:real_estate_app/data/repositories/categories/category_repository.dart';

import '../../../../utils/popups/loaders.dart';
import '../model/category_model.dart';

class CategoryController extends GetxController{
  static CategoryController get instance => Get.find();

  final isLoading = false.obs;
  //final _categoryRepository = Get.put(CategoryRepository());
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;
  final repository = Get.put(CategoryRepository());

  @override
  void onInit() {
    fetchCategories();
    super.onInit();

  }

  /// -- Load category data
  Future<void> fetchCategories() async{
    try{
      // Show loader while loading categories
      isLoading.value = true;
      // fetch categories from data source
      final categories = await repository.getAllCategories();

      // Update the categories list
      allCategories.assignAll(categories);
      // Filter Featured categories
      featuredCategories.assignAll(allCategories.where((category) => category.isFeatured && category.parentId.isEmpty).take(8).toList());
    }catch(e){
      print('Cat ${e.toString()}');
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }finally{
      isLoading.value = false;
    }
  }

  /// Load selected category data


  /// Get Category or Sub-Category Products


}