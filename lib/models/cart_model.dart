import 'package:grow_me_bloc/models/product_model.dart';

class CartModel {
  final String title;
  int count = 0;
  final ProductModel product;

  //<editor-fold desc="Data Methods">
  CartModel({required this.title, required this.count, required this.product});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CartModel &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          //count == other.count &&
          product == other.product);

  @override
  int get hashCode => title.hashCode /*^ count.hashCode*/ ^ product.hashCode;

  @override
  String toString() {
    return 'CartModel{' +
        ' title: $title,' +
        ' count: $count,' +
        ' product: $product,' +
        '}';
  }

  CartModel copyWith({String? title, int? count, ProductModel? product}) {
    return CartModel(
      title: title ?? this.title,
      count: count ?? this.count,
      product: product ?? this.product,
    );
  }

  Map<String, dynamic> toMap() {
    return {'title': this.title, 'count': this.count, 'product': this.product};
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      title: map['title'] as String,
      count: map['count'] as int,
      product: map['product'] as ProductModel,
    );
  }

  /*void increaseCount() {
    count++;
  }

  void decreaseCount() {
    count--;
  }*/

  //</editor-fold>
}
