import 'package:cmds/global.dart';
import 'package:cmds/screens/dashboard-screen.dart';
import 'package:cmds/screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _rememberMe = false;

  FirebaseUser _currentUser;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.onAuthStateChanged.listen((user) {
      _currentUser = user;
    });
  }

  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<FirebaseUser> _getUser() async {
    if (_currentUser != null) {
      return _currentUser;
    }

    try {
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      final AuthResult authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final FirebaseUser user = authResult.user;

      return user;
    } catch (e) {
      return null;
    }
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      //EMAIL
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Email',
            style: kLabelStyle,
          ),
          SizedBox(height: 10.0),
          Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            height: 60.0,
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              validator: (text) {
                if (text.isEmpty || text.contains('@')) return "Email invalido";
              },
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.white,
                ),
                hintText: 'Digite seu Email',
                hintStyle: kHintTextStyle,
              ),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          //SENHA
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Senha',
                style: kLabelStyle,
              ),
              SizedBox(height: 10.0),
              Container(
                alignment: Alignment.centerLeft,
                decoration: kBoxDecorationStyle,
                height: 60.0,
                child: TextFormField(
                  obscureText: true,
                  validator: (text) {
                    if (text.isEmpty || text.length < 6) {
                      return "Senha inválida";
                    }
                  },
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'OpenSans',
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14.0),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.white,
                    ),
                    hintText: 'Digite sua senha',
                    hintStyle: kHintTextStyle,
                  ),
                ),
              ),
            ],
          ),
          //ESQUECI A SENHA
          Container(
            alignment: Alignment.centerRight,
            child: FlatButton(
              onPressed: () => print('Forgot Password Button Pressed'),
              padding: EdgeInsets.only(right: 0.0),
              child: Text(
                'Esqueceu a senha ?',
                style: kLabelStyle,
              ),
            ),
          ),
          //LEMBRE DE MIM
          Container(
            height: 20.0,
            child: Row(
              children: <Widget>[
                Theme(
                  data: ThemeData(unselectedWidgetColor: Colors.white),
                  child: Checkbox(
                    value: _rememberMe,
                    checkColor: Colors.green,
                    activeColor: Colors.white,
                    onChanged: (value) {
                      setState(() {
                        _rememberMe = value;
                      });
                    },
                  ),
                ),
                Text(
                  'Lembre de mim',
                  style: kLabelStyle,
                ),
              ],
            ),
          ),
          //BOTÃO DE ENTRAR
          Container(
            padding: EdgeInsets.symmetric(vertical: 25.0),
            width: double.infinity,
            child: RaisedButton(
              elevation: 5.0,
              onPressed: () {
                if (_formKey.currentState.validate()) {}
              },
              padding: EdgeInsets.all(15.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              color: Colors.white,
              child: Text(
                'Entrar',
                style: TextStyle(
                  color: Color(0xFF527DAA),
                  letterSpacing: 1.5,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
          ),

          //BOTÃO DE CRIAR CONTA
          Container(
            padding: EdgeInsets.symmetric(vertical: 25.0),
            width: double.infinity,
            child: RaisedButton(
              elevation: 5.0,
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SignUpScreen()));
              },
              padding: EdgeInsets.all(15.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              color: Colors.white,
              child: Text(
                'Criar conta',
                style: TextStyle(
                  color: Color(0xFF527DAA),
                  letterSpacing: 1.5,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignIn() {
    return Column(
      children: <Widget>[
        Text(
          '- OU -',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 20.0),
        Text(
          'Entrar com',
          style: kLabelStyle,
        ),
      ],
    );
  }

  Widget _buildSocial(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildSocial(
            () => print('Logar com facebook'),
            AssetImage(
              'assets/images/facebook.jpg',
            ),
          ),
          _buildSocial(
            () async {
              final FirebaseUser user = await _getUser();
              if (user == null) {
                _scaffoldKey.currentState.showSnackBar(
                  SnackBar(
                    content:
                        Text('Não foi possível fazer o login. Tente novamente'),
                    backgroundColor: Colors.red,
                  ),
                );
              } else {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => DashBoardScreen()));
              }
            },
            AssetImage(
              'assets/images/google.jpg',
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFF73AEF5),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'INICIAR SESSÃO',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF73AEF5),
                      Color(0xFF61A4F1),
                      Color(0xFF478DE0),
                      Color(0xFF398AE5),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 30.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 30.0),
                      _buildForm(),
                      _buildSignIn(),
                      _buildSocialRow(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
