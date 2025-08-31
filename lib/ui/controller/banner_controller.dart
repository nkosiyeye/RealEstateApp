
import 'package:get/get.dart';
import 'package:real_estate_app/utils/constants/image_strings.dart';

import '../../../../utils/popups/loaders.dart';
import '../model/banner_model.dart';

class BannerController extends GetxController{

  final isLoading = false.obs;
  final carouselCurrentIndex = 0.obs;
  final RxList<BannerModel> banners = <BannerModel>[].obs;

  void updatePageIndicator(index){
    carouselCurrentIndex.value = index;
  }

  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }

  /// fetch banner
  Future<void> fetchBanners() async{
    try{
      // Show loader while loading categories
      isLoading.value = true;

      // Fetch Banners
      //final bannerRepo = Get.put(BannerRepository());
      //final banners = await bannerRepo.fetchBanners();
      final banners = [
        BannerModel(imageUrl: TImages.banner1, targetScreen: '/home', active: true),
        BannerModel(imageUrl: TImages.banner2, targetScreen: '/home', active: true),
      ];

      // Assign banners
      this.banners.assignAll(banners);
    }catch(e){
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }finally{
      isLoading.value = false;
    }
  }
}