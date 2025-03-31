import 'package:dio/dio.dart';
import 'package:shop_app_clothes/pages/models/Product.dart';
import 'package:shop_app_clothes/pages/models/WishlistItem.dart';
import 'package:shop_app_clothes/pages/service/StorageService.dart';

// Hằng số cấu hình
const String _baseUrl = "http://10.0.2.2:8080/api/wishlist";
const int _connectTimeout = 5000; // ms
const int _receiveTimeout = 3000; // ms

class WishListService {
  final Dio _dio;

  WishListService()
    : _dio = Dio(
        BaseOptions(
          baseUrl: _baseUrl,
          connectTimeout: Duration(milliseconds: _connectTimeout),
          receiveTimeout: Duration(milliseconds: _receiveTimeout),
        ),
      );
  Future<String?> _getToken() async => await StorageService.getToken();

  Future<Response> _authorizedRequest(
    String endpoint, {
    String method = 'GET',
    dynamic data,
  }) async {
    final token = await _getToken();
    if (token == null) throw Exception('No token found');

    final options = Options(
      method: method,
      headers: {'Authorization': 'Bearer $token'},
    );

    try {
      return await _dio.request(endpoint, options: options, data: data);
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  Future<List<Product>> getWishlist(int userId) async {
    final response = await _authorizedRequest('/listWishlist', data: {
      "userId": "$userId"
    });
    print(response.data);
    if(response.data["code"] == 1000 && response.data["result"] != null){
      if (response.data["result"] is List) {
        return List<Product>.from(
          response.data["result"].map((item) => Product.fromJson(item)),
        ) ;
      }
    }
    throw Exception('Dữ liệu trả về không đúng định dạng.');
  }

  Future<WishlistItem> addProductToWishlist(int userId, int productId) async {
    final response = await _authorizedRequest(
      '/$userId/add/$productId',
      method: 'POST',
    );
    if (response.data["code"] == 1000 && response.data["result"] != null) {
      return WishlistItem.fromJson(response.data["result"]);
    } else {
      throw Exception(
        'Failed to add product to wishlist: ${response.data["message"] ?? "Unknown error"}',
      );
    }
  }

  Future<void> removeProductFromWishlist(int userId, int productId) async {
    await _authorizedRequest('/$userId/remove/$productId', method: 'DELETE');
  }

  Future<bool> isProductInWishlist(int userId, int productId) async {
    final response = await _authorizedRequest('/$userId/exists/$productId');
    if (response.data is bool) return response.data as bool;
    throw Exception('Dữ liệu trả về không đúng định dạng.');
  }

  String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return "Connection timeout";
      case DioExceptionType.sendTimeout:
        return "Send timeout";
      case DioExceptionType.receiveTimeout:
        return "Receive timeout";
      case DioExceptionType.badResponse:
        return "Server error: ${error.response?.statusCode}";
      default:
        return "Network error";
    }
  }
}
