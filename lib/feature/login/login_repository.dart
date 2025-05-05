import '../../network/api_url.dart';
import '../../network/base_api.dart';
import 'model/login_response.dart';

class LoginRepository {
  Future<LoginResponse> postLogin(Map<String, dynamic> body) async {
    final response = await BaseAPI.post(ApiUrl.login, body);
    return LoginResponse.fromJson(response.toJson());
  }

  Future<LoginResponse> postLogout(Map<String, dynamic> body) async {
    final response = await BaseAPI.post(ApiUrl.logout, body);
    return LoginResponse.fromJson(response.toJson());
  }
}
