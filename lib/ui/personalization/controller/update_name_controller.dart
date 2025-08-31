import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:real_estate_app/ui/personalization/controller/user_controller.dart';

import '../../../data/user/user_respository.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';
import '../screens/profile/profile.dart';


/// controller to manage user-related functionality
class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final lastName = TextEditingController(); // Controller for lastName input
  final firstName = TextEditingController(); // Controller for username input
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  /// Fetch user record
  Future<void> initializeNames() async{
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }
  Future<void> updateUserName() async{
    try{
      // Start Loading
      TFullScreenLoader.openLoadingDialog('We are processing your information...', TImages.docerAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        return;
      }

      // Form Validation
      if(!updateUserNameFormKey.currentState!.validate()){
        return;
      }

      // Update user's first & last name in the firebase firestore
      Map<String,dynamic> name = {'FirstName': firstName.text.trim(), 'LastName': lastName.text.trim()};
      await userRepository.updateSingleField(name);

      // Update the Rx user value
      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();


      // Remove Loader
      TFullScreenLoader.stopLoading(); // Close the dialog using the Navigator
      // Show Success Message
      TLoaders.successSnackBar(title: 'Congratulations', message: 'Your Name has been updated');

      // Move to previous screen
      Get.off(() => const ProfileScreen());

    }catch(e){
      TFullScreenLoader.stopLoading();
      // Show some Generic Error to the user
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());

    }
  }


}
