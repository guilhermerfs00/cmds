import 'package:cmds/global.dart';
import 'package:cmds/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFF73AEF5),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'CRIAR CONTA',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          if (model.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return AnnotatedRegion<SystemUiOverlayStyle>(
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
                            Form(
                              key: _formKey,
                              //Nome Completo
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Nome completo',
                                    style: kLabelStyle,
                                  ),
                                  SizedBox(height: 10.0),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    decoration: kBoxDecorationStyle,
                                    height: 60.0,
                                    child: TextFormField(
                                      controller: _nameController,
                                      // ignore: missing_return
                                      validator: (text) {
                                        if (text.isEmpty)
                                          return "Nome inválido";
                                      },
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'OpenSans',
                                      ),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding:
                                            EdgeInsets.only(top: 14.0),
                                        prefixIcon: Icon(
                                          Icons.person,
                                          color: Colors.white,
                                        ),
                                        hintText: 'Digite seu nome',
                                        hintStyle: kHintTextStyle,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30.0,
                                  ),
                                  //Email
                                  Text(
                                    'Email',
                                    style: kLabelStyle,
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    decoration: kBoxDecorationStyle,
                                    height: 60.0,
                                    child: TextFormField(
                                      controller: _emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      // ignore: missing_return
                                      validator: (text) {
                                        if (text.isEmpty || !text.contains("@"))
                                          return "Email invalido";
                                      },
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'OpenSans',
                                      ),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding:
                                            EdgeInsets.only(top: 14.0),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          controller: _passController,
                                          obscureText: true,
                                          // ignore: missing_return
                                          validator: (text) {
                                            if (text.isEmpty ||
                                                text.length < 6) {
                                              return "Senha inválida";
                                            }
                                          },
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'OpenSans',
                                          ),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding:
                                                EdgeInsets.only(top: 14.0),
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
                                  //BOTÃO DE CRIAR CONTA
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 25.0),
                                    width: double.infinity,
                                    child: RaisedButton(
                                      elevation: 5.0,
                                      onPressed: () {
                                        if (_formKey.currentState.validate()) {
                                          Map<String, dynamic> userData = {
                                            'name': _nameController.text,
                                            'email': _emailController.text,
                                          };

                                          model.signUp(
                                              userData: userData,
                                              pass: _passController.text,
                                              onSuccess: _onSuccess,
                                              onFail: _onFail);
                                        }
                                      },
                                      padding: EdgeInsets.all(15.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
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
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  void _onSuccess() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        'Usuário criado com secesso !',
      ),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 2),
    ));
    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context).pop();
    });
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        'Falha ao Entrar !',
      ),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }
}
