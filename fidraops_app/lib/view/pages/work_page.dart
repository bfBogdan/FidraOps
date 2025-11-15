import 'package:fidraops_app/view/widgets/popup_form.dart';
import 'package:fidraops_app/view/widgets/work_card.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class WorkPage extends StatelessWidget {
  const WorkPage({super.key});

  List<Map<String, dynamic>> get works => [
        {
          'title': 'Fix leaking pipe',
          'description': 'Building A',
          'required_assignee_number': 2,
          'users_id': [1, 2],
          'time_estimation_minutes': 120,
          'required_equipment': ['Wrench', 'Pipe tape'],
          'start_timestamp': DateTime.now().subtract(Duration(hours: 1)),
          'status': 0,
        },
        {
          'title': 'Inspect HVAC system',
          'description': 'Building B',
          'required_assignee_number': 1,
          'users_id': [3],
          'time_estimation_minutes': 90,
          'required_equipment': ['Screwdriver'],
          'start_timestamp': DateTime.now().subtract(Duration(hours: 2)),
          'status': 1,
        },
        {
          'title': 'Replace light fixtures',
          'description': 'Building C',
          'required_assignee_number': 1,
          'users_id': [4],
          'time_estimation_minutes': 60,
          'required_equipment': ['Ladder', 'Light bulbs'],
          'start_timestamp': DateTime.now().subtract(Duration(hours: 3)),
          'status': 2,
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
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
              child: ListView.builder(
                padding: EdgeInsets.only(top: 20, bottom: 120),
                itemCount: works.length,
                itemBuilder: (context, index) {
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
                      child: WorkCard(
                        work: works[index],
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