class TokenBloc extends Bloc<TokenTokenEvent, TokenState> {
  ApiTokenRepository _apiTokenRepository = new ApiTokenRepository(); 
  @override
  TokenState get initialState => TokenLoginInitialized();

  @override
  Stream<TokenState> mapEventToState(TokenTokenEvent event) async* {
    try{
      if (event is FetchLoginTokenEvent){
        yield TokenLoginLoading();
        TokenModel tokenModel = await _apiTokenRepository.fetchToken();
        if (tokenModel.itemToken.isEmpty){
          yield TokenLoginFailed(tokenModel.error);
          return;
        }

        final prefs = await SharedPreferences.getInstance();
        prefs.setString('token', tokenModel.itemToken);
         
        LoginModel loginModel = await _apiTokenRepository.fetchLogin(event.username, event.password);
        if (loginModel.error.isNotEmpty){
          yield  LoginLoaded(loginModel);
          return;
        }
        yield TokenLoginFailed(loginModel.error);
      }
    }catch(error){
      debugPrint(error);
    }
  }
}
