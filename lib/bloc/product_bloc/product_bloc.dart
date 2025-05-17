import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grow_me_bloc/data/repository/product_repository.dart';
import 'package:grow_me_bloc/models/product_model.dart';

part 'product_event.dart';
part 'product_state.dart';

/*class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;
  ProductBloc(this.productRepository) : super(ProductInitial()) {
    on<ProductFetched>(_getAllProducts);
    on<ProductCategoryFetched>(_setChosenCategory);
  }

  void _getAllProducts(ProductFetched event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final productList = await productRepository.getProductsList();
      emit(ProductSuccess(products: productList));
    } catch (e) {
      emit(ProductFailure(e.toString()));
    }
  }

  void _setChosenCategory(
    ProductCategoryFetched event,
    Emitter<ProductState> emit,
  ) {
    if (state is ProductSuccess) {
      final currentState = state as ProductSuccess;
      emit(ChosenSuccess(products: currentState.products, tag: event.category));
    } else if (state is ChosenSuccess) {
      final currentState = state as ChosenSuccess;

      final filteredList = filterProductsByCategory(
        currentState.products,
        event.category,
      );

      emit(ChosenSuccess(products: filteredList, tag: event.category));
    }
  }

  List<ProductModel> filterProductsByCategory(
    List<ProductModel> allProducts,
    String imputedString,
  ) {
    return allProducts
        .where((product) => product.category == imputedString)
        .toList();
  }
}*/

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  // Keep the original full list of products
  List<ProductModel> _allProducts = [];

  ProductBloc(this.productRepository) : super(ProductInitial()) {
    on<ProductFetched>(_getAllProducts);
    on<ProductCategoryFetched>(_setChosenCategory);
  }

  void _getAllProducts(ProductFetched event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      _allProducts = await productRepository.getProductsList();
      emit(ProductSuccess(products: _allProducts));
    } catch (e) {
      emit(ProductFailure(e.toString()));
    }
  }

  void _setChosenCategory(
    ProductCategoryFetched event,
    Emitter<ProductState> emit,
  ) {
    final filteredList = filterProductsByCategory(_allProducts, event.category);
    emit(ChosenSuccess(products: filteredList, tag: event.category));
  }

  List<ProductModel> filterProductsByCategory(
    List<ProductModel> allProducts,
    String imputedString,
  ) {
    return allProducts
        .where(
          (product) =>
              product.category.toLowerCase() == imputedString.toLowerCase(),
        )
        .toList();
  }
}
