import 'package:fidraops_app/data/models/sop.dart';
import 'package:fidraops_app/data/models/user.dart'; // <-- adjust path if needed
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

import 'package:fidraops_app/providers/sop.dart';
import 'package:fidraops_app/data/repositories/http_service.dart';
import 'package:fidraops_app/providers/app_state.dart';

class CreateWorkPage extends StatelessWidget {
  const CreateWorkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SOPProvider()
        ..fetchAllSOPs(
          context.read<HttpService>(),
          context.read<AppState>(),
        ),
      child: Builder(
        builder: (context) => const _CreateWorkPageContent(),
      ),
    );
  }
}

class _CreateWorkPageContent extends StatefulWidget {
  const _CreateWorkPageContent({super.key});

  @override
  State<_CreateWorkPageContent> createState() => _CreateWorkPageContentState();
}

class _CreateWorkPageContentState extends State<_CreateWorkPageContent> {
  int _currentStep = 0;

  // Step 1
  final TextEditingController workNameController = TextEditingController();

  // Step 2
  List<SOP> selectedSOPs = [];
  // SOP -> assigned users
  final Map<SOP, List<User>> _assignedUsers = {};

  // Step 3
  List<TextEditingController> taskControllers = [
    TextEditingController(),
  ];

  int get totalEstimatedTime {
    return selectedSOPs.fold(0, (sum, sop) => sum + sop.estimatedCompletionTime);
  }

  int get totalEmployees {
    return selectedSOPs.fold(0, (sum, sop) => sum + sop.requiredAssigneeNumber);
  }

  @override
  Widget build(BuildContext context) {
    final sopProvider = context.watch<SOPProvider>();
    final availableSOPs = sopProvider.sops;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ------- TOP HEADER BAR -------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // BACK BUTTON (dynamic)
                GestureDetector(
                  onTap: () {
                    if (_currentStep == 0) {
                      Navigator.pop(context); // leave the page
                    } else {
                      setState(() => _currentStep--); // go back inside stepper
                    }
                  },
                  child: Container(
                    padding: _currentStep == 0
                        ? EdgeInsets.zero
                        : const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                    width: _currentStep == 0 ? 40 : null,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(
                        _currentStep == 0 ? 40 : 23,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x29000000),
                          offset: Offset(0, 2),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          LucideIcons.arrowLeft,
                          size: 28,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        if (_currentStep > 0) ...[
                          const SizedBox(width: 8),
                          Text(
                            "Go back",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),

                // RIGHT BUTTON: CONTINUE / SAVE
                GestureDetector(
                  onTap: () {
                    if (_currentStep < 2) {
                      setState(() => _currentStep++);
                    } else {
                      _submit();
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 15,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.lightGreen,
                      borderRadius: BorderRadius.circular(23),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x29000000),
                          offset: Offset(0, 2),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          _currentStep < 2
                              ? LucideIcons.arrowRight
                              : LucideIcons.check,
                          size: 28,
                          color: Theme.of(context).colorScheme.surface,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          _currentStep < 2 ? "Continue" : "Save",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ------- MAIN CARD -------
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(
                    minHeight: 0,
                  ),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(23),
                    color: Theme.of(context).colorScheme.surface,
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x29000000),
                        offset: Offset(0, 1),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: sopProvider.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Theme(
                          data: Theme.of(context).copyWith(
                            dividerColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                          ),
                          child: Stepper(
                            margin: EdgeInsets.zero,
                            elevation: 0,
                            currentStep: _currentStep,
                            onStepContinue: () {
                              if (_currentStep < 2) {
                                setState(() => _currentStep++);
                              } else {
                                _submit();
                              }
                            },
                            onStepCancel: () {
                              if (_currentStep > 0) {
                                setState(() => _currentStep--);
                              } else {
                                Navigator.pop(context);
                              }
                            },
                            controlsBuilder: (context, details) {
                              return const SizedBox.shrink(); // we use top button
                            },
                            steps: [
                              // STEP 1 - NAME
                              Step(
                                title: const Text("Work name"),
                                isActive: _currentStep >= 0,
                                content: TextField(
                                  controller: workNameController,
                                  decoration: const InputDecoration(
                                    labelText: "Enter work name",
                                  ),
                                ),
                              ),

                              // STEP 2 - SOPS + EMPLOYEES
                              Step(
                                title: const Text("Choose SOPs"),
                                isActive: _currentStep >= 1,
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Dropdown
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color(0x29000000),
                                            offset: Offset(0, 1),
                                            blurRadius: 6,
                                          ),
                                        ],
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<SOP>(
                                          hint:
                                              const Text("Select SOP to assign"),
                                          isExpanded: true,
                                          icon: const Icon(
                                              Icons.arrow_drop_down),

                                          items: availableSOPs.map((sop) {
                                            return DropdownMenuItem<SOP>(
                                              value: sop,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(sop.title),
                                                  Row(
                                                    children: [
                                                      // TIME
                                                      Text(
                                                        "${sop.estimatedCompletionTime} min",
                                                        style: TextStyle(
                                                          color:
                                                              Colors.grey[700],
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          width: 10),

                                                      // EMPLOYEES
                                                      Row(
                                                        children: [
                                                          const Icon(
                                                            LucideIcons.users,
                                                            size: 16,
                                                            color: Colors
                                                                .black54,
                                                          ),
                                                          const SizedBox(
                                                              width: 3),
                                                          Text(
                                                            sop.requiredAssigneeNumber
                                                                .toString(),
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .grey[700],
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          }).toList(),

                                          onChanged: (sop) async {
                                            if (sop == null) return;

                                            // Add sop to list if not present
                                            if (!selectedSOPs.contains(sop)) {
                                              setState(() {
                                                selectedSOPs.add(sop);
                                              });
                                            }

                                            // Open user selection modal
                                            final users =
                                                await _showSelectUsersModal(
                                              context,
                                              sop,
                                            );

                                            // If user cancelled → remove sop
                                            if (users == null) {
                                              setState(() {
                                                selectedSOPs.remove(sop);
                                                _assignedUsers.remove(sop);
                                              });
                                              return;
                                            }

                                            // Save assigned users
                                            setState(() {
                                              _assignedUsers[sop] = users;
                                            });
                                          },
                                        ),
                                      ),
                                    ),

                                    const SizedBox(height: 15),

                                    // Chips
                                    Wrap(
                                      spacing: 10,
                                      runSpacing: 10,
                                      children: selectedSOPs.map((sop) {
                                        final assigned =
                                            _assignedUsers[sop] ?? [];

                                        return Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 8,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.lightGreen
                                                .withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                              color: Colors.lightGreen,
                                              width: 1.4,
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    "${sop.title} (${sop.estimatedCompletionTime}m, ${sop.requiredAssigneeNumber} emp.)",
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        selectedSOPs
                                                            .remove(sop);
                                                        _assignedUsers
                                                            .remove(sop);
                                                      });
                                                    },
                                                    child: const Icon(
                                                      LucideIcons.x,
                                                      size: 18,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              if (assigned.isNotEmpty) ...[
                                                const SizedBox(height: 6),
                                                Text(
                                                  "Assigned: ${assigned.map((u) => u.name).join(', ')}",
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                              ],
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    ),

                                    const SizedBox(height: 20),

                                    // TOTALS
                                    Text(
                                      "Total estimated time: $totalEstimatedTime min",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[800],
                                      ),
                                    ),

                                    const SizedBox(height: 8),

                                    Text(
                                      "Total employees needed: $totalEmployees",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // STEP 3 - TASKS
                              Step(
                                title: const Text("Tasks"),
                                isActive: _currentStep >= 2,
                                content: Column(
                                  children: [
                                    ...List.generate(taskControllers.length,
                                        (i) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 12),
                                        child: TextField(
                                          controller: taskControllers[i],
                                          decoration: InputDecoration(
                                            labelText: "Task ${i + 1}",
                                            suffixIcon: i == 0
                                                ? null
                                                : IconButton(
                                                    icon: const Icon(
                                                        LucideIcons.trash),
                                                    onPressed: () {
                                                      setState(() {
                                                        taskControllers
                                                            .removeAt(i);
                                                      });
                                                    },
                                                  ),
                                          ),
                                        ),
                                      );
                                    }),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          taskControllers
                                              .add(TextEditingController());
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 12,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.lightGreen,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Color(0x29000000),
                                              offset: Offset(0, 2),
                                              blurRadius: 8,
                                            ),
                                          ],
                                        ),
                                        child: const Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(LucideIcons.plus,
                                                color: Colors.white),
                                            SizedBox(width: 8),
                                            Text(
                                              "Add task",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submit() {
    final name = workNameController.text.trim();
    final tasks = taskControllers.map((c) => c.text.trim()).toList();

    print("SUBMIT WORK:");
    print("Name: $name");
    print("SOPs: ${selectedSOPs.map((e) => e.title)}");
    print("Assignments:");
    for (final sop in selectedSOPs) {
      final users = _assignedUsers[sop] ?? [];
      print(" - ${sop.title}: ${users.map((u) => u.name).join(', ')}");
    }
    print("Tasks: $tasks");

    Navigator.pop(context);
  }

  // ===== EMPLOYEE SELECTION MODAL =====

  Future<List<User>?> _showSelectUsersModal(
    BuildContext context,
    SOP sop,
  ) async {
    final requiredCount = sop.requiredAssigneeNumber;
    List<User> selected = [];

    final employees = await _fetchUsers(); // TODO: connect to your real source

    return showDialog<List<User>>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text("Assign employees for ${sop.title}"),
          content: SizedBox(
            width: double.maxFinite,
            height: 400,
            child: StatefulBuilder(
              builder: (context, setModalState) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: employees.length,
                        itemBuilder: (context, index) {
                          final user = employees[index];
                          final isSelected = selected.contains(user);

                          return CheckboxListTile(
                            title: Text(user.name),
                            subtitle: Text(user.email),
                            value: isSelected,
                            onChanged: (checked) {
                              setModalState(() {
                                if (checked == true &&
                                    selected.length < requiredCount) {
                                  selected.add(user);
                                } else {
                                  selected.remove(user);
                                }
                              });
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "${selected.length} / $requiredCount selected",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, null),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: selected.length == requiredCount
                  ? () => Navigator.pop(ctx, selected)
                  : null,
              child: const Text("Confirm"),
            ),
          ],
        );
      },
    );
  }
}

