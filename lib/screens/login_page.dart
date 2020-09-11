import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pokedex/models/status_auth.dart';
import 'package:pokedex/providers/auth.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: authProvider.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 100),
                TextFormField(
                  controller: authProvider.emailController,
                  validator: authProvider.emailValidator,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    filled: true,
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  obscureText: true,
                  controller: authProvider.passwordController,
                  validator: authProvider.passwordValidator,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.visibility),
                    labelText: 'Password',
                    filled: true,
                  ),
                ),
                SizedBox(height: 100),
                authProvider.status == Status.Authenticating
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : RaisedButton(
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          if (authProvider.formKey.currentState.validate()) {
                            authProvider.signIn();
                          }
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
