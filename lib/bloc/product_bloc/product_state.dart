part of 'product_bloc.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductSuccess extends ProductState {
  final List<ProductModel> products;
  ProductSuccess({required this.products});
}

final class ProductFailure extends ProductState {
  final String error;
  ProductFailure(this.error);
}

final class ProductLoading extends ProductState {}

final class ChosenSuccess extends ProductState {
  final List<ProductModel> products;
  final String tag;
  ChosenSuccess({required this.products, required this.tag});
}
