abstract class ApiProvider {
  Future<dynamic> get(String url);
  Future<dynamic> getHasHeader(String url, dynamic header);
  Future<dynamic> post(String url, dynamic body);
  Future<dynamic> postMultipart(String url, dynamic file, dynamic field);
}
