import 'package:bloc/bloc.dart';
import 'package:grow_me_bloc/models/cart_model.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final List<CartModel> _allItems = [];

  CartBloc() : super(CartInitial()) {
    on<CartStarted>(_onStarted);
    on<CartEvent>((event, emit) {});
    on<CartItemAdded>(_addToCart);
    on<CartItemRemoved>(_removeFromCart);
    on<CartItemCountIncreased>(_increaseCount);
    on<CartItemCountDecreased>(_decreaseCount);
    on<CartCleared>(_clearCart);

    add(CartStarted());
  }

  void _onStarted(CartStarted event, Emitter<CartState> emit) {
    emit(CartLoadSuccess(cartItems: _allItems));
  }

  void _addToCart(CartItemAdded event, Emitter<CartState> emit) {
    emit(CartLoading());
    _allItems.add(event.item);
    emit(CartAddSuccess(cartItems: _allItems));
  }

  void _removeFromCart(CartItemRemoved event, Emitter<CartState> emit) {
    emit(CartLoading());
    _allItems.remove(event.item);
    emit(CartRemoveSuccess(cartItems: _allItems));
  }

  void _increaseCount(CartItemCountIncreased event, Emitter<CartState> emit) {
    emit(CartLoading());

    final updatedItems =
        _allItems.map((item) {
          if (item.product.id == event.item.product.id) {
            return item.copyWith(count: item.count + 1);
          }
          return item;
        }).toList();

    _allItems
      ..clear()
      ..addAll(updatedItems);

    emit(CartItemIncreaseSuccess(cartItems: List.from(_allItems)));
  }

  void _decreaseCount(CartItemCountDecreased event, Emitter<CartState> emit) {
    emit(CartLoading());

    final updatedItems =
        _allItems.map((item) {
          if (item.product.id == event.item.product.id && item.count > 1) {
            return item.copyWith(count: item.count - 1);
          }
          return item;
        }).toList();

    _allItems
      ..clear()
      ..addAll(updatedItems);

    emit(CartItemDecreaseSuccess(cartItems: List.from(_allItems)));
  }

  void _clearCart(CartCleared event, Emitter<CartState> emit) {
    emit(CartLoading());
    _allItems.clear();
    emit(CartClearedSuccess('All items have been Checked out.'));
    emit(CartLoadSuccess(cartItems: _allItems));
  }
}
