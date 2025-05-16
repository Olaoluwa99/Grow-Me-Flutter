import 'package:grow_me_bloc/data/data_provider/product_provider.dart';
import 'package:grow_me_bloc/models/product_model.dart';

class ProductRepository {
  final ProductProvider productProvider;
  ProductRepository(this.productProvider);

  Future<List<ProductModel>> getProductsList() async {
    try {
      final productsData = await productProvider.getAllProducts();

      return ProductModel.fromJsonList(productsData);
    } catch (e) {
      throw e.toString();
    }
  }
}
