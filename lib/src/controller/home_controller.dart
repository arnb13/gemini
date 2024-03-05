import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:text_to_speech/text_to_speech.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../custom_widget/custom_widget.dart';


class HomeController extends GetxController {
  final gemini = Gemini.instance;
  TextToSpeech tts = TextToSpeech();
  stt.SpeechToText speech = stt.SpeechToText();

  RxList<String> answer = <String>[].obs;
  bool available = false;

  RxString question = ''.obs;

  RxBool isListening = false.obs;
  RxBool generatingAnswer = false.obs;


  @override
  void onInit() async {
    super.onInit();
    available = await speech.initialize();
  }

  hitGeminiApi() {

      tts.stop();
      generatingAnswer.value = true;
      answer.clear();

      gemini.text(question.value).then((value) {
        answer.addAll(value!.content!.parts!.last.text.toString().split('*'));

        answer.removeWhere((element) {
          if (element == '' || element == '*' || element == ' ' || element == '  ') {
            return true;
          } else {
            return false;
          }
        });


        String speech = answer.join(' ');
        print('XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX');
        print(speech);
        tts.setLanguage('bn-BD');
        tts.speak(speech);
        generatingAnswer.value = false;




      }).onError((error, stackTrace) {
        print('TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT');
        print(error.toString());
        generatingAnswer.value = false;
      });
    }

  speak() async {
    tts.stop();
    question.value = '';
    speech.stop();

    speech.listen(
        onResult: (result) {
      isListening.value = true;

      print('XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX');
      print(result.recognizedWords);
      print(result.finalResult);

      if (result.finalResult) {
        question.value = result.recognizedWords;
        isListening.value = false;
        if (question.value != '') {
          hitGeminiApi();
        } else {
          CustomWidget.toast('Sorry could not understand your question', Colors.red);
        }

      }
    },
        //listenOptions: stt.SpeechListenOptions(enableHapticFeedback: true, listenMode: stt.ListenMode.deviceDefault, autoPunctuation: true,),
    localeId: 'bn-BD'
    );
  }

  stop() async {
    await speech.stop();
  }
}