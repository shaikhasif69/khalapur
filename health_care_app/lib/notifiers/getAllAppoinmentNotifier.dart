import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:health_care_app/models/medical.dart';
import 'package:health_care_app/services/doctors.dart';
import 'package:siri_wave/siri_wave.dart';
import 'package:speech_to_text/speech_to_text.dart';

class GetALlMedicalHistory extends StateNotifier<List<MedicalReport>> {
  GetALlMedicalHistory() : super(<MedicalReport>[]);
  late SiriWaveformController controller;
  FlutterTts tts = FlutterTts();

  void getAllData() async {
    state = await Doctors.getAllMedicalReports();
  }
}

final MedicalReportNotifier =
    StateNotifierProvider<GetALlMedicalHistory, List<MedicalReport>>(
        (ref) => GetALlMedicalHistory());
