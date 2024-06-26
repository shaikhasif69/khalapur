import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import 'app_constants.dart';

class TopRatedDoctors extends StatefulWidget {
  final String eventName;
  final String eventSubTitle;
  final String eventImage;
  final String eventStartDate;

  TopRatedDoctors({
    required this.eventName,
    required this.eventSubTitle,
    required this.eventImage,
    required this.eventStartDate,
  });

  @override
  State<TopRatedDoctors> createState() => _TopRatedDoctorsState();
}

class _TopRatedDoctorsState extends State<TopRatedDoctors> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        decoration: BoxDecoration(
            color: AppConstants.lightPurple,
            border: Border.all(color: AppConstants.lightPurple),
            borderRadius: BorderRadius.circular(12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 110,
                    padding: EdgeInsets.all(14),
                    height: 120,
                    child: FadeInImage.memoryNetwork(
                      fit: BoxFit.cover,
                      width: 60,
                      height: 60,
                      placeholder: kTransparentImage,
                      image: "${AppConstants.IP}/images/${widget.eventImage}",
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.eventName,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                    Container(
                      width: 180,
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        widget.eventSubTitle,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(child: Text(widget.eventStartDate.toString())),
            ),
          ],
        ),
      ),
    );
  }
}
