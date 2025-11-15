import 'package:fidraops_app/data/repositories/project.dart';
import 'package:fidraops_app/view/pages/project_page.dart';
import 'package:fidraops_app/view/widgets/project_card.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  ProjectRepository get projectRepository => ProjectRepository();
  List<Map<String, dynamic>> get projects => [
    {'title': 'Alpha', 'description': 'Description for Project Alpha'},
    {'title': 'Beta', 'description': 'Description for Project Beta'},
    {'title': 'Gamma', 'description': 'Description for Project Gamma'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Projects',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 40,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.lightGreen,
                        shape: BoxShape.circle,
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x29000000),
                            offset: Offset(0, 2),
                            blurRadius: 8,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Icon(
                        LucideIcons.plus,
                        size: 32,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(top: 20, bottom: 120),
                itemCount: projects.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 20,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => ProjectPage(project: projects[index])),
                        );
                      },
                      child: ProjectCard(
                        title: projects[index]['title'],
                        description: projects[index]['description'],
                        color: Colors.primaries[index % Colors.primaries.length],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
