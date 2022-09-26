import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
      return Scaffold(
        appBar: AppBar(
          title: Text('eseva'),
          centerTitle: true,
          actions: [
            TextButton(onPressed: (){}, child: Text('Logout'))
          ],
        ),
        body: Center(
          child: Text(user!.displayName.toString()),
        ),
      );
  }
}
