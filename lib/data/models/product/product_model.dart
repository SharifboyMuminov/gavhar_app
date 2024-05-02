class ProductModel {
  final String categoryId;
  final String docId;
  final List<String> imageUrls;
  final String nameProduct;
  final num price;
  final String gender;
  final String description;
  final List<String> storagePaths;

  ProductModel({
    required this.storagePaths,
    required this.description,
    required this.gender,
    required this.nameProduct,
    required this.categoryId,
    required this.docId,
    required this.imageUrls,
    required this.price,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    List<String> imageUrls = [];
    List<String> imagePaths = [];
    imageUrls.add((json['image_urls'] as List? ?? []).first);
    imageUrls.add((json['image_urls'] as List? ?? []).last);

    imagePaths.add((json['storage_paths'] as List? ?? []).first);
    imagePaths.add((json['storage_paths'] as List? ?? []).last);

    return ProductModel(
      description: json["description"] as String? ?? "",
      gender: json["gender"] as String? ?? "",
      nameProduct: json["name_product"] as String? ?? "",
      categoryId: json['category_id'] as String? ?? "",
      docId: json['doc_id'] as String? ?? "",
      imageUrls: imageUrls,
      price: json['price'] as num? ?? 0,
      storagePaths: imagePaths,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'storage_paths': storagePaths,
      "description": description,
      'category_id': categoryId,
      'name_product': nameProduct,
      'doc_id': docId,
      'image_urls': imageUrls,
      'price': price,
    };
  }

  // Map<String, dynamic> toJsonForUpdate() {
  //   return {
  //     'storage_path': storagePath,
  //     "description": description,
  //     'category_id': categoryId,
  //     'gender': gender,
  //     'name_product': nameProduct,
  //     'image_url': imageUrl,
  //     'price': price,
  //   };
  // }

  static ProductModel getDefaultProduct() {
    return ProductModel(
      description: "",
      gender: "",
      nameProduct: "",
      categoryId: "",
      docId: "",
      imageUrls: [],
      price: 0,
      storagePaths: [],
    );
  }

  ProductModel copyWith({
    String? categoryId,
    String? docId,
    List<String>? imageUrls,
    num? price,
    String? gender,
    String? nameProduct,
    String? description,
    String? emailReques,
    List<String>? storagePaths,
  }) {
    return ProductModel(
      description: description ?? this.description,
      categoryId: categoryId ?? this.categoryId,
      docId: docId ?? this.docId,
      imageUrls: imageUrls ?? this.imageUrls,
      price: price ?? this.price,
      nameProduct: nameProduct ?? this.nameProduct,
      gender: gender ?? this.gender,
      storagePaths: storagePaths ?? this.storagePaths,
    );
  }
}
