import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import 'package:sokohub_admin/utils/formatters/formatter.dart';
import 'package:universal_html/html.dart';

class ImageModel {
   String? id;
  final String url;
  final String folder;
  final int? sizeBytes;
  String? mediaCategory;
  final String filename;
  final String? fullPath;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? contentType;

  /// Not mapped to Firebase
  //final File? file;
  final DropzoneFileInterface? file;
  RxBool isSelected = false.obs;
  final Uint8List? localImageToDisplay;

  /// Static function to create an empty user model
  static ImageModel empty() => ImageModel(url: '', folder: '', filename: '');
  String get createAtFormatted => TFormatter.formatDate(createdAt);
  String get updatedAtFormatted => TFormatter.formatDate(updatedAt);

  ImageModel({
    this.id = '',
    required this.url,
    required this.folder,
    this.sizeBytes,
    this.mediaCategory,
    required this.filename,
    this.fullPath,
    this.createdAt,
    this.updatedAt,
    this.contentType,
    this.file,
    this.localImageToDisplay,
  });


  /// Convert model to JSON to store in DB
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'folder': folder,
      'sizeBytes': sizeBytes,
      'filename': filename,
      'fullPath': fullPath,
      'createdAt': createdAt?.toUtc(),
      'contentType': contentType,
      'mediaCategory': mediaCategory
    };
  }

  /// Create model from JSON  to
  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'] ?? '',
      url: json['url'] ?? '',
      folder: json['folder'] ?? '',
      sizeBytes: json['sizeBytes'] ?? 0,
      mediaCategory: json['mediaCategory'] ?? '',
      filename: json['filename'] ?? '',
      fullPath: json['fullPath'] ?? '',
      createdAt: json['createdAt'] != null
          ? (json['createdAt'] as Timestamp).toDate()
          : null,
      updatedAt: json['updatedAt'] != null
          ? (json['updatedAt'] as Timestamp).toDate()
          : null,
      contentType: json['contentType'] ?? '',
    );
  }

  /// Firestore snapshot factory to convert snapshot into model
  factory ImageModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();

    if (data!.isEmpty) {
      return ImageModel.empty();
    }

    return ImageModel(
      id: snapshot.id,
      url: data['url'] ?? '',
      folder: data['folder'] ?? '',
      sizeBytes: data['sizeBytes'] ?? 0,
      mediaCategory: data['mediaCategory'] ?? '',
      filename: data['filename'] ?? '',
      fullPath: data['fullPath'] ?? '',
      createdAt: data.containsKey('createdAt')  ? (data['createdAt'] as Timestamp).toDate()   : null,
      updatedAt: data.containsKey('updatedAt') ? (data['updatedAt'] as Timestamp).toDate()    : null,
      contentType: data['contentType'] ?? '',
    );
  }

  /// Create model from Firebase Storage metadata
factory ImageModel.fromFirebaseMetadata(
  FullMetadata metadata,
  String folder,
  String filename,
  String downloadUrl
) {
  return ImageModel(
    url: downloadUrl,  
    folder: folder, 
    sizeBytes: metadata.size ?? 0,
    filename: filename,
    fullPath: metadata.fullPath,
    createdAt: metadata.timeCreated,
    updatedAt: metadata.updated,
    contentType: metadata.contentType ?? '',
  );
}

  @override
  String toString() {
    return 'ImageModel(id: $id, filename: $filename, url: $url)';
  }
}
