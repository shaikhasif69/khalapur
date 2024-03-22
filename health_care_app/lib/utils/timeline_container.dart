import 'package:flutter/material.dart';

class TimelineContainer extends StatefulWidget {
  final name;
  const TimelineContainer({super.key, required this.name});

  @override
  State<TimelineContainer> createState() => _TimelineContainerState();
}

class _TimelineContainerState extends State<TimelineContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 40),
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.deepPurple.shade400),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.name,
              style: TextStyle(fontSize: 15, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
