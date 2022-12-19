import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../app/config/constants.dart';
import '../../../data/models/reminder_model.dart';
import '../../../app/utils/responsive_util.dart';

import '../../../widgets/reminder_container.dart';
import '../../../widgets/reminder_information.dart';
import 'reminder_hour.dart';

class RemindersListPerDay extends StatelessWidget {
  final void Function(ReminderModel reminder) onLongPressCallback;
  final List<ReminderModel> reminders;
  const RemindersListPerDay({
    super.key,
    required this.reminders,
    required this.onLongPressCallback,
  });

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);

    return Column(
      children: List.generate(
        reminders.length,
        (x) {
          final ReminderModel remider = reminders[x];
          final String startDate =
              DateFormat('MM-dd').format(remider.startDate!);
          final String endDate = DateFormat('MM-dd').format(remider.endDate!);

          final Color color = colors[Random().nextInt(colors.length - 1)];

          return InkWell(
            onLongPress: () => onLongPressCallback(remider),
            borderRadius: BorderRadius.circular(10),
            splashColor: color.withOpacity(0.25),
            highlightColor: lightGrey.withOpacity(0.05),
            child: ReminderContainer(
              color: color,
              leftWidget: ReminderHour(
                dates: [startDate, endDate],
                fontSize: resp.sp14,
              ),
              rightWidget: ReminderInformation(
                reminder: remider,
              ),
            ),
          );
        },
      ),
    );
  }
}