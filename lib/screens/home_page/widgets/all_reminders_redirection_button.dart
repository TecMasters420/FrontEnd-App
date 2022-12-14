import 'package:flutter/material.dart';
import 'package:schedulemanager/utils/responsive_util.dart';

import '../../../constants/constants.dart';
import '../../../utils/text_styles.dart';

class AllRemindersRedirectionButton extends StatelessWidget {
  const AllRemindersRedirectionButton({super.key});

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, 'remindersPage'),
      child: Container(
        height: resp.hp(10),
        width: double.infinity,
        decoration: BoxDecoration(
          color: lightGrey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Press to see all reminders',
              textAlign: TextAlign.center,
              style: TextStyles.w600(
                resp.sp16,
                grey.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
