
import 'package:jwt_decoder/jwt_decoder.dart';

class TokenHelper {
   static int? getUserIdFromToken(String token) {
       try {
           Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
           return decodedToken['userId']; // Lấy userId từ token
       } catch (e) {
           print("Invalid Token: $e");
           return null;
       }
   }
}