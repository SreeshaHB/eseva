import 'package:eseva/AuthenticationService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.read<AuthenticationService>().signInWithGoogle();
          },
          child: Text('Sign in with google'),
        ),
      ),
    );
  }
}
