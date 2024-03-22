import 'package:flutter/material.dart';
import 'package:health_care_app/services/doctors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import '../models/DoctorModel.dart';
// import '../tabs/doctors_list.dart';
import '../tabs/search_bar_widget.dart';
import '../utils/app_constants.dart';
import '../utils/top_rated_doctors.dart';
import 'doctorProfile.dart';

class DoctorDisplayScreen extends StatefulWidget {
  const DoctorDisplayScreen({super.key});

  @override
  State<DoctorDisplayScreen> createState() => _DoctorDisplayScreenState();
}

class _DoctorDisplayScreenState extends State<DoctorDisplayScreen> {
  Future<List<Doctor>> allDoctors = Doctors.getAllDoctors(); // Corrected type
  Future<dynamic> topRatedDoctors = Doctors.getTopRatedDoctors();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey[100],
      body: ListView(
        children: [
          SingleChildScrollView(
              child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              padded(SearchBarWidget()),
              padded(
                Row(
                  children: [
                    const Text(
                      "All Doctors",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        // Get.toNamed("/getAllCampaigns");
                      },
                      child: const Text(
                        "See All",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 247, 110, 110),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  print("helo world!");
                },
                child: SizedBox(
                  height: 300,
                  child: FutureBuilder<List<Doctor>>(
                    future: allDoctors,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('Data has errors'),
                        );
                      } else if (snapshot.hasData) {
                        List<Doctor> doctorList = snapshot.data!;
                        return ScrollSnapList(
                          itemBuilder: (context, index) =>
                              _buildDoctorItem(context, index, doctorList),
                          itemCount: doctorList.length,
                          itemSize: 200,
                          onItemFocus: (index) {},
                          dynamicItemSize: true,
                        );
                      } else {
                        return Center(
                          child: Text('No data available'),
                        );
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              // padded(
              //   Container(
              //     height: MediaQuery.of(context).size.height / 2.4,
              //     width: MediaQuery.of(context).size.width,
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(20),
              //         color: Colors.white),
              //     child: GridView(
              //       physics: NeverScrollableScrollPhysics(),
              //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //           crossAxisCount: 2,
              //           mainAxisSpacing: 3,
              //           mainAxisExtent: 190,
              //           crossAxisSpacing: 0),
              //       children: [
              //         RollCard(
              //           fieldName: "Cardiology",
              //         ),
              //         RollCard(
              //           fieldName: "Neurology",
              //         ),
              //         RollCard(
              //           fieldName: "Physiology",
              //         ),
              //         RollCard(fieldName: "Phychology",)
              //       ],
              //     ),
              //   ),
              // ),
              padded(
                Row(
                  children: [
                    const Text(
                      "Top Rated Doctors",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        // Get.toNamed("/getAllCampaigns");
                      },
                      child: const Text(
                        "See All",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 247, 110, 110),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              padded(
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: FutureBuilder(
                        future: topRatedDoctors,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasData) {
                            final posts = snapshot.data!;

                            if (snapshot.data.length <= 0) {
                              return const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "No data found",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              );
                            }

                            return ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return TopRatedDoctors(
                                  eventName: snapshot.data[index]["doctorName"],
                                  eventSubTitle: snapshot.data[index]
                                      ["doctorSpecialization"],
                                  eventImage: snapshot.data[index]
                                      ["doctorQualification"],
                                  eventStartDate: snapshot.data[index]
                                      ["doctorQualification"],
                                );
                              },
                            );
                          } else {
                            return const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Text("No data found")],
                            );
                          }
                        },
                      )),
                ),
              ),
            ],
          ))
        ],
      ),
    ));
  }

  Widget _buildDoctorItem(
    BuildContext context,
    int index,
    List<Doctor> doctorList,
  ) {
    Doctor doctor = doctorList[index];

    List<String> assetPaths = [
      'assets/doc1.png',
      'assets/doc2.png',
      'assets/doc3.png',
      'assets/doc4.png',
      'assets/doc5.png',
    ];

    String imagePath = assetPaths[index % assetPaths.length];

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DoctorProfile(
              doctor: doctorList[index],
              imagePath: imagePath,
            ),
          ),
        );
      },
      child: SizedBox(
        width: 170,
        child: Card(
          elevation: 12,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  width: 150,
                  height: 160,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  doctor.doctorName,
                  style: const TextStyle(fontSize: 15),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    doctor.doctorQualification,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  '${doctor.doctorSpecialization}',
                  style: const TextStyle(color: Colors.deepPurple),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RollCard extends StatefulWidget {
  final String fieldName;
  const RollCard({super.key, required this.fieldName});

  @override
  State<RollCard> createState() => _RollCardState();
}

class _RollCardState extends State<RollCard> {
  List imagesPath = [
    "assets/heart.png",
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: () {},
        child: Card(
          color: Colors.deepPurpleAccent[300],
          child: Column(
            children: [Text(widget.fieldName)],
          ),
        ),
      ),
    );
  }
}

Widget padded(Widget widget) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20),
    child: widget,
  );
}
