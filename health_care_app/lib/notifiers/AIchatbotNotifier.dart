import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:health_care_app/services/doctors.dart';
import 'package:siri_wave/siri_wave.dart';
import 'package:speech_to_text/speech_to_text.dart';

class AIChatBotNotiferProvider extends StateNotifier<String> {
  AIChatBotNotiferProvider() : super("");
  late SiriWaveformController controller;
  FlutterTts tts = FlutterTts();

  void SetToStart() {
    state = "Welcome TO Doctor AI... How Can I Help You";
    tts.speak(state);
  }

  void Mute() {
    tts.stop();
  }

  void getData(String data) async {
    await tts.setSpeechRate(0.4);
    print("request Sent");
    state = await Doctors.getAIChatBotdata(data);
    tts.speak(state);
  }
}

final AIChatBotnotifier =
    StateNotifierProvider<AIChatBotNotiferProvider, String>(
        (ref) => AIChatBotNotiferProvider());
