part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

final class CartStarted extends CartEvent {}

final class CartItemAdded extends CartEvent {
  final CartModel item;
  CartItemAdded(this.item);
}

final class CartItemRemoved extends CartEvent {
  final CartModel item;
  CartItemRemoved(this.item);
}

/*final class CartItemCountIncreased extends CartEvent {
  final String title;
  CartItemCountIncreased(this.title);
}

final class CartItemCountDecreased extends CartEvent {
  final String title;
  CartItemCountDecreased(this.title);
}*/

class CartItemCountIncreased extends CartEvent {
  final CartModel item;
  CartItemCountIncreased(this.item);
}

class CartItemCountDecreased extends CartEvent {
  final CartModel item;
  CartItemCountDecreased(this.item);
}
