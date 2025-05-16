import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grow_me_bloc/data/repository/product_repository.dart';
import 'package:grow_me_bloc/models/product_model.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;
  ProductBloc(this.productRepository) : super(ProductInitial()) {
    on<ProductFetched>(_getAllProducts);
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
}
