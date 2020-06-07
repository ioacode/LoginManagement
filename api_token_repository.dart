class ApiTokenRepository{
  final ApiTokenProvider _apiTokenProvider = new ApiTokenProvider();

  Future<TokenModel> fetchToken() => _apiTokenProvider.getTokenGenerate();
  Future<dynamic> fetchLogin(username, password) => _apiTokenProvider.getLogin(username, password);
}
