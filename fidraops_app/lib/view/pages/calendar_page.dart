import 'package:fidraops_app/data/models/work.dart';
import 'package:fidraops_app/data/repositories/http_service.dart';
import 'package:fidraops_app/providers/app_state.dart';
import 'package:fidraops_app/providers/work.dart';
import 'package:fidraops_app/view/widgets/work_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WorkProvider()
        ..fetchActiveSOPs(
          context.read<HttpService>(),
          context.read<AppState>(),
        ),
      child: const _CalendarPageBody(),
    );
  }
}

class _CalendarPageBody extends StatefulWidget {
  const _CalendarPageBody();

  @override
  State<_CalendarPageBody> createState() => _CalendarPageBodyState();
}

class _CalendarPageBodyState extends State<_CalendarPageBody> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  /// Returns a list of `Work` items that start on the selected day.
  List<Work> _getWorksForDay(DateTime day, List<Work> works) {
    return works.where((w) {
      return w.startTimeStamp.year == day.year &&
          w.startTimeStamp.month == day.month &&
          w.startTimeStamp.day == day.day;
    }).toList();
  }

  String _formatDate(DateTime date) {
    const months = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];

    return "${date.day} ${months[date.month]} ${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    final workProvider = context.watch<WorkProvider>();
    final works = workProvider.works;

    final tasks =
        _selectedDay == null ? [] : _getWorksForDay(_selectedDay!, works);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Calendar
            TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2100, 12, 31),
              focusedDay: _focusedDay,
              startingDayOfWeek: StartingDayOfWeek.monday,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              availableCalendarFormats: const {
                CalendarFormat.month: 'Month',
              },
              onDaySelected: (selected, focused) {
                setState(() {
                  _selectedDay = selected;
                  _focusedDay = focused;
                });
              },
              eventLoader: (day) {
                return _getWorksForDay(day, works);
              },
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withAlpha(100),
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Title
            Text(
              _selectedDay == null
                  ? "Select a day"
                  : "Work on ${_formatDate(_selectedDay!)}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 12),

            // LOADING
            if (workProvider.isLoading)
              const Center(child: CircularProgressIndicator()),

            // ERROR
            if (workProvider.error != null)
              Center(
                child: Text(
                  "Error: ${workProvider.error}",
                  style: const TextStyle(color: Colors.red),
                ),
              )

            // NO SELECTION
            else if (_selectedDay == null)
              const SizedBox()

            // NO WORKS FOR SELECTED DAY
            else if (tasks.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    "No scheduled work for this day.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              )

            // WORK LIST
            else
              Column(
                children: List.generate(tasks.length, (index) {
                  final work = tasks[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: WorkCard(work: work),
                  );
                }),
              ),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
