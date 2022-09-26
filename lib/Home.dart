import 'package:eseva/AuthenticationService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            TextButton(onPressed: (){
              context.read<AuthenticationService>().logout();
            }, child: Text('Logout'))
          ],
        ),
        body: Center(
          child: Text(user!.displayName.toString()),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.checklist), label: 'ESeva'),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Profile')
          ],
        ),
      );
  }
}
