import 'package:eseva/AuthenticationService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/*class HomePage extends StatelessWidget {
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
}*/

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Stream<QuerySnapshot> _stream =
      FirebaseFirestore.instance.collection('eSevaList').snapshots();
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    //navigation pane for home
    const Text('Index 0 : Home'),

    //navigation pane for eseva list
    StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('eSevaList').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('We do not have data');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          /*return ListView(
            children: snapshot.data!.docs.map((sevalist) {
              return Center(
                child: ListTile(
                  title: Text(sevalist['Name']),
                ),
              );
            }).toList(),
          );*/
          return ListView.separated(
            separatorBuilder:  (BuildContext context, int index) => const Divider(),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
              return ListTile(
                title: Column(
                  children: [
                    Text('SEVA DETAILS', style: Theme.of(context).textTheme.overline,),
                    Text(documentSnapshot['Name'], style: Theme.of(context).textTheme.titleLarge,),
                    Text('Available: ' + documentSnapshot['Qty'].toString()),
                    Text('Seva Price: ₹' + documentSnapshot['Seva_price'].toString() + '/-'),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(documentSnapshot['Name'] + ' seva is not enabled. Please check after sometime.')));
                },
              );
            },
          );
        }),

    //navigation pane for profile
    const Text('Index 2 : Profile')
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('eseva'),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () {
                context.read<AuthenticationService>().logout();
              },
              child: Text('Logout'))
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.roofing_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.volunteer_activism_outlined), label: 'ESeva'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined), label: 'Profile')
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
