import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grow_me_bloc/bloc/cart_bloc/cart_bloc.dart';
import 'package:grow_me_bloc/models/cart_model.dart';
import 'package:grow_me_bloc/presentation/products/widgets/product_item.dart';

import '../../../bloc/product_bloc/product_bloc.dart';
import '../../cart/screens/cart_screen.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back, semanticLabel: 'Back button'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.shopping_cart),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return CartScreen();
              },
            ),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductFailure) {
              return Center(child: Text(state.error));
            }

            if (state is! ProductSuccess &&
                state is! ProductFailure &&
                state is! ChosenSuccess) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }

            if (state is ChosenSuccess) {
              return BlocBuilder<CartBloc, CartState>(
                builder: (context, cartState) {
                  if (cartState is CartSuccessBase) {
                    return GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 9 / 16,
                      ),
                      itemCount: state.products.length,
                      itemBuilder: (context, int i) {
                        return ProductItem(
                          item: state.products[i],
                          onClick: () {
                            final newItem = CartModel(
                              title: state.tag,
                              count: 1,
                              product: state.products[i],
                            );
                            bool isDuplicateItem = false;
                            for (var nItem in cartState.cartItems) {
                              if (nItem.product == state.products[i]) {
                                isDuplicateItem = true;
                              }
                            }

                            if (isDuplicateItem) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Item is already in Cart. Select another item",
                                  ),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Added to Cart")),
                              );
                              context.read<CartBloc>().add(
                                CartItemAdded(newItem),
                              );
                            }
                          },
                        );
                      },
                    );
                  }
                  return Center(child: Text('---'));
                },
              );
            }
            return Center(child: Text('-------'));
          },
        ),
      ),
    );
  }
}
