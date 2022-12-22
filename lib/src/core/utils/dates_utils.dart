class DatesUtils {
  DateTime findFirstDateOfTheWeek(DateTime dateTime) {
    return dateTime.subtract(Duration(days: dateTime.weekday - 1));
  }

  DateTime findLastDateOfTheWeek(DateTime dateTime) {
    return dateTime
        .add(Duration(days: DateTime.daysPerWeek - dateTime.weekday));
  }

  DateTime findFirstDateOfTheMonth(DateTime dateTime) {
    return DateTime.utc(dateTime.year, dateTime.month, 1);
  }

  DateTime findLastDateOfTheMonth(DateTime dateTime) {
    return DateTime.utc(
      dateTime.year,
      dateTime.month + 1,
    ).subtract(
      const Duration(days: 1),
    );
  }
}
