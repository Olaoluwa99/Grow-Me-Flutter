import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grow_me_bloc/data/data_provider/product_provider.dart';
import 'package:grow_me_bloc/presentation/cart/screens/categories_screen.dart';
import 'package:grow_me_bloc/product_bloc/product_bloc.dart';

import 'data/repository/product_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ProductRepository(ProductProvider()),
      child: BlocProvider(
        create: (context) => ProductBloc(context.read<ProductRepository>()),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          home: const CategoriesScreen(),
        ),
      ),
    );
  }
}
