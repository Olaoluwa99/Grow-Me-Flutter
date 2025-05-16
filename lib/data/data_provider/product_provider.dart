import 'package:http/http.dart' as http;

class ProductProvider {
  Future<String> getAllProducts() async {
    try {
      //String apiKey = '';
      final res = await http.get(
        Uri.parse('https://fakestoreapi.com/products'),
      );
      return res.body;
    } catch (e) {
      throw e.toString();
    }
  }
}
