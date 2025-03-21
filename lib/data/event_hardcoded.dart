import 'dart:collection';
import 'package:table_calendar/table_calendar.dart';

/*class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}*/

class Event {
  final String title;
  final DateTime startTime;
  final DateTime endTime;
  final String priority;

  Event({
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.priority,
  });

  @override
  String toString() => title;
}

DateTime now = DateTime.now();
final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = {
  for (var item in List.generate(50, (index) => index))
    DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5): List.generate(
      item % 4 + 1,
      //(index) => Event('Event $item | ${index + 1}'),
      (index) => Event(
        title: 'Event $item | ${index + 1}',
        startTime: now.add(Duration(hours: index + 1)),
        endTime: now.add(Duration(hours: index + 2)),
        priority: ['Low', 'Medium', 'High'][index % 3],
    ),
    ),
}..addAll({
  //kToday: [const Event("Today's Event 1"), const Event("Today's Event 2")],
  kToday: [
  Event(
    title: "Today's Event 1",
    startTime: now,
    endTime: now.add(const Duration(hours: 2)),
    priority: 'High',
  ),
  Event(
    title: "Today's Event 2",
    startTime: now.add(const Duration(hours: 3)),
    endTime: now.add(const Duration(hours: 5)),
    priority: 'Medium',
  ),
],

});

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}
