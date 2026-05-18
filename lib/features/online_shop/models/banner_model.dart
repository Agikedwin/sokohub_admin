import 'package:cloud_firestore/cloud_firestore.dart';

class BannerModel {
  String? id;
  String name;
  String imageUrl;
  bool active;
  String targetScreen;

  BannerModel({
     this.id,
    required this.name,
    required this.imageUrl,
    required this.active,
    required this.targetScreen
  });

  /// Empty helper Function
  static BannerModel empty() => BannerModel(
        id: '',
        name: '',
        imageUrl: '',
        active: true,
        targetScreen: ''

      );

  /// Convert model to JSON structure (for Firebase storage)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'targetScreen': targetScreen,
      'active': active
    };
  }

  /// Create CategoryModel from JSON (Firestore / API)
  factory BannerModel.fromJson(Map<String, dynamic> json, String id) {
    return BannerModel(
      id: json['id'] ?? '' ,
      name: json['name'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      active: json['active'] ?? false,
      targetScreen: json['targetScreen'] ?? ''
    );
  }

  /// Create CategoryModel from Firebase DocumentSnapshot
  factory BannerModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>>  document) {
    if(document.data() != null){
      final data = document.data()!;
    
    return BannerModel(
      id: document.id ,
      name: data['name'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      active: data['active'] ?? false,
      targetScreen: data['targetScreen'] ?? ''
    );
  }else {
    return BannerModel.empty();

  }
  }
}