DateTime getDateTimeUTC({DateTime? dateTime}) {
  final now = dateTime ?? DateTime.now();

  return DateTime.utc(
    now.year,
    now.month,
    now.day,
    now.hour,
    now.minute,
    now.second,
    now.millisecond,
    now.microsecond,
  );
}
