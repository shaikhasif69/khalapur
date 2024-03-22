import 'package:flutter/material.dart';
import 'package:health_care_app/pages/AllAppoinments.dart';
import 'package:health_care_app/utils/app_constants.dart';
import 'package:health_care_app/utils/my_timeline_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          "Good Morning!",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Icon(
                          Icons.notification_add,
                          size: 35,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 120,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: const Column(
                        children: [
                          Text(
                            "Tip for the day: ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white),
                      height: MediaQuery.of(context).size.height / 2.5,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: AppConstants.myOrange,
                                      borderRadius: BorderRadius.circular(25)),
                                  height: 150,
                                  width: 200,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              "Steps ",
                                              style: TextStyle(fontSize: 25),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Icon(
                                              Icons.run_circle_rounded,
                                              size: 70,
                                            )
                                          ],
                                        ),
                                      ),
                                      Center(
                                          child: Text(
                                        "8,696",
                                        style: TextStyle(fontSize: 32),
                                      ))
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 70,
                                  width: 180,
                                  decoration: BoxDecoration(
                                      color: AppConstants.lightPurple,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Calories burned ",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        "2,069",
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Text(
                            "Shaikh Asif!",
                            style: TextStyle(
                                fontSize: 26, fontWeight: FontWeight.w500),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 90,
                                  width: 220,
                                  decoration: BoxDecoration(
                                    color: AppConstants.sleepColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Row(
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Icon(
                                        Icons.bed,
                                        size: 60,
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        "6",
                                        style: TextStyle(
                                            fontSize: 28,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        "h",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Text(
                                        "20",
                                        style: TextStyle(
                                            fontSize: 28,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text("m")
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white),
                      // height: MediaQuery.of(context).size.height / 2.5,
                      width: MediaQuery.of(context).size.width,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        MedicalHistoryPage()));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white),
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          child: Center(
                                              child: Text(
                                        "Medical History",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ))),
                                      InkWell(child: Text("see all")),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 12.0),
                                          child:
                                              Icon(Icons.view_agenda_outlined),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
