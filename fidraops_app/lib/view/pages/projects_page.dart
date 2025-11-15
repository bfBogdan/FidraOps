import 'package:fidraops_app/data/models/project.dart';
import 'package:fidraops_app/data/repositories/project.dart';
import 'package:fidraops_app/providers/project.dart';
import 'package:fidraops_app/data/repositories/http_service.dart';
import 'package:fidraops_app/providers/app_state.dart';
import 'package:fidraops_app/view/widgets/popup_form.dart';
import 'package:fidraops_app/view/widgets/project_card.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProjectProvider(
        httpService: context.read<HttpService>(),
        appState: context.read<AppState>(),
      )..fetchProjects(),
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Projects',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => showCreateProjectForm(context),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 15,
                            ),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.lightGreen,
                              borderRadius: BorderRadius.circular(23),
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
                    child: RefreshIndicator(
                      onRefresh: () => projectProvider.fetchProjects(),
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
                                  child: ProjectCard(project: item),
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

  // In lib/view/pages/projects_page.dart

  void showCreateProjectForm(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    final projectProvider = context.read<ProjectProvider>();
    final httpService = context.read<HttpService>();
    final appState = context.read<AppState>();

    showDialog(
      context: context,
      builder: (_) => PopupForm(
        title: "Create Project",
        fields: [
          TextField(
            decoration: InputDecoration(
              labelText: "Project Title",
            ), // Changed label
            controller: titleController,
          ),
          SizedBox(height: 12),
          TextField(
            decoration: InputDecoration(labelText: "Description"),
            controller: descriptionController,
            minLines: 3,
            maxLines: 5,
          ),
        ],
        onSubmit: () async {
          Project project = Project(
            id: 0,
            title: titleController.text,
            description: descriptionController.text,
            organisationId: appState.currentUser!.organizationId,
          );

          await projectProvider.createProject(project);
        },
      ),
    );
  }
}
