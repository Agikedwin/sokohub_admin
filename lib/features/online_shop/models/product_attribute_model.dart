class ProductAttributeModel {
  String? name;
  final List<String>? values;

  ProductAttributeModel({this.name, this.values});

  /// Create Empty func for clean code
  static ProductAttributeModel empty() => ProductAttributeModel(name: '', values: []);

  /// Convert model to JSON structure
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Values': values,
    };
  }

  /// Map Json oriented document snapshot from Firebase to Model
  factory ProductAttributeModel.fromJson(Map<String, dynamic> document) {
    if (document.isEmpty) return ProductAttributeModel.empty();

    return ProductAttributeModel(
      name: document.containsKey('Name') ? document['Name'] : '',
      // Ensure the list is cast correctly to List<String>
      values: List<String>.from(document['Values'] ?? []),
    );
  }
}