class CategoryModel {
  final String categoryName;
  final String docId;
  final String imageUrl;
  final int countProduct;
  final String storagePath;

  CategoryModel({
    required this.storagePath,
    required this.countProduct,
    required this.categoryName,
    required this.docId,
    required this.imageUrl,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      countProduct: 0,
      categoryName: json['category_name'] as String? ?? "",
      docId: json['doc_id'] as String? ?? "",
      imageUrl: json['image_url'] as String? ?? "",
      storagePath: json['storage_path'] as String? ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'storage_path': storagePath,
      'category_name': categoryName,
      'doc_id': docId,
      'image_url': imageUrl,
    };
  }

  Map<String, dynamic> toJsonForUpdate() {
    return {
      'storage_path': storagePath,
      'category_name': categoryName,
      'image_url': imageUrl,
    };
  }

  static CategoryModel defaultModel() {
    return CategoryModel(
      storagePath: "",
      countProduct: 0,
      categoryName: "",
      docId: "",
      imageUrl: "",
    );
  }

  CategoryModel copyWith({
    String? categoryName,
    String? docId,
    String? imageUrl,
    int? countProduct,
    String? storagePath,
  }) {
    return CategoryModel(
      countProduct: countProduct ?? this.countProduct,
      categoryName: categoryName ?? this.categoryName,
      docId: docId ?? this.docId,
      imageUrl: imageUrl ?? this.imageUrl,
      storagePath: storagePath ?? this.storagePath,
    );
  }
}
