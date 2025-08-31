import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../ui/personalization/model/user_model.dart';
import '../repositories/authentication/authentication_repository.dart';

class UserRepository extends GetxController{
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _ob = FirebaseFirestore.instance;

  /// Function to save user data to Firestore
  Future<void> saveUserRecord(UserModel user) async {
    try{
      return await _ob.collection("Users").doc(user.id).set(user.toJson());
    }on FirebaseAuthException catch (e){
      throw e.code;
    } on FirebaseException catch (e){
      throw e.code;
    } on FormatException catch(_){
      throw 'Format Exception';
    } on PlatformException catch(e){
      throw e.code;
    }catch(e){
      throw 'Something went wrong. Please try again';
    }
  }
  /// Function to fetch user details based on UserID
  Future<UserModel> fetchUserDetails() async {
    try{
      final documentSnapshot = await _ob.collection("Users").doc(AuthenticationRepository.instance.authUser?.uid).get();
      if(documentSnapshot.exists){
        return UserModel.fromSnapshot(documentSnapshot);
      }else{
        return UserModel.empty();
      }
    }on FirebaseAuthException catch (e){
      throw e.code;
    } on FirebaseException catch (e){
      throw e.code;
    } on FormatException catch(_){
      throw 'Format Exception';
    } on PlatformException catch(e){
      throw e.code;
    }catch(e){
      throw 'Something went wrong. Please try again';
    }
  }
  /// Function to update user data in Firestore
  Future<void> updateUserDetails(UserModel updatedUser) async {
    try{
      return await _ob.collection("Users").doc(updatedUser.id).update(updatedUser.toJson());
    }on FirebaseAuthException catch (e){
      throw e.code;
    } on FirebaseException catch (e){
      throw e.code;
    } on FormatException catch(_){
      throw 'Format Exception';
    } on PlatformException catch(e){
      throw e.code;
    }catch(e){
      throw 'Something went wrong. Please try again';
    }
  }
  /// Update any field in specific Users Collection
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try{
      return await _ob.collection("Users").doc(AuthenticationRepository.instance.authUser?.uid).update(json);
    }on FirebaseAuthException catch (e){
      throw e.code;
    } on FirebaseException catch (e){
      throw e.code;
    } on FormatException catch(_){
      throw 'Format Exception';
    } on PlatformException catch(e){
      throw e.code;
    }catch(e){
      throw 'Something went wrong. Please try again';
    }
  }
  /// Function to remove user data from Firestore
  Future<void> removeUserRecord(String userId) async {
    try{
      return await _ob.collection("Users").doc(userId).delete();
    }on FirebaseAuthException catch (e){
      throw e.code;
    } on FirebaseException catch (e){
      throw e.code;
    } on FormatException catch(_){
      throw 'Format Exception';
    } on PlatformException catch(e){
      throw e.code;
    }catch(e){
      throw 'Something went wrong. Please try again';
    }
  }
  /// Function to upload image
  Future<String> uploadImage(String path, XFile image) async {
    try{
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    }on FirebaseAuthException catch (e){
      throw e.code;
    } on FirebaseException catch (e){
      throw e.code;
    } on FormatException catch(_){
      throw 'Format Exception';
    } on PlatformException catch(e){
      throw e.code;
    }catch(e){
      throw 'Something went wrong. Please try again';
    }
  }



}