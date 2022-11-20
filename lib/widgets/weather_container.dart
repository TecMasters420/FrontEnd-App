import 'package:flutter/material.dart';
import 'package:schedulemanager/constants/constants.dart';
import 'package:schedulemanager/utils/responsive_util.dart';
import 'package:schedulemanager/utils/text_styles.dart';

class WeatherContainer extends StatelessWidget {
  const WeatherContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    return Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          color: lightGrey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              '28° C',
              style: TextStyles.w600(resp.dp(5)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Opacity(
                opacity: 0.15,
                child: Image.asset(
                  'assets/images/weather.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ));
  }
}