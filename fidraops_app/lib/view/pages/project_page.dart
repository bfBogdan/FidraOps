import 'package:fidraops_app/data/models/project.dart';
import 'package:fidraops_app/data/repositories/http_service.dart';
import 'package:fidraops_app/data/repositories/project.dart';
import 'package:fidraops_app/providers/app_state.dart';
import 'package:fidraops_app/providers/project.dart';
import 'package:fidraops_app/providers/sop.dart';
import 'package:fidraops_app/view/widgets/popup_form.dart';
import 'package:fidraops_app/view/widgets/sop_card.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

class ProjectPage extends StatelessWidget {
  final Project project;

  const ProjectPage({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SOPProvider()
        ..fetchSOPs(
          context.read<HttpService>(),
          context.read<AppState>(),
          project.id,
        ),
      child: Builder(
        builder: (context) {
          final sopProvider = context.watch<SOPProvider>();
          final sops = sopProvider.sops;

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
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
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
                              LucideIcons.arrowLeft,
                              size: 32,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => showCreateSOPForm(context),
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      LucideIcons.plus,
                                      size: 32,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.surface,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      'Add SOP',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.surface,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 15),
                            GestureDetector(
                              onTap: () => _showProjectMenu(context),
                              child: Container(
                                width: 40,
                                height: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
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
                                  Icons.more_vert_rounded,
                                  size: 32,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(23),
                          color: Theme.of(context).colorScheme.surface,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x29000000),
                              offset: Offset(0, 1),
                              blurRadius: 8,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              project.title,
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              project.description ?? 'No description provided.',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[700],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'Standard Operating Procedures (SOPs)',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () => sopProvider.fetchSOPs(
                        context.read<HttpService>(),
                        context.read<AppState>(),
                        project.id,
                      ),
                      child: sopProvider.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : sopProvider.error != null
                          ? Center(child: Text('Error: ${sopProvider.error}'))
                          : sops.isEmpty
                          ? const Center(child: Text('No SOPs found'))
                          : ListView.builder(
                              padding: EdgeInsets.only(top: 5, bottom: 120),
                              itemCount: sops.length,
                              itemBuilder: (context, index) {
                                final item = sops[index];

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 20,
                                  ),
                                  child: SOPCard(sop: item.toJson()),
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

  void showCreateSOPForm(BuildContext context) {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => PopupForm(
        title: "Create SOP",
        fields: [
          TextField(
            decoration: InputDecoration(labelText: "SOP Name"),
            controller: nameController,
          ),
          SizedBox(height: 12),
          TextField(
            decoration: InputDecoration(labelText: "Description"),
            controller: descriptionController,
            minLines: 3,
            maxLines: 5,
          ),
        ],
        onSubmit: () {
          print("SOP: ${nameController.text}");
          print("Description: ${descriptionController.text}");
        },
      ),
    );
  }

  void _showProjectMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(23)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              Container(
                width: 40,
                height: 5,
                margin: const EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              // Edit
              ListTile(
                leading: Icon(
                  Icons.edit_rounded,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: const Text("Edit project"),
                onTap: () {
                  Navigator.pop(context);
                  showEditProjectForm(context, project);
                },
              ),

              // Delete
              ListTile(
                leading: Icon(
                  Icons.delete_rounded,
                  color: Theme.of(context).colorScheme.error,
                ),
                title: Text(
                  "Delete",
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
                onTap: () {
                  showDeleteProjectForm(context, project);
                },
              ),

              const SizedBox(height: 100),
            ],
          ),
        );
      },
    );
  }

  void showEditProjectForm(BuildContext context, Project project) {
    final nameController = TextEditingController(text: project.title);
    final descriptionController = TextEditingController(
      text: project.description,
    );

    showDialog(
      context: context,
      builder: (_) => PopupForm(
        title: "Edit Project",
        fields: [
          TextField(
            decoration: InputDecoration(labelText: "Project Name"),
            controller: nameController,
          ),
          SizedBox(height: 12),
          TextField(
            decoration: InputDecoration(labelText: "Description"),
            controller: descriptionController,
            minLines: 3,
            maxLines: 5,
          ),
        ],
        onSubmit: () {
          print("Project: ${nameController.text}");
          print("Description: ${descriptionController.text}");
        },
        formType: PopupFormType.edit,
      ),
    );
  }

  void showDeleteProjectForm(BuildContext context, Project project) {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();

    final projectRepository = ProjectRepository();

    showDialog(
      context: context,
      builder: (_) => PopupForm(
        title: "Delete Project",
        fields: [],
        onSubmit: () async {
          print("Project: ${nameController.text}");
          print("Description: ${descriptionController.text}");

          await projectRepository.deleteProject(
            context.read<HttpService>(),
            context.read<AppState>(),
            project.id,
          );

          Navigator.pop(context);
          Navigator.pop(context);
        },
        formType: PopupFormType.delete,
      ),
    );
  }
}
