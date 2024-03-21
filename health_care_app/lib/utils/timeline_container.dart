import 'package:flutter/material.dart';

class TimelineContainer extends StatefulWidget {
  const TimelineContainer({super.key});

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
          color: Colors.deepPurple.shade400
        ),
        child: Column(
          children: [
            Text("Doctor Name here ", style: TextStyle(fontSize: 22, color: Colors.white),)
          ],
        ),
      ),
    );
  }
}