import 'package:smart_farm_application/base/provider/api_provider.dart';
import 'package:smart_farm_application/configs/api_endpoint.dart';
import 'package:smart_farm_application/model/information.dart';
import 'package:smart_farm_application/repositories/login_repo/login_repository.dart';

import '../../base/custom-exception.dart';

class LoginRepoImp extends LoginRepository {
  final ApiProvider _apiProvider;

  LoginRepoImp(this._apiProvider) : super(_apiProvider);
  @override
  Future<Information> getInformation(String email, String password) async {
    try {
      final payload = {"email": email, "password": password};
      final response = await _apiProvider.post(LOGIN_URL, payload);
      if (response['HttpStatusCode'] != 200) {
        throw ECException(response['message']);
      }
      return Information.fromJson(response);
    } on ECException catch (e) {
      throw ECException(e.toString());
    }
  }
}
