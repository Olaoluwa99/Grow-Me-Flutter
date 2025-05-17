part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

abstract class CartSuccessBase extends CartState {
  final List<CartModel> cartItems;
  CartSuccessBase({required this.cartItems});
}

final class CartAddSuccess extends CartSuccessBase {
  final List<CartModel> cartItems;
  CartAddSuccess({required this.cartItems}) : super(cartItems: cartItems);
}

final class CartRemoveSuccess extends CartSuccessBase {
  final List<CartModel> cartItems;
  CartRemoveSuccess({required this.cartItems}) : super(cartItems: cartItems);
}

final class CartItemIncreaseSuccess extends CartSuccessBase {
  final List<CartModel> cartItems;
  CartItemIncreaseSuccess({required this.cartItems})
    : super(cartItems: cartItems);
}

final class CartItemDecreaseSuccess extends CartSuccessBase {
  final List<CartModel> cartItems;
  CartItemDecreaseSuccess({required this.cartItems})
    : super(cartItems: cartItems);
}

final class CartFailure extends CartState {
  final String error;
  CartFailure(this.error);
}

final class CartLoading extends CartState {}
