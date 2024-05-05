class ProductModel {
  final String categoryId;
  final String docId;
  final List<String> imageUrls;
  final String nameProduct;
  final num price;
  final String description;
  final bool like;
  final bool chek;

  ProductModel({
    this.like = false,
    this.chek = false,
    required this.description,
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
      nameProduct: json["name_product"] as String? ?? "",
      categoryId: json['category_id'] as String? ?? "",
      docId: json['doc_id'] as String? ?? "",
      imageUrls: imageUrls,
      price: json['price'] as num? ?? 0,
    );
  }

  factory ProductModel.fromJsonForSql(Map<String, dynamic> json) {
    List<String> imageUrls = (json["image_urls"] as String? ?? '').split(" ");

    return ProductModel(
      description: json["description"] as String? ?? "",
      nameProduct: json["name_product"] as String? ?? "",
      categoryId: "",
      docId: json['doc_id'] as String? ?? "",
      imageUrls: imageUrls,
      price: json['price'] as num? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "description": description,
      'name_product': nameProduct,
      'doc_id': docId,
      'image_urls': imageUrls.join(" "),
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
      nameProduct: "",
      categoryId: "",
      docId: "",
      imageUrls: [],
      price: 0,
    );
  }

  ProductModel copyWith({
    String? categoryId,
    String? docId,
    List<String>? imageUrls,
    num? price,
    String? nameProduct,
    String? description,
    bool? like,
  }) {
    return ProductModel(
      like: like ?? this.like,
      description: description ?? this.description,
      categoryId: categoryId ?? this.categoryId,
      docId: docId ?? this.docId,
      imageUrls: imageUrls ?? this.imageUrls,
      price: price ?? this.price,
      nameProduct: nameProduct ?? this.nameProduct,
    );
  }
}
