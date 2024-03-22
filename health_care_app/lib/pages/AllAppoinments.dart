import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health_care_app/models/medical.dart';
import 'package:health_care_app/notifiers/getAllAppoinmentNotifier.dart';
import 'package:health_care_app/services/doctors.dart';
import 'package:health_care_app/utils/app_constants.dart';
import 'package:health_care_app/utils/my_timeline_tile.dart';
import 'package:health_care_app/utils/timeline_container.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'dart:developer' as developer;

class MedicalHistoryPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _MedicalHistoryPage();
    // TODO: implement createState
    throw UnimplementedError();
  }
}

class _MedicalHistoryPage extends ConsumerState<MedicalHistoryPage> {
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(MedicalReportNotifier.notifier).getAllData();
    });
    super.initState();
  }

  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  List<MedicalReport> data = [];
  Widget build(context) {
    ref.watch(MedicalReportNotifier);
    data = ref.read(MedicalReportNotifier.notifier).state;
    print(data);
    return Scaffold(
      body: data.isEmpty
          ? const Center(
              child: Text("List Is Empty"),
            )
          : SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      child: Text(
                        "Medical History",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                print(AppConstants.IP);
                                developer.log(
                                  name: "ss",
                                  'http://192.168.119.85:4000/sessionAttachments/' +
                                      data[index].reportLinks.toString(),
                                );
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      print("ssser");
                                      return StatefulBuilder(
                                          builder: ((context, setState) {
                                        return Container(
                                          color: Colors.grey[100],
                                          child: Column(
                                            children: [
                                              Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.54,
                                                child: SfPdfViewer.network(
                                                  'http://192.168.119.85:4000/sessionAttachments/' +
                                                      data[index]
                                                          .reportLinks
                                                          .toString(),
                                                ),
                                              ),
                                              ElevatedButton(
                                                  onPressed: () async {
                                                    showDialog(
                                                        context: context,
                                                        builder: (builder) {
                                                          return AlertDialog(
                                                            title: Text(
                                                                "Fetching Report Explanation"),
                                                            content: Container(
                                                              width: 300,
                                                              child: Center(
                                                                  child:
                                                                      CircularProgressIndicator()),
                                                            ),
                                                          );
                                                        });
                                                    var res = await Doctors
                                                        .getReportExplanation(
                                                            data[index]
                                                                .reports);
                                                    if (res != "fail") {
                                                      developer.log(
                                                          name: "gotdata",
                                                          "ss");
                                                      Navigator.pop(context);
                                                      showDialog(
                                                          context: context,
                                                          builder: (builder) {
                                                            return StatefulBuilder(
                                                                builder: (context,
                                                                    setstate) {
                                                              return SingleChildScrollView(
                                                                child:
                                                                    Container(
                                                                  height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height,
                                                                  color: Colors
                                                                          .grey[
                                                                      100],
                                                                  child: Text(
                                                                    res.toString(),
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            15),
                                                                    softWrap:
                                                                        true,
                                                                  ),
                                                                ),
                                                              );
                                                            });
                                                          });
                                                    }
                                                    // Navigator.pop(context);
                                                    ;
                                                  },
                                                  child:
                                                      Text("Get Explanation")),
                                              Expanded(
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        ...data[index]
                                                            .reports
                                                            .entries
                                                            .map((entry) {
                                                          return Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(12),
                                                            child: Text(
                                                                "${entry.key}: ${entry.value}"),
                                                          );
                                                        }).toList(),
                                                      ]),
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      }));
                                    });
                              },
                              child: MyTimelineTile(
                                  name: data[index].doctor.doctorName,
                                  isFirst: index == 0,
                                  isLast: index == data.length - 1,
                                  isPast: true),
                            );
                          }),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
