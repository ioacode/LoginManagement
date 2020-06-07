
class UiToken extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/bg_plash.png'),
                fit: BoxFit.cover)),
        child: Column(children: <Widget>[
          Expanded(child: loginContent()),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                  Text("Do't Have Account ? "),
                  Text("Register", style: TextStyle(fontWeight: FontWeight.bold),)
                ])),
          )
        ]));
  }
}

class loginContent extends StatefulWidget {

  @override
  _loginContentState createState() => _loginContentState();
}

class _loginContentState extends State<loginContent> {
  final TokenBloc _tokenBloc = new TokenBloc();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isHiddenPassword = true;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _tokenBloc.add(startLoginTokenEvent());
    super.initState();
  }

  void _passwordVisibility() {
    setState(() {
      _isHiddenPassword = !_isHiddenPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: BlocProvider<TokenBloc>(
            create: (context) => _tokenBloc,
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/ilustrationLogin.png'),
                                  fit: BoxFit.contain))),
                    ),
                    SizedBox(height: 16),
                    TextField(
                        controller: usernameController,
                        cursorColor: Colors.white,
                        decoration: new InputDecoration(
                            labelText: "Email",
                            suffixIcon: Icon(Icons.email),
                            labelStyle: TextStyle(color: Colors.white70),
                            enabledBorder: new UnderlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.white70)))),
                    SizedBox(height: 8),
                    TextField(
                        controller: passwordController,
                        obscureText: _isHiddenPassword,
                        cursorColor: Colors.white,
                        decoration: new InputDecoration(
                            labelText: "Password",
                            suffixIcon: GestureDetector(
                              onTap: () {
                                _passwordVisibility();
                              },
                              child: Icon(
                                _isHiddenPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ),
                            labelStyle: TextStyle(color: Colors.white70),
                            enabledBorder: new UnderlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.white70)))),
                    SizedBox(height: 16),
                    Container(
                      height: 45,
                      width: double.infinity,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.white30,
                        onPressed: () {
                          _tokenBloc.add(FetchLoginTokenEvent(usernameController.text, passwordController.text));
                        },
                      ),
                    ),
                    SizedBox(height: 12),
                    Container(
                      height: 45,
                      alignment: Alignment.topRight,
                      child: Text(
                        "Forget Password",
                        style: TextStyle(color: Colors.pink),
                      ),
                    ),
                    MessageToken()
                  ],
                ),
              ),
            )));
  }
}

class MessageToken extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: BlocBuilder<TokenBloc, TokenState>(builder: (context, state) {
      if (state is TokenLoginLoading) {
        return WidgetCircularLoading();
      } else if (state is LoginLoaded) {
        return Center(
          child: Text('$state'),
        );
      } else if (state is TokenLoginFailed) {
        var messageFailed = state.errorMessage;
        return Center(
          child: Text('$messageFailed'),
        );
      } else {
        return Container(color: Colors.transparent);
      }
    }));
  }
}

class WidgetCircularLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Platform.isIOS
          ? CupertinoActivityIndicator()
          : CircularProgressIndicator(),
    );
  }
}
