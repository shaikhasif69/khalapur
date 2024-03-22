import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:health_care_app/notifiers/AIchatbotNotifier.dart';
import 'package:siri_wave/siri_wave.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:permission_handler/permission_handler.dart';

class BottomSheet1 extends ConsumerStatefulWidget {
  BottomSheet1({required this.controller});

  SiriWaveformController controller;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _BottomSheet();
    // TODO: implement createState
    throw UnimplementedError();
  }
}

String ChatBotString = "";

class _BottomSheet extends ConsumerState<BottomSheet1> {
  FlutterTts tts = FlutterTts();
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = "";
  _startListening() async {
    setState(() {
      _lastWords = "";
    });
    await _speechToText.listen(
      onResult: _onSpeechResult,
      listenFor: const Duration(seconds: 30),
      localeId: "en_En",
      cancelOnError: false,
      partialResults: false,
      listenMode: ListenMode.confirmation,
    );

    print(_lastWords);

    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) async {
    setState(() {
      _lastWords = "$_lastWords${result.recognizedWords} ";
      _lastWords;

      print(_lastWords);
    });
    if (_lastWords != "") {
      ref.read(AIChatBotnotifier.notifier).getData(_lastWords);
    }
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
  }

  Future<void> requestForPermission() async {
    await Permission.microphone.request();
  }

  void listenForPermissions() async {
    final status = await Permission.microphone.status;
    switch (status) {
      case PermissionStatus.denied:
        requestForPermission();
        break;
      case PermissionStatus.granted:
        break;
      case PermissionStatus.limited:
        break;
      case PermissionStatus.permanentlyDenied:
        break;
      case PermissionStatus.restricted:
        break;
      case PermissionStatus.provisional:
      // TODO: Handle this case.
    }
  }

  // tts.setSpeechRate(rate)
  @override
  void initState() {
    listenForPermissions();
    if (!_speechEnabled) {
      _initSpeech();
    }
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(AIChatBotnotifier.notifier).SetToStart();
    });
    WidgetsFlutterBinding.ensureInitialized();
    setTts();

    super.initState();
  }

  void setTts() async {
    await tts.setSpeechRate(0.4);
  }

  Widget build(context) {
    // ref.watch(AIChatBotnotifier);
    ChatBotString = ref.watch(AIChatBotnotifier);

    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      color: Colors.grey[100],
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            padding: EdgeInsets.all(16),
            child: Text(
              "Doctor AI",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
          Spacer(),
          Container(
              padding: EdgeInsets.all(8),
              height: 210,
              child: SingleChildScrollView(
                  child: Text(
                ChatBotString,
                softWrap: true,
                style: TextStyle(fontSize: 20),
              ))),
          const Spacer(),
          Container(
              height: 50,
              child: SingleChildScrollView(
                  child: Text(
                _lastWords,
                softWrap: true,
              ))),
          InkWell(
            onTap: () {
              ref.read(AIChatBotnotifier.notifier).Mute();
              _startListening();
            },
            child: Container(
              height: 100,
              width: 200,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  shape: BoxShape.circle),
              child: SiriWaveform.ios7(
                controller: widget.controller as IOS7SiriWaveformController,
                options: const IOS7SiriWaveformOptions(
                  height: kIsWeb ? 300 : 180,
                  width: kIsWeb ? 600 : 360,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
