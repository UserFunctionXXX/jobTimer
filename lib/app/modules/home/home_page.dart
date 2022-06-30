import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:job_timer/app/core/database/database_app.dart';
import 'package:job_timer/app/entities/project.dart';
import 'package:job_timer/app/entities/project_status.dart';
import 'package:job_timer/app/modules/home/controller/home_controller.dart';
import 'package:job_timer/app/modules/home/widgets/header_project_menu.dart';
import 'package:job_timer/app/view_models/project_model.dart';

class HomePage extends StatelessWidget {
  final HomeController controller;
  const HomePage({Key? key, required this.controller}) : super(key: key);

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
            SliverPersistentHeader(
              delegate: HeaderProjectMenu(),
              pinned: true,
            ),
            BlocSelector<HomeController, HomeState, bool>(
              selector: (state) => state.status == HomeStatus.loading,
              bloc: controller,
              builder: (context, showLoading) {
                return SliverVisibility(
                  visible: showLoading,
                  sliver: SliverToBoxAdapter(
                      child: SizedBox(
                          height: 50,
                          child: Center(
                              child: CircularProgressIndicator.adaptive()))),
                );
              },
            ),
            BlocSelector<HomeController, HomeState, List<ProjectModel>>(
              selector: (state) => state.projects,
              bloc: controller,
              builder: (context, projects) {
                return SliverList(
                  delegate: SliverChildListDelegate(projects
                      .map((project) => ListTile(
                            title: Text(project.name),
                            subtitle: Text('${project.estimate}'),
                          ))
                      .toList()),
                );
              },
            ),
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
