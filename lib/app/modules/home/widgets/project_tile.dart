import 'package:flutter/material.dart';
import 'package:job_timer/app/core/ui/job_timer_icons.dart';
import 'package:job_timer/app/view_models/project_model.dart';

class ProjectTile extends StatelessWidget {
  final ProjectModel projectModel;
  const ProjectTile({super.key, required this.projectModel});

  @override
  Widget build(BuildContext context) {
    final totalTasks = projectModel.tasks.fold<int>(0,((previousValue, task) => previousValue+= task.duration));
    var percent = 0.0;

    if(totalTasks > 0){
      percent = totalTasks/projectModel.estimate;
    }

    return Container(
      constraints: BoxConstraints(maxHeight: 90),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!, width: 4),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(projectModel.name),
                Icon(
                  JobTimerIcons.angle_double_right,
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                children: [
                  Expanded(
                      child: LinearProgressIndicator(
                    value: percent,
                    backgroundColor: Colors.grey[400],
                    color: Theme.of(context).primaryColor,
                  )),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                    child: Text('${projectModel.estimate}h'),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
