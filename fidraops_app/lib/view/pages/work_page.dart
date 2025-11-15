import 'package:fidraops_app/view/widgets/popup_form.dart';
import 'package:fidraops_app/data/repositories/http_service.dart';
import 'package:fidraops_app/providers/app_state.dart';
import 'package:fidraops_app/providers/work.dart';
import 'package:fidraops_app/view/widgets/work_card.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

class WorkPage extends StatelessWidget {
  const WorkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WorkProvider()
        ..fetchActiveSOPs(
          context.read<HttpService>(),
          context.read<AppState>(),
        ),
      child: Builder(
        builder: (context) {
          final workProvider = context.watch<WorkProvider>();
          final works = workProvider.works;

          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.only(top: 80),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Scheduled work',
                          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                        ),
                        GestureDetector(
                          onTap: () => showCreateWorkForm(context),
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
                    child: RefreshIndicator(
                      onRefresh: () => workProvider.fetchActiveSOPs(
                        context.read<HttpService>(),
                        context.read<AppState>(),
                      ),
                      child: workProvider.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : workProvider.error != null
                          ? Center(child: Text('Error: ${workProvider.error}'))
                          : works.isEmpty
                          ? const Center(child: Text('No work items found'))
                          : ListView.builder(
                              padding: EdgeInsets.only(top: 20, bottom: 120),
                              itemCount: works.length,
                              itemBuilder: (context, index) {
                                final work = works[index];

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 20,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      // Navigator.of(context).push(
                                      //   MaterialPageRoute(builder: (_) => ProjectPage(project: projects[index])),
                                      // );
                                    },
                                    child: WorkCard(work: work),
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

  void showCreateWorkForm(BuildContext context) {
    final nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => PopupForm(
        title: "Schedule work",
        fields: [
          TextField(decoration: InputDecoration(labelText: "Item Name"), controller: nameController),
          SizedBox(height: 12),
        ],
        onSubmit: () {
          print("Item: ${nameController.text}");
        },
        formType: PopupFormType.edit,
      ),
    );
  }
}
