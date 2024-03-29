import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'date_widget.dart';
import 'extra/color.dart';
import 'extra/style.dart';
import 'gestures/tap.dart';

class DatePickerRow extends StatefulWidget {
  /// Start Date in case user wants to show past dates
  /// If not provided calendar will start from the initialSelectedDate
  final DateTime startDate;

  /// Width of the selector
  final double width;

  /// Height of the selector
  final double height;

  /// DatePicker Controller
  final DatePickerController? controller;

  /// Text color for the selected Date
  final Color selectedTextColor;

  /// Text Color for the deactivated dates
  final Color deactivatedColor;

  /// TextStyle for Month Value
  final TextStyle monthTextStyle;

  /// TextStyle for day Value
  final TextStyle dayTextStyle;

  /// TextStyle for the date Value
  final TextStyle dateTextStyle;

  /// Current Selected Date
  final DateTime /*?*/ initialSelectedDate;

  /// Contains the list of inactive dates.
  /// All the dates defined in this List will be deactivated
  final List<DateTime>? inactiveDates;

  /// Contains the list of active dates.
  /// Only the dates in this list will be activated.
  final List<DateTime>? activeDates;

  /// Callback function for when a different date is selected
  final DateChangeListener? onDateChange;

  /// Max limit up to which the dates are shown.
  /// Days are counted from the startDate
  final int daysCount;

  /// Locale for the calendar default: en_us
  final String locale;

  const DatePickerRow(
    this.startDate, {
    super.key,
    required this.initialSelectedDate,
    this.width = 60,
    this.height = 80,
    this.controller,
    this.monthTextStyle = defaultMonthTextStyle,
    this.dayTextStyle = defaultDayTextStyle,
    this.dateTextStyle = defaultDateTextStyle,
    this.selectedTextColor = Colors.white,
    this.deactivatedColor = AppColors.defaultDeactivatedColor,
    this.activeDates,
    this.inactiveDates,
    this.daysCount = 100,
    required this.onDateChange,
    this.locale = "en_US",
  }) : assert(
            activeDates == null || inactiveDates == null,
            "Can't "
            "provide both activated and deactivated dates List at the same time.");

  @override
  State<StatefulWidget> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePickerRow> {
  DateTime? _currentDate;
  DateTime? _startDate;

  final ScrollController _controller = ScrollController();

  late final TextStyle selectedDateStyle;
  late final TextStyle selectedMonthStyle;
  late final TextStyle selectedDayStyle;

  late final TextStyle deactivatedDateStyle;
  late final TextStyle deactivatedMonthStyle;
  late final TextStyle deactivatedDayStyle;

  @override
  void initState() {
    // Init the calendar locale
    initializeDateFormatting(widget.locale, null);

    // Set initial Values
    _currentDate = widget.initialSelectedDate;
    _startDate = widget.startDate;

    if (widget.controller != null) {
      widget.controller!.setDatePickerState(this);
    }

    selectedDateStyle = widget.dateTextStyle.copyWith(
      color: widget.selectedTextColor,
    );
    selectedMonthStyle = widget.monthTextStyle.copyWith(
      color: widget.selectedTextColor,
    );
    selectedDayStyle = widget.dayTextStyle.copyWith(
      color: widget.selectedTextColor,
    );

    deactivatedDateStyle = widget.dateTextStyle.copyWith(
      color: widget.deactivatedColor,
    );
    deactivatedMonthStyle = widget.monthTextStyle.copyWith(
      color: widget.deactivatedColor,
    );
    deactivatedDayStyle = widget.dayTextStyle.copyWith(
      color: widget.deactivatedColor,
    );

    super.initState();

    // scroll to actual date
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToCenter();
    });
  }

  scrollToCenter() {
    final contentSize = _controller.position.viewportDimension +
        _controller.position.maxScrollExtent;
    final index = widget.daysCount / 2;
    final target = contentSize * index / widget.daysCount;
    final width = MediaQuery.of(context).size.width;
    _controller.position.jumpTo(
      target - (width / 2) + (widget.width / 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final today = DateTime(
      now.year,
      now.month,
      now.day,
    );

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _currentDate == null
                    ? '-'
                    : today.compareTo(_currentDate!) == 0
                        ? 'HOY'
                        : DateFormat("E, d MMMM y", 'es_ES')
                            .format(_currentDate!)
                            .toUpperCase(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.calendar_month_outlined),
                onPressed: () async {
                  final newDateTime = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2050),
                  );
                  if (newDateTime != null) {
                    setState(() {
                      _currentDate = newDateTime;
                      _startDate = newDateTime.subtract(
                        Duration(days: widget.daysCount ~/ 2),
                      );
                      widget.onDateChange!(newDateTime);
                      scrollToCenter();
                    });
                  }
                },
              ),
            ],
          ),
        ),
        SizedBox(
          height: widget.height,
          child: ListView.builder(
            itemCount: widget.daysCount,
            scrollDirection: Axis.horizontal,
            controller: _controller,
            itemBuilder: (context, index) {
              // get the date object based on the index position
              // if widget.startDate is null then use the initialDateValue
              DateTime date;
              DateTime dateStart = _startDate!.add(Duration(days: index));
              date = DateTime(dateStart.year, dateStart.month, dateStart.day);

              bool isDeactivated = false;

              // check if this date needs to be deactivated for only DeactivatedDates
              if (widget.inactiveDates != null) {
                for (DateTime inactiveDate in widget.inactiveDates!) {
                  if (_compareDate(date, inactiveDate)) {
                    isDeactivated = true;
                    break;
                  }
                }
              }

              // check if this date needs to be deactivated for only ActivatedDates
              if (widget.activeDates != null) {
                isDeactivated = true;
                for (DateTime activateDate in widget.activeDates!) {
                  // Compare the date if it is in the
                  if (_compareDate(date, activateDate)) {
                    isDeactivated = false;
                    break;
                  }
                }
              }

              // Check if this date is the one that is currently selected
              bool isSelected = _currentDate != null
                  ? _compareDate(date, _currentDate!)
                  : false;

              // Return the Date Widget
              return DateWidget(
                date: date,
                isSelected: isSelected,
                monthTextStyle: isDeactivated
                    ? deactivatedMonthStyle
                    : isSelected
                        ? selectedMonthStyle
                        : widget.monthTextStyle,
                dateTextStyle: isDeactivated
                    ? deactivatedDateStyle
                    : isSelected
                        ? selectedDateStyle
                        : widget.dateTextStyle,
                dayTextStyle: isDeactivated
                    ? deactivatedDayStyle
                    : isSelected
                        ? selectedDayStyle
                        : widget.dayTextStyle,
                width: widget.width,
                locale: widget.locale,
                selectionColor: isSelected
                    ? Theme.of(context).primaryColor
                    : Colors.transparent,
                onDateSelected: (selectedDate) {
                  // Don't notify listener if date is deactivated
                  if (isDeactivated) return;

                  // A date is selected
                  if (widget.onDateChange != null) {
                    setState(() {
                      _currentDate = selectedDate;
                    });
                    widget.onDateChange!(selectedDate);
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }

  /// Helper function to compare two dates
  /// Returns True if both dates are the same
  bool _compareDate(DateTime date1, DateTime date2) {
    return date1.day == date2.day &&
        date1.month == date2.month &&
        date1.year == date2.year;
  }
}

class DatePickerController {
  _DatePickerState? _datePickerState;

  void setDatePickerState(_DatePickerState state) {
    _datePickerState = state;
  }

  void jumpToSelection() {
    assert(_datePickerState != null,
        'DatePickerController is not attached to any DatePicker View.');

    // jump to the current Date
    _datePickerState!._controller
        .jumpTo(_calculateDateOffset(_datePickerState!._currentDate!));
  }

  /// This function will animate the Timeline to the currently selected Date
  void animateToSelection({
    duration = const Duration(milliseconds: 500),
    curve = Curves.linear,
  }) {
    assert(_datePickerState != null,
        'DatePickerController is not attached to any DatePicker View.');

    // animate to the current date
    _datePickerState!._controller.animateTo(
        _calculateDateOffset(_datePickerState!._currentDate!),
        duration: duration,
        curve: curve);
  }

  /// This function will animate to any date that is passed as an argument
  /// In case a date is out of range nothing will happen
  void animateToDate(
    DateTime date, {
    duration = const Duration(milliseconds: 500),
    curve = Curves.linear,
  }) {
    assert(_datePickerState != null,
        'DatePickerController is not attached to any DatePicker View.');

    _datePickerState!._controller.animateTo(_calculateDateOffset(date),
        duration: duration, curve: curve);
  }

  /// This function will animate to any date that is passed as an argument
  /// this will also set that date as the current selected date
  void setDateAndAnimate(
    DateTime date, {
    duration = const Duration(milliseconds: 500),
    curve = Curves.linear,
  }) {
    assert(_datePickerState != null,
        'DatePickerController is not attached to any DatePicker View.');

    _datePickerState!._controller.animateTo(_calculateDateOffset(date),
        duration: duration, curve: curve);

    if (date.compareTo(_datePickerState!._startDate!) >= 0 &&
        date.compareTo(_datePickerState!._startDate!
                .add(Duration(days: _datePickerState!.widget.daysCount))) <=
            0) {
      // date is in the range
      _datePickerState!._currentDate = date;
    }
  }

  /// Calculate the number of pixels that needs to be scrolled to go to the
  /// date provided in the argument
  double _calculateDateOffset(DateTime date) {
    final startDate = DateTime(
      _datePickerState!._startDate!.year,
      _datePickerState!._startDate!.month,
      _datePickerState!._startDate!.day,
    );

    int offset = date.difference(startDate).inDays;
    return (offset * _datePickerState!.widget.width) + (offset * 6);
  }
}
