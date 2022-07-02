import 'package:job_timer/app/entities/project.dart';
import 'package:job_timer/app/entities/project_status.dart';
import 'package:job_timer/app/view_models/project_model.dart';

abstract class ProjectRepository {
  Future<void> register(Project project);

  Future<List<Project>> findByStatus(ProjectStatus projectStatus);
}