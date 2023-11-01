class ProductDataModel {
  final String id;
  final String name;
  final String description;
  final double price;
  int count;
  final String imageUrl;

  ProductDataModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.count = 0,
    required this.imageUrl,
  });

  ProductDataModel copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    int? count,
    String? imageUrl,
  }) {
    return ProductDataModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      count: count ?? this.count,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
