import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:real_estate_app/common/widgets/success_screen/success_screen.dart';
import 'package:real_estate_app/ui/model/property_model.dart';
import 'package:real_estate_app/ui/personalization/controller/user_controller.dart';
import 'package:real_estate_app/ui/personalization/screens/my_property/my_properties.dart';
import 'package:uuid/uuid.dart';

import '../../../../utils/popups/loaders.dart';
import '../../../data/repositories/categories/category_repository.dart';
import '../../../data/repositories/property/property_repository.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../model/category_model.dart';

class AddPropertyController extends GetxController {
  static AddPropertyController get instance => Get.find();

  final isLoading = false.obs;
  Rx<CategoryModel> selectedPropertyCategory = CategoryModel(id: "", image: '', name: '', isFeatured: false).obs;
  Rx<String> propertyType = ''.obs;
  final controller = UserController.instance;
  final categoryRepository = Get.put(CategoryRepository());


  //final _categoryRepository = Get.put(CategoryRepository());
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;

  final PropertyRepository repository = PropertyRepository();
  final name = TextEditingController();
  final description = TextEditingController();
  final city = TextEditingController();
  final region = TextEditingController();
  final country = TextEditingController();
  final address = TextEditingController();
  final price = TextEditingController();
  final bedrooms = TextEditingController();
  final bathrooms = TextEditingController();
  final kitchen = TextEditingController();
  final parking = TextEditingController();
  final plotArea = TextEditingController();
  final hectaArea = TextEditingController();
  final furnishing = TextEditingController();
  final constructionStatus = TextEditingController();
  final longitude = ''.obs;
  final latitude = ''.obs;
  GlobalKey<FormState> addPropertyFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> addPropertyValuesFormKey = GlobalKey<FormState>();

  //RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  /// -- Load category data
  Future<void> fetchCategories() async {
    try {
      // Show loader while loading categories
      isLoading.value = true;
      // fetch categories from data source
      final categories = await categoryRepository.getAllCategories();

      // Update the categories list
      allCategories.assignAll(categories);
    } catch (e) {
      print('Cat ${e.toString()}');
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Rx<File?> uploadedMainImage = Rx<File?>(null);

  Future<void> pickScreenshotImage() async {
    final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery);
    if (pickedFile != null) {
      uploadedMainImage.value = File(pickedFile.path);
    }
  }

  final RxList<Gallery> otherImages = <Gallery>[].obs;

  Future<void> pickOtherImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null && otherImages.length < 5) {
      final file = File(pickedFile.path);

      // Add the image locally without uploading
      otherImages.add(Gallery(
        id: otherImages.length + 1, // Adjust ID logic if needed
        image: file.path,           // Local path
        imageFile: file,            // File object
        isVideo: false,
        imageUrl: '',             // Since this is an image
      ));
    }
  }


  void removeOtherImage(int index) {
    otherImages.removeAt(index);
  }

  void removeMainImage() {
    uploadedMainImage.value = null;
  }

  int? selectedParameter;
  var selectedParameters = <String, RxString>{};

  Future<void> showCustomBedroomDialog(BuildContext context,
      TextEditingController controller, String heading) async {
    //final controller = TextEditingController();

    final result = await showDialog<int>(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text("Enter $heading"),
            content: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: "Enter number"),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  final value = int.tryParse(controller.text);
                  if (value != null && value > 5) {
                    Navigator.of(context).pop(value);
                  }
                },
                child: const Text("OK"),
              ),
            ],
          ),
    );

    if (result != null) {
      selectedParameter = result;
      controller.text = result.toString();
      updateParameter(heading, result.toString());
    }
  }

  void updateParameter(String heading, String value) {
    selectedParameters[heading]?.value = value;
  }

  void initParameter(String heading) {
    if (!selectedParameters.containsKey(heading)) {
      selectedParameters[heading] = ''.obs;
    }
  }

  var selectedExtraFacilities = <String, RxSet<String>>{};

  void initOption(String heading) {
    if (!selectedExtraFacilities.containsKey(heading)) {
      selectedExtraFacilities[heading] = <String>{}.obs;
    }
  }

  void toggleOption(String heading, String label) {
    final currentSet = selectedExtraFacilities[heading];
    if (currentSet != null) {
      if (currentSet.contains(label)) {
        currentSet.remove(label);
      } else {
        currentSet.add(label);
      }
    }
  }

  var outdoorFacilities = <AssignedOutdoorFacility>[].obs;

  final availablePlaces = [
    {'name': 'Bus Stop', 'facilityId': 1, 'icon': Icons.directions_bus},
    {'name': 'School', 'facilityId': 2, 'icon': Icons.school},
    {'name': 'Garden', 'facilityId': 3, 'icon': Icons.park},
    {'name': 'Hospital', 'facilityId': 4, 'icon': Icons.local_hospital},
    {'name': 'Supermarket', 'facilityId': 5, 'icon': Icons.store},
    {'name': 'Mall', 'facilityId': 6, 'icon': Icons.local_mall},
    {'name': 'Bank/ATM', 'facilityId': 7, 'icon': Icons.account_balance},
    {'name': 'Gym', 'facilityId': 8, 'icon': Icons.fitness_center},
    {'name': 'Gas Station', 'facilityId': 9, 'icon': Icons.local_gas_station},
  ];

  void togglePlace(String placeName) {
    var facility = outdoorFacilities.firstWhereOrNull((f) => f.name == placeName);

    if (facility != null) {
      outdoorFacilities.remove(facility); // deselect
    } else {
      var placeInfo = availablePlaces.firstWhere((p) => p['name'] == placeName);
      outdoorFacilities.add(
        AssignedOutdoorFacility(
          name: placeInfo['name'] as String,
          facilityId: placeInfo['facilityId'] as int,
          distance: 0, // default 0, change via UI
          image: '', // if needed
        ),
      );
    }
  }

  TextEditingController getDistanceController(String placeName) {
    var facility = outdoorFacilities.firstWhereOrNull((f) => f.name == placeName);
    return TextEditingController(
      text: facility?.distance?.toString() ?? '0',
    );
  }

  void updateDistance(String placeName, String value) {
    var facility = outdoorFacilities.firstWhereOrNull((f) => f.name == placeName);
    if (facility != null) {
      facility.distance = int.tryParse(value) ?? 0;
      outdoorFacilities.refresh();
    }
  }

  Future<void> saveProperty() async {
    try {
      String id = Uuid().v4(); // Unique ID for property
      String titleImageUrl = '';
      Set<String> allKeywords = {};
      allKeywords.addAll(generateKeywords(name.text.trim()));
      allKeywords.addAll(generateKeywords(address.text.trim()));
      allKeywords.addAll(generateKeywords(city.text.trim()));
      allKeywords.addAll(generateKeywords(propertyType.value));
      // Start Loading
      TFullScreenLoader.openLoadingDialog('Saving your property...', TImages.docerAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        TFullScreenLoader.stopLoading();
        return;
      }

      // Upload title image
      if (uploadedMainImage.value != null) {
        titleImageUrl = await repository.uploadImage(
          File(uploadedMainImage.value!.path),
          'property/$id/titleImage.jpg',
        );
      }

      if(otherImages.value != null){
        // Upload images concurrently
        final uploadTasks = otherImages.map((image) async {
          final fileName = 'gallery_${DateTime.now().millisecondsSinceEpoch}.jpg';
          final ref = FirebaseStorage.instance.ref().child('property/$id/$fileName');
          final uploadTask = await ref.putFile(image.imageFile!);
          final downloadUrl = await ref.getDownloadURL();

          // Replace the old object with a new one
          final updatedImage = Gallery(
            id: image.id,
            image: image.image,
            imageUrl: downloadUrl,
            imageFile: image.imageFile,
            isVideo: image.isVideo,
          );
          final index = otherImages.indexOf(image);
          otherImages[index] = updatedImage;
        }).toList();

        await Future.wait(uploadTasks);
      }

      final newProperty = PropertyModel(
        id: id,
        properyType: propertyType.value,
        addedBy: controller.user.value.id,
        promoted: false,
        isPremium: propertyType.value == 'Sale' ? parseDouble(price.text.trim()) > 1000000 : parseDouble(price.text.trim()) > 3000, // Example condition for premium
        titleImage: titleImageUrl,
        gallery: otherImages.value,
        title: name.text.trim(),
        price: price.text.trim(),
        category: selectedPropertyCategory.value,
        description: description.text.trim(),
        city: city.text.trim(),
        country: country.text.trim(),
        address: address.text.trim(),
        region: region.text.trim(),
        longitude: longitude.value,
        latitude: latitude.value,
          parameters: [
            if(bedrooms.text.isNotEmpty)
            Parameter(
              name: 'Bedrooms',
              value: parseInt(bedrooms.text.trim()),
            ),
            if(bathrooms.text.isNotEmpty)
            Parameter(
              name: 'Bathrooms',
              value: parseInt(bathrooms.text.trim()),
            ),
            if(kitchen.text.isNotEmpty)
            Parameter(
              name: 'Kitchen',
              value: parseInt(kitchen.text.trim()),
            ),
            if(parking.text.isNotEmpty)
            Parameter(
              name: 'Parking',
              value: parseInt(parking.text.trim()),
            ),
            Parameter(
              name: 'Plot Area',
              value: parseDouble(plotArea.text.trim()),
            ),
            Parameter(
              name: 'Hecta Area',
              value: parseDouble(hectaArea.text.trim()),
            ),
          ],
        furnished: furnishing.text.trim(),
        assignedOutdoorFacility: outdoorFacilities.map((facility) => facility).toList(),
        extrafacilities: selectedExtraFacilities.values
            .map((set) => set.toList())
            .expand((list) => list)
            .toList(),
        searchableKeywords: allKeywords.toList()
      );

      await repository.addProperty(newProperty);

      // Remove Loader
      TFullScreenLoader.stopLoading();
      Get.to(() => SuccessScreen(
        image: "assets/images/animations/property submited.png",
        title: "Congratulations",
        subTitle: "Your Property Submitted Successfully",
        LottieAnimation: false,
        onPressed: () {
          Get.to(() => const MyProperties());
        },
      ));
    } catch (e) {
      Get.snackbar('hereError', e.toString());
      throw 'Failed to add property: ${e.toString()}';
    }
  }
  int parseInt(String value, [int defaultValue = 0]) {
    return int.tryParse(value) ?? defaultValue;
  }

  double parseDouble(String value, [double defaultValue = 0.0]) {
    return double.tryParse(value) ?? defaultValue;
  }

  Set<String> generateKeywords(String text) {
    if (text.isEmpty) return {};
    // Simple split by space and non-alphanumeric, convert to lowercase.
    // You might want a more sophisticated tokenizer.
    return text
        .toLowerCase()
        .split(RegExp(r'[\s\W]+')) // Split by space or non-alphanumeric characters
        .where((s) => s.isNotEmpty)
        .toSet(); // Use a Set to avoid duplicate keywords from the same source string
  }

/// Load selected category data


/// Get Category or Sub-Category Products


}