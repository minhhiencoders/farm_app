import '../../base/provider/api_provider.dart';
import '../../model/information.dart';

abstract class LoginRepository {
  Future<Information> getInformation(String email, String password);

  LoginRepository(ApiProvider apiProvider);
}
