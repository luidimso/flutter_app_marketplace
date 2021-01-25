import 'package:flutter/material.dart';
import 'package:flutter_app_marketplace/models/user_model.dart';
import 'package:flutter_app_marketplace/pages/signup_page.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                Navigator.of(context).pushReplacement((MaterialPageRoute(
                  builder: (context) => SignupPage()
                )));
              },
              child: Text("CREATE ACCOUNT",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white
                ),
              )
          )
        ],
      ),
      body: ScopedModelDescendant<User>(
        builder: (context, child, model) {
          if(model.isLoading) {
            return Center(
                child: CircularProgressIndicator()
            );
          }
          return Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16),
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Email"
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (text) {
                    if(text.isEmpty || !text.contains("@")) return "Invalid email!";
                    else return null;
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                    decoration: InputDecoration(
                        hintText: "Password"
                    ),
                    obscureText: true,
                    validator: (text) {
                      if(text.isEmpty || text.length < 6) return "Invalid password!";
                      else return null;
                    }
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () {},
                    child: Text("Forgot my password",
                      textAlign: TextAlign.right,
                    ),
                    padding: EdgeInsets.zero,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 44,
                  child: RaisedButton(
                    onPressed: () {
                      if(_formKey.currentState.validate()) {
                        model.signin();
                      }
                    },
                    child: Text("Login",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white
                      ),
                    ),
                    color: Theme.of(context).primaryColor,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
