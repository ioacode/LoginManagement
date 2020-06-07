class LoginModel{
  itemLogin itemlogin;
  String error;

  LoginModel(this.itemlogin);
  LoginModel.withError(error);

  @override
  String toString() => (' item login : $itemlogin');
}

class itemLogin{
  String id;
  String username;
  
  itemLogin(this.id, this.username);

}
