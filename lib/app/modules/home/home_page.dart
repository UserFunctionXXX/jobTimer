import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:job_timer/app/core/database/database_app.dart';
import 'package:job_timer/app/entities/project.dart';
import 'package:job_timer/app/entities/project_status.dart';
import 'package:job_timer/app/modules/home/widgets/header_project_menu.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
          child: ListTile(
            onTap: _signOut,
            title: Text('Sair'),
          ),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: const Text('Projeto'),
              expandedHeight: 100,
              toolbarHeight: 100,
              centerTitle: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(25),
                ),
              ),
            ),
            SliverPersistentHeader(delegate: HeaderProjectMenu(),pinned: true,),
            SliverList(delegate: SliverChildListDelegate([
              Container(color: Colors.blue,height: 150,),
              Container(color: Colors.blue,height: 150,),
              Container(color: Colors.blue,height: 150,),
              Container(color: Colors.blue,height: 150,),
              Container(color: Colors.blue,height: 150,),
              Container(color: Colors.blue,height: 150,),
              Container(color: Colors.blue,height: 150,),
              Container(color: Colors.blue,height: 150,),
            ]),),
          ],
        ),
      ),
    );
  }

  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      GoogleSignIn().disconnect();
    } catch (e) {}
  }
}
