import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grow_me_bloc/product_bloc/product_bloc.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(ProductFetched());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductFailure) {
            return Center(child: Text(state.error));
          }

          if (state is! ProductSuccess) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          final data = state.products;

          final productId = data[0].id;
          final productTitle = data[0].title;
          final productPrice = data[0].price;
          final productDescription = data[0].description;
          final productCategory = data[0].category;
          final productImage = data[0].image;
          final productRating = data[0].rating.toString();

          return Column(
            children: [
              Text(productId.toString()),
              Text(productTitle),
              Text(productPrice.toString()),
              Text(productDescription),
              Text(productCategory),
              Text(productImage),
              Text(productRating),
            ],
          );
        },
      ),
    );
  }
}
