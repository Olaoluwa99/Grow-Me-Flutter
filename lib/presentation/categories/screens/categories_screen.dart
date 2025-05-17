import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grow_me_bloc/presentation/categories/widgets/category_item.dart';
import 'package:grow_me_bloc/presentation/products/screens/products_screen.dart';

import '../../../bloc/product_bloc/product_bloc.dart';
import '../../cart/screens/cart_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    super.initState();
    final bloc = context.read<ProductBloc>();
    if (bloc.state is ProductInitial) {
      bloc.add(ProductFetched());
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoriesNameList = [
      'Men\'s clothing',
      'Women\'s clothing',
      'Jewelery',
      'Electronics',
    ];
    final categoriesIconList = [
      Icons.man,
      Icons.woman,
      Icons.auto_awesome,
      Icons.devices,
    ];

    //
    final productBloc = BlocProvider.of<ProductBloc>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Categories')),
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

            if (state is! ProductSuccess && state is! ChosenSuccess) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 9 / 16,
              ),
              itemCount: 4,
              itemBuilder: (context, int i) {
                return CategoryItem(
                  onClick: () {
                    productBloc.add(
                      ProductCategoryFetched(categoriesNameList[i]),
                    );
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return ProductsScreen();
                        },
                      ),
                    );
                  },
                  title: categoriesNameList[i],
                  icon: categoriesIconList[i],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
