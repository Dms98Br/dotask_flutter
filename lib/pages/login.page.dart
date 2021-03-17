import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurple,
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  style: new TextStyle(color: Colors.white, fontSize: 20),
                  decoration: InputDecoration(
                      labelText: 'Nome',
                      labelStyle: TextStyle(color: Colors.white)),
                ),
                Divider(),
                TextFormField(
                  autofocus: true,
                  keyboardType: TextInputType.emailAddress,
                  style: new TextStyle(color: Colors.white, fontSize: 20),
                  decoration: InputDecoration(
                      labelText: 'E-mail',
                      labelStyle: TextStyle(color: Colors.white)),
                ),
                Divider(),
                TextFormField(
                  autofocus: true,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  style: new TextStyle(color: Colors.white, fontSize: 20),
                  decoration: InputDecoration(
                      labelText: 'Senha',
                      labelStyle: TextStyle(color: Colors.white)),
                ),
                Divider(),
                ButtonTheme(
                    height: 60.0,
                    child: RaisedButton(
                      onPressed: () => {},
                      child: Text(
                        "Entrar",
                        style: TextStyle(color: Colors.deepPurple),
                      ),
                      color: Colors.white,
                    ))
              ],
            ),
          ),
        ));
  }
}
