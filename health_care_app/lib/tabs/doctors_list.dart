import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:transparent_image/transparent_image.dart';

import '../models/DoctorModel.dart';
import '../utils/app_constants.dart';
class AllDoctorsWidget extends StatelessWidget {
  const AllDoctorsWidget({required this.doctor, this.color = AppConstants.primaryColor});

  final Doctor doctor; // Change the type to Doctor
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      height: 105,
      margin: EdgeInsets.only(left: 20),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppConstants.primaryColor,
        ),
        color: color.withOpacity(0.25),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            // child: Container(
            //   child: FadeInImage.memoryNetwork(
            //     fit: BoxFit.cover,
            //     width: 80,
            //     height: 80,
            //     placeholder: kTransparentImage,
            //     image: "${AppConstants.IP}/images/${doctor.attachment}",
            //   ),
            // ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctor.doctorName,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  doctor.doctorQualification,
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
