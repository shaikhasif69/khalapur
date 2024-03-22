import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health_care_app/models/medical.dart';
import 'package:health_care_app/notifiers/getAllAppoinmentNotifier.dart';
import 'package:health_care_app/utils/my_timeline_tile.dart';
import 'package:health_care_app/utils/timeline_container.dart';

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

  List<MedicalReport> data = [];
  Widget build(context) {
    data = ref.watch(MedicalReportNotifier);

    return Scaffold(
      body: SingleChildScrollView(
        child: data.isEmpty
            ? const Center(
                child: Text("List Is Empty"),
              )
            : ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return MyTimelineTile(
                      isFirst: index == 0,
                      isLast: index == data.length - 1,
                      isPast: true);
                }),
      ),
    );
  }
}
