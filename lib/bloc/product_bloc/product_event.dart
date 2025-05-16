part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}

final class ProductFetched extends ProductEvent {}

//class ProductCategoryChosen extends ProductEvent {}

class ProductCategoryFetched extends ProductEvent {
  final String category;
  ProductCategoryFetched(this.category);
}
