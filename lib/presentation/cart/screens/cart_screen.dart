import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/cart_bloc/cart_bloc.dart';
import '../../../models/cart_model.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back, semanticLabel: 'Back button'),
        ),
      ),
      body: BlocListener<CartBloc, CartState>(
        listener: (context, state) {
          /*if (state is CartAddSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("Item added to cart")));
          }*/
          if (state is CartRemoveSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("Item removed from cart")));
          }
          if (state is CartLoading) {
            // optional loading snack or UI changes
          }

          if (state is CartClearedSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.notice)));
          }
        },
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading || state is CartInitial) {
              return Center(child: CircularProgressIndicator.adaptive());
            }

            if (state is CartFailure) {
              return Center(child: Text(state.error));
            }

            if (state is CartSuccessBase) {
              if (state.cartItems.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.cartItems.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: CartItem(
                                onClick: () {
                                  context.read<CartBloc>().add(
                                    CartItemRemoved(
                                      CartModel(
                                        title: state.cartItems[index].title,
                                        count: state.cartItems[index].count,
                                        product: state.cartItems[index].product,
                                      ),
                                    ),
                                  );
                                },
                                onIncreaseClick: () {
                                  context.read<CartBloc>().add(
                                    CartItemCountIncreased(
                                      state.cartItems[index],
                                    ),
                                  );
                                },
                                onDecreaseClick: () {
                                  context.read<CartBloc>().add(
                                    CartItemCountDecreased(
                                      state.cartItems[index],
                                    ),
                                  );
                                },
                                item: state.cartItems[index],
                              ),
                            );
                          },
                        ),
                      ),
                      if (state.cartItems.isNotEmpty)
                        ElevatedButton(
                          onPressed: () {
                            context.read<CartBloc>().add(CartCleared());
                          },
                          style: ButtonStyle(
                            padding: WidgetStateProperty.all<EdgeInsets>(
                              EdgeInsets.symmetric(
                                horizontal: 24.0,
                                vertical: 16.0,
                              ),
                            ),
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Checkout',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 8),
                                Icon(Icons.shopping_cart_checkout),
                              ],
                            ),
                          ),
                        ),
                      SizedBox(height: 24),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: Text('Cart is currently Empty. Add an item to cart'),
                );
              }
            }
            return Center(child: Text('-----'));
          },
        ),
      ),
    );
  }
}
