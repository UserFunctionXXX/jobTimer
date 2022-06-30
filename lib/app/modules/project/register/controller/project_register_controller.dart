import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:job_timer/app/entities/project_status.dart';
import 'package:job_timer/app/services/projects/project_service.dart';
import 'package:job_timer/app/view_models/project_model.dart';

part 'project_register_state.dart';

class ProjectRegisterController extends Cubit<ProjectRegisterStatus> {
  //final DatabaseApp _databaseApp;
  final ProjectService _projectService;

  ProjectRegisterController({required ProjectService projectService})
      : _projectService = projectService,
        super(ProjectRegisterStatus.initial);

  Future<void> registerProject(String name, int estimate) async {
    try {
      emit(ProjectRegisterStatus.loading);
      final project = ProjectModel(
        estimate: estimate,
        name: name,
        status: ProjectStatus.em_andamento,
        tasks: [],
      );
      await _projectService.register(project);
      emit(ProjectRegisterStatus.success);
    } catch (e,s) {
      log('Erro ao salvar Project',error:e,stackTrace:s);
      emit(ProjectRegisterStatus.failure);
    }
  }
}
