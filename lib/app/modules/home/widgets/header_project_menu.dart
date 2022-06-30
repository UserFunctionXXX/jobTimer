import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_timer/app/entities/project_status.dart';

class HeaderProjectMenu extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return LayoutBuilder(builder: (context, constrains) {
      return Container(
        height: constrains.maxHeight,
        color: Colors.white,
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: constrains.maxWidth * .5,
              child: DropdownButtonFormField<ProjectStatus>(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    contentPadding: EdgeInsets.all(10),
                    isCollapsed: true),
                items: ProjectStatus.values.map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(e.label),
                  ),
                ).toList(),
                onChanged: (value) {},
              ),
            ),
            SizedBox(
              width: constrains.maxWidth * .4,
              child: ElevatedButton.icon(
                onPressed: () {
                  Modular.to.pushNamed('/project/register/');
                },
                icon: Icon(Icons.add),
                label: Text('Novo Projeto'),
              ),
            ),
          ],
        ),
      );
    });
  }

  @override
  double get maxExtent => 80;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
