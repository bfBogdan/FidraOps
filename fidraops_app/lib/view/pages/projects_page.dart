import 'package:fidraops_app/view/widgets/project_card.dart';
import 'package:flutter/material.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  List<Map<String, dynamic>> get projects => [
        {
          'title': 'Alpha',
          'description': 'Description for Project Alpha',
        },
        {
          'title': 'Beta',
          'description': 'Description for Project Beta',
        },
        {
          'title': 'Gamma',
          'description': 'Description for Project Gamma',
        },
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
            const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                'Projects',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(top: 20, bottom: 120),
                itemCount: projects.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    child: ProjectCard(
                      title: projects[index]['title'],
                      description: projects[index]['description'],
                      color: Colors.primaries[index % Colors.primaries.length],
                    ),
                  );
                },
              )
            ),
          ],
        ),
      ),
    );
  }
}