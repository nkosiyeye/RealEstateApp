


import 'package:get/get.dart';
import 'package:real_estate_app/utils/local_storage/storage_utility.dart';

import '../utils/helpers/network_manager.dart';

class GeneralBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(NetworkManager());
  }
}