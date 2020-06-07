class ApiTokenProvider {
  ApiSession apiSession = new ApiSession();
  securityModule securitymodule = new securityModule();

  Future<TokenModel> getTokenGenerate() async { 
    var bodyRequest = {
      "grant_type": "antagonis",
      "client_id": generateMd5(client_modif(CLIENT_ID, 1)),,
      "client_secret": generateMd5(client_modif(CLIENT_SECRET, 2)),
    };

    try{
      final response = await ApiServiceHit("token", bodyRequest);
      debugPrint('response success : ${response.data.toString()}');
      var accessToken = response.data["data"]["access_token"].toString();    
      return TokenModel(accessToken);
    }catch(error){
      debugPrint('Error request : $error');
      return TokenModel.withError(error);
    }
  }

  Future<LoginModel> getLogin(String username, String password) async{  
    var bodyRequest = {
      "username": username,
      "password": password, 
    }; 

    try{
      final response = await ApiServiceHit("other", bodyRequest);
      debugPrint('response success : ${response.data.toString()}');

      itemLogin  item = itemLogin(response.data["data"]["id_username"].toString(),response.data["data"]["username"].toString());

      return LoginModel(item);
    }catch(error){
      debugPrint('Error request : $error');
      return TokenModel.withError(error);
    }
  }
}
