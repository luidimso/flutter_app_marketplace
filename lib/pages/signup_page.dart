import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Account"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                  hintText: "Name"
              ),
              validator: (text) {
                if(text.isEmpty) return "Invalid name!";
                else return null;
              },
            ),
            SizedBox(
              height: 16,
            ),
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
                    hintText: "Address"
                ),
                validator: (text) {
                  if(text.isEmpty) return "Invalid address!";
                  else return null;
                }
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
            SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 44,
              child: RaisedButton(
                onPressed: () {
                  if(_formKey.currentState.validate()) {

                  }
                },
                child: Text("Create Account",
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
      ),
    );
  }
}
