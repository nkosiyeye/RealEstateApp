import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:real_estate_app/ui/personalization/controller/user_controller.dart';

import '../../../ui/model/property_model.dart';
import '../../../ui/personalization/model/user_model.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';


class PropertyRepository extends GetxController {
  static PropertyRepository get instance => Get.find();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final user = Get.put(UserController()); // Get the logged-in user

  // Upload a single imag
  Future<String> uploadImage(File file, String path) async {
    final ref = storage.ref().child(path);
    await ref.putFile(file);
    return await ref.getDownloadURL();
  }

  // Upload multiple images and return their URLs
  Future<List<String>> uploadImages(List<File> files, String path) async {
    List<String> urls = [];

    for (int i = 0; i < files.length; i++) {
      final url = await uploadImage(files[i], '$path/gallery_$i.jpg');
      urls.add(url);
    }

    return urls;
  }

  // Add Property to Firestore
  Future<void> addProperty(PropertyModel property) async {
    await firestore.collection('Properties').doc(property.id).set(property.toJson());
  }
  Future<List<PropertyModel>> getAllProperties() async {
    try {
      final snapshot = await firestore.collection('Properties').where('addedBy', isEqualTo: user.user.value.id).get();

      // Fetch all properties with their associated UserModel (vendor becomes user)
      final propertyList = await Future.wait(
        snapshot.docs.map((document) async {
          // Convert document to PropertyModel
          final property = PropertyModel.fromSnapshot(document);

          // Fetch user (vendor) details using vendorId or userId (depending on what you called it in PropertyModel)
          final userSnapshot = await firestore.collection('Users').doc(property.addedBy).get();

          // Check if the user document exists
          if (userSnapshot.exists) {
            // Convert user document to UserModel
            final user = UserModel.fromSnapshot(userSnapshot);

            // Assign the fetched user to the property
            property.user = user;
          }

          // Return the property with user details
          return property;
        }).toList(),
      );

      return propertyList;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }
  /// Get all products
  Future<List<PropertyModel>> fetchPropertiesByQuery(Query query) async {
    try {
      // Step 1: Fetch the products based on the query
      final querySnapshot = await query.get();

      // Step 2: For each product, fetch the corresponding vendor details and map them to the ProductModel
      final List<PropertyModel> productList = await Future.wait(
        querySnapshot.docs.map((doc) async {
          // Convert document to ProductModel
          final product = PropertyModel.fromQuerySnapshot(doc);

          // Fetch vendor details using vendorId
          final userSnapshot = await firestore.collection('Users').doc(product.addedBy).get();

          // Check if the vendor document exists
          if (userSnapshot.exists) {
            // Convert vendor document to VendorModel
            final user = UserModel.fromSnapshot(userSnapshot);

            // Assign the fetched vendor to the product
            product.user = user;
          }

          // Return the product with the vendor details
          return product;
        }).toList(),
      );

      // Return the list of products with vendor details
      return productList;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
  Future<List<PropertyModel>> getFeaturedProperties() async {
    try {
      final snapshot = await firestore.collection('Properties').where('promoted', isEqualTo: true).get();

      // Fetch all properties with their associated UserModel (vendor becomes user)
      final propertyList = await Future.wait(
        snapshot.docs.map((document) async {
          // Convert document to PropertyModel
          final property = PropertyModel.fromSnapshot(document);

          // Fetch user (vendor) details using vendorId or userId (depending on what you called it in PropertyModel)
          final userSnapshot = await firestore.collection('Users').doc(property.addedBy).get();

          // Check if the user document exists
          if (userSnapshot.exists) {
            // Convert user document to UserModel
            final user = UserModel.fromSnapshot(userSnapshot);

            // Assign the fetched user to the property
            property.user = user;
          }

          // Return the property with user details
          return property;
        }).toList(),
      );

      return propertyList;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }
  Future<List<PropertyModel>> getPremiumProperties() async {
    try {
      final snapshot = await firestore.collection('Properties').where('isPremium', isEqualTo: true).get();

      // Fetch all properties with their associated UserModel (vendor becomes user)
      final propertyList = await Future.wait(
        snapshot.docs.map((document) async {
          // Convert document to PropertyModel
          final property = PropertyModel.fromSnapshot(document);

          // Fetch user (vendor) details using vendorId or userId (depending on what you called it in PropertyModel)
          final userSnapshot = await firestore.collection('Users').doc(property.addedBy).get();

          // Check if the user document exists
          if (userSnapshot.exists) {
            // Convert user document to UserModel
            final user = UserModel.fromSnapshot(userSnapshot);

            // Assign the fetched user to the property
            property.user = user;
          }

          // Return the property with user details
          return property;
        }).toList(),
      );

      return propertyList;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }

  Future<List<PropertyModel>> getSearched(String searchTerm) async {
    try {
      final querySnapshot = await firestore.collection('Properties')
          .where('searchableKeywords', arrayContains: searchTerm).get();

      final productList = await Future.wait(
        querySnapshot.docs.map((doc) async {
          final property = PropertyModel.fromSnapshot(doc);
          final userSnapshot = await firestore.collection('Users').doc(property.addedBy).get();

          if (userSnapshot.exists) {
            final user = UserModel.fromSnapshot(userSnapshot);
            property.user = user;
          }

          return property;
        }).toList(),
      );
      print("Properties $productList");

      return productList;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
  Future<List<PropertyModel>> getFilteredProperties({
    required bool isRent,
    required String propertyType,
    required int minPrice,
    required int maxPrice,
    required String location,
  }) async {
    try {
      Query query = firestore.collection('Properties');

      if (isRent) {
        query = query.where('isRent', isEqualTo: true);
      } else {
        query = query.where('isRent', isEqualTo: false);
      }

      if (propertyType.isNotEmpty) {
        query = query.where('propertyType', isEqualTo: propertyType);
      }

      query = query.where('price', isGreaterThanOrEqualTo: minPrice).where('price', isLessThanOrEqualTo: maxPrice);

      if (location.isNotEmpty) {
        query = query.where('location', isEqualTo: location);
      }

      final snapshot = await query.get();
      final productList = await Future.wait(
        snapshot.docs.map((doc) async {
          final property = PropertyModel.fromSnapshot(doc);
          final userSnapshot = await firestore.collection('Users').doc(property.addedBy).get();

          if (userSnapshot.exists) {
            final user = UserModel.fromSnapshot(userSnapshot);
            property.user = user;
          }

          return property;
        }).toList(),
      );
      print("Properties $productList");

      return productList;
    } catch (e) {
      print('Error fetching filtered properties: $e');
      throw e;
    }
  }

  DocumentSnapshot? _lastFetchedDocument;
  DocumentSnapshot? getLastFetchedDocument() => _lastFetchedDocument;


  Future<List<PropertyModel>> getPaginatedProperties({
    DocumentSnapshot? startAfterDoc,
    int limit = 10,
  }) async {

    try {
      Query query = firestore
          .collection('Properties')
          .orderBy(FieldPath.documentId) // Add an orderBy clause for consistent pagination
          .limit(limit);

      if (startAfterDoc != null) {
        query = query.startAfterDocument(startAfterDoc);
      }

      final snapshot = await query.get();

      if (snapshot.docs.isNotEmpty) {
        _lastFetchedDocument = snapshot.docs.last; // Store the last document from this batch
      } else {
        _lastFetchedDocument = null; // Reset if no documents found
      }


      // Fetch all properties with their associated UserModel (vendor becomes user)
      final propertyList = await Future.wait(
          snapshot.docs.map((doc) async {
            final property = PropertyModel.fromSnapshot(doc);
            final userSnapshot = await firestore.collection('Users').doc(property.addedBy).get();

            if (userSnapshot.exists) {
              final user = UserModel.fromSnapshot(userSnapshot);
              property.user = user;
            }

            return property;
          }).toList()
      );

      return propertyList;
    } catch (e) {
      print("Error fetching paginated properties: ${e.toString()}");
      throw e.toString(); // Rethrow to be caught by the controller
    }
  }


  Future<List<PropertyModel>> getFavoriteProperties(List<String> proIds) async {
    try {
      // Step 1: Fetch the products by product IDs
      final snapshot = await firestore.collection('Properties').where(FieldPath.documentId, whereIn: proIds).get();

      // Step 2: For each product, fetch the corresponding vendor details
      final proList = await Future.wait(
        snapshot.docs.map((doc) async {
          final property = PropertyModel.fromQuerySnapshot(doc);
          final vendorSnapshot = await firestore.collection('Users').doc(property.addedBy).get();

          if (vendorSnapshot.exists) {
            final user = UserModel.fromSnapshot(vendorSnapshot);
            property.user = user;
          }

          return property;
        }).toList(),
      );

      return proList;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }




/// Variables
  //final _db = FirebaseFirestore.instance;
  // Future<List<PropertyModel>> getFavoriteProducts(List<String> productIds) async {
  //   try {
  //     // Step 1: Fetch the products by product IDs
  //     final snapshot = await _db.collection('Products').where(FieldPath.documentId, whereIn: productIds).get();
  //
  //     // Step 2: For each product, fetch the corresponding vendor details
  //     final productList = await Future.wait(
  //       snapshot.docs.map((doc) async {
  //         final product = ProductModel.fromQuerySnapshot(doc);
  //         final vendorSnapshot = await _db.collection('vendors').doc(product.VendorId).get();
  //
  //         if (vendorSnapshot.exists) {
  //           final vendor = VendorModel.fromSnapshot(vendorSnapshot);
  //           product.vendor = vendor;
  //         }
  //
  //         return product;
  //       }).toList(),
  //     );
  //
  //     return productList;
  //   } on FirebaseException catch (e) {
  //     throw TFirebaseException(e.code).message;
  //   } on PlatformException catch (e) {
  //     throw TPlatformException(e.code).message;
  //   } catch (e) {
  //     throw 'Something went wrong. Please try again';
  //   }
  // }

}