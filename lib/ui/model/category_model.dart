import 'package:cloud_firestore/cloud_firestore.dart';
class CategoryModel{
  String id;
  String name;
  String image;
  String parentId;
  bool isFeatured;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.isFeatured,
    this.parentId = '',
 });

  // Empty Helper Function
  static CategoryModel empty() => CategoryModel(id: '', name: '', image: '', isFeatured: false);

  /// Convert model to Json structure so that you can store data in firebase
  Map<String, dynamic> toJson(){
    return{
      'name': name,
      'image': image,
      'parentId': parentId,
      'isFeatured': isFeatured,
    };
  }
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      parentId: json['parentId'] ?? '',
      isFeatured: json['isFeatured'] ?? false,
    );
  }
  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      name: map['name'],
      image: map['image'],
      isFeatured: map['isFeatured'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'parentId': parentId,
      'isFeatured': isFeatured,
    };
  }
  /// Map Json oriented document snapshot from firebase to UserModel
  factory CategoryModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    if(document.data() != null){
      final data = document.data()!;

      // Map Json Record to the Model
      return CategoryModel(
          id: document.id,
          name: data['name'] ?? '',
          image: data['image'] ?? '',
          parentId: data['parentId'] ?? '',
          isFeatured: data['isFeatured'] ?? false,
      );
    }else{
      return CategoryModel.empty();
    }
  }
}