import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Container(
          child: Column(
        children: [
          ElevatedButton(
            onPressed: _signOut,
            child: Text('Deslogar'),
          )
        ],
      )),
    );
  }

  Future<void> _signOut() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) {
        await FirebaseAuth.instance.signOut();
      }
      Modular.to.navigate('/');
    });
  }
}