import 'package:fidraops_app/providers/project.dart';
import 'package:fidraops_app/data/repositories/http_service.dart';
import 'package:fidraops_app/providers/app_state.dart';
import 'package:fidraops_app/view/widgets/project_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProjectProvider()
        ..fetchProjects(context.read<HttpService>(), context.read<AppState>()),
      child: Builder(
        builder: (context) {
          final projectProvider = context.watch<ProjectProvider>();
          final projects = projectProvider.projects;

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
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () => projectProvider.fetchProjects(
                        context.read<HttpService>(),
                        context.read<AppState>(),
                      ),
                      child: projectProvider.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : projectProvider.error != null
                          ? Center(
                              child: Text('Error: ${projectProvider.error}'),
                            )
                          : projects.isEmpty
                          ? const Center(child: Text('No projects found'))
                          : ListView.builder(
                              padding: const EdgeInsets.only(
                                top: 20,
                                bottom: 120,
                              ),
                              itemCount: projects.length,
                              itemBuilder: (context, index) {
                                final item = projects[index];

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 20,
                                  ),
                                  child: ProjectCard(
                                    project: item,
                                  ),
                                );
                              },
                            ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
