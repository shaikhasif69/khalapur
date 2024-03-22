import "package:flutter/material.dart";
import 'package:health_care_app/utils/app_constants.dart';
import 'package:health_care_app/utils/timeline_container.dart';
import 'package:timeline_tile/timeline_tile.dart';

class MyTimelineTile extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool isPast;
  final name;
  const MyTimelineTile(
      {super.key,
      required this.isFirst,
      required this.isLast,
      required this.name,
      required this.isPast});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: TimelineTile(
        isFirst: isFirst,
        isLast: isLast,
        beforeLineStyle: LineStyle(
            color: isPast
                ? AppConstants.primaryColor
                : Colors.deepPurple.shade300),
        indicatorStyle: IndicatorStyle(
            width: 40,
            color: Colors.deepPurple.shade500,
            iconStyle: IconStyle(
                iconData: Icons.done,
                color: isPast ? Colors.white : Colors.deepPurple.shade100)),
        endChild: TimelineContainer(
          name: name,
        ),
      ),
    );
  }
}
