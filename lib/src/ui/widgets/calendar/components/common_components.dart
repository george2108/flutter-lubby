// Copyright (c) 2021 Simform Solutions. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../style/header_style.dart';
import '../typedefs.dart';

class CalendarPageHeader extends StatelessWidget {
  /// When user taps on right arrow.
  final VoidCallback? onNextDay;

  /// When user taps on left arrow.
  final VoidCallback? onPreviousDay;

  /// When user taps on title.
  final AsyncCallback? onTitleTapped;

  /// Date of month/day.
  final DateTime date;

  /// Secondary date. This date will be used when we need to define a
  /// range of dates.
  /// [date] can be starting date and [secondaryDate] can be end date.
  final DateTime? secondaryDate;

  /// Provides string to display as title.
  final StringProvider dateStringBuilder;

  /// Style for Calendar's header
  final HeaderStyle headerStyle;

  /// Common header for month and day view In this header user can define format
  /// in which date will be displayed by providing [dateStringBuilder] function.
  const CalendarPageHeader({
    super.key,
    required this.date,
    required this.dateStringBuilder,
    this.onNextDay,
    this.onTitleTapped,
    this.onPreviousDay,
    this.secondaryDate,
    this.headerStyle = const HeaderStyle(),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: headerStyle.headerMargin,
      padding: headerStyle.headerPadding,
      decoration:
          // ignore_for_file: deprecated_member_use_from_same_package
          headerStyle.decoration ??
              BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (headerStyle.leftIconVisible)
            IconButton(
              onPressed: onPreviousDay,
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              padding: headerStyle.leftIconPadding,
              icon: headerStyle.leftIcon ??
                  const Icon(
                    Icons.chevron_left,
                    size: 30,
                  ),
            ),
          Expanded(
            child: InkWell(
              onTap: onTitleTapped,
              child: Text(
                dateStringBuilder(date, secondaryDate: secondaryDate),
                textAlign: headerStyle.titleAlign,
                style: headerStyle.headerTextStyle,
              ),
            ),
          ),
          if (headerStyle.rightIconVisible)
            IconButton(
              onPressed: onNextDay,
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              padding: headerStyle.rightIconPadding,
              icon: headerStyle.rightIcon ??
                  const Icon(
                    Icons.chevron_right,
                    size: 30,
                  ),
            ),
        ],
      ),
    );
  }
}
