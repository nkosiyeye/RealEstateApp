import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:real_estate_app/data/repositories/authentication/authentication_repository.dart';
import 'package:real_estate_app/utils/constants/image_strings.dart';

import '../../../../utils/popups/loaders.dart';
import '../../data/repositories/property/property_repository.dart';
import '../model/category_model.dart';
import '../model/property_model.dart';
import '../personalization/model/user_model.dart';

class PropertyController extends GetxController {
  static PropertyController get instance => Get.find();

  //final isLoading = false.obs;
  RxList<PropertyModel> featuredProducts = <PropertyModel>[].obs;
  RxList<PropertyModel> featuredPremium = <PropertyModel>[].obs;
  RxList<PropertyModel> properties = <PropertyModel>[].obs;
  final propertyRepository = Get.put(PropertyRepository());

  //final hasMore = true.obs;
  int currentPage = 1;

  @override
  void onInit() {
    super.onInit();
    fetchFeaturedProperty();
    fetchProperties();
  }

  void fetchFeaturedProperty() async {
    try {
      isLoading.value = true;

      // Dummy data for featured properties
      final allFeatured = await propertyRepository.getFeaturedProperties(); // Wait for the Future
      final allPremium = await propertyRepository.getPremiumProperties();
      final premium = allPremium.take(5).toList();
      final properties = allFeatured.take(5).toList(); // Now use take(10)

      // Assign Products
      featuredPremium.assignAll(premium);
      featuredProducts.assignAll(properties);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
  var isLoading = true.obs; // True initially to show shimmer/loader
  var isFetchingMore = false.obs;
  var hasMore = true.obs; // Assume there's more data initially
  int limit = 10; // Number of items to fetch per page
  DocumentSnapshot? lastDoc;

  Future<void> fetchProperties({bool isInitialFetch = true}) async {
    // Prevent fetching if already fetching or no more data, unless it's an initial fetch triggered by refresh
    if (isFetchingMore.value || (!hasMore.value && !isInitialFetch)) {
      if (!isInitialFetch) return; // Don't proceed if it's a pagination call and no more data
    }

    if (isInitialFetch) {
      isLoading.value = true;
      properties.clear(); // Clear existing properties for a fresh fetch/refresh
      lastDoc = null;     // Reset last document for a fresh fetch/refresh
      hasMore.value = true; // Reset hasMore for a fresh fetch/refresh
    }

    isFetchingMore.value = true;

    try {
      final newProperties = await propertyRepository.getPaginatedProperties(
        startAfterDoc: lastDoc,
        limit: limit,
      );

      if (newProperties.isEmpty) {
        hasMore.value = false;
      } else {
        properties.addAll(newProperties);
        // Important: Update lastDoc using the snapshot from the fetched data, not by re-querying
        // Assuming PropertyModel.fromSnapshot stores the original DocumentSnapshot or its ID
        // The most reliable way is if your getPaginatedProperties could also return the last snapshot.
        // For now, using your existing getLastDoc, but it's an extra read.
        if (propertyRepository.getLastFetchedDocument() != null) {
          lastDoc = propertyRepository.getLastFetchedDocument();
        } else if (newProperties.isNotEmpty) {
          // Fallback if getLastFetchedDocument is not implemented in repository yet
          // This requires an extra read and assumes PropertyModel has an ID corresponding to the document ID.
          // A better way is for getPaginatedProperties to return the actual last DocumentSnapshot from the query.
          QuerySnapshot querySnapshot = await FirebaseFirestore.instance
              .collection('Properties')
              .where(FieldPath.documentId, isEqualTo: newProperties.last.id)
              .limit(1)
              .get();

          if (querySnapshot.docs.isNotEmpty) {
            lastDoc = querySnapshot.docs.first;

          }
        }

        if (newProperties.length < limit) {
          hasMore.value = false; // Reached the end if fewer items than limit were fetched
        }
      }
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Error Fetching Properties', message: e.toString());
      hasMore.value = false; // Stop trying to fetch if there's an error
    } finally {
      isLoading.value = false; // For initial load
      isFetchingMore.value = false;
    }
  }

  // Optional: For pull-to-refresh functionality
  Future<void> refreshProperties() async {
    await fetchProperties(isInitialFetch: true);
  }






}