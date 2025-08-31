

import 'package:get/get.dart';

import '../../../data/repositories/authentication/authentication_repository.dart';
import '../../../utils/popups/loaders.dart';

class LogoutController extends GetxController{
  /// -- Email and Password SignIn
  Future<void> logout() async{
    try{
      // login user using Email & Password Authentication
      await AuthenticationRepository.instance.logout();
    }catch(e){
      // Show some Generic Error to the user
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());

    }
  }
}