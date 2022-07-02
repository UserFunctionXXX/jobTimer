import 'dart:developer';

import 'package:isar/isar.dart';
import 'package:job_timer/app/core/database/database_app.dart';
import 'package:job_timer/app/core/exceptions/failure.dart';
import 'package:job_timer/app/entities/project.dart';
import 'package:job_timer/app/entities/project_status.dart';
import 'package:job_timer/app/view_models/project_model.dart';

import './project_repository.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final DatabaseApp _databaseApp;

  ProjectRepositoryImpl({required DatabaseApp databaseApp})
      : _databaseApp = databaseApp;

  @override
  Future<void> register(Project project) async {
    try {
      final connection = await _databaseApp.openConnection();
      await connection.writeTxn((isar) {
        return isar.projects.put(project);
      });
    } on IsarError catch (e, s) {
      log('Erro ao cadastrar o projeto', error: e, stackTrace: s);
      throw Failure(message: 'Erro ao cadastrar o projeto');
    }
  }

  @override
  Future<List<Project>> findByStatus(ProjectStatus projectStatus) async {
    final connection = await _databaseApp.openConnection();
    final projects = await connection.projects.filter().statusEqualTo(projectStatus).findAll();

    return projects;
  }
}
