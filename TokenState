 import 'package:test_helloworld/TestingGetToken/Feature/Login/model/login_module.dart'; 

abstract class TokenState {}

class TokenLoginInitialized extends TokenState{}

class TokenLoginLoading extends TokenState {}

class TokenLoginFailed extends TokenState{
  String errorMessage;
  TokenLoginFailed(this.errorMessage);
}

class LoginLoaded extends TokenState{
  LoginModel loginModel;

  LoginLoaded(this.loginModel);
}
