import 'package:flutter/material.dart';
import 'package:gemini/src/controller/home_controller.dart';
import 'package:gemini/src/custom_widget/custom_widget.dart';
import 'package:get/get.dart';


class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeController _homeController = Get.put(HomeController());


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Voice Assistant'),
          centerTitle: true,
        ),
        body: getBody()
    );
  }


  getBody() {
    return Center(
      child: Obx(() {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                _homeController.question.value,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20,),


            Text(
              _homeController.generatingAnswer.value ?
              'Generating answer. Please wait...' :
              '',
              style: const TextStyle(
                  color: Colors.red
              ),
            ),

            const SizedBox(height: 20,),


            ElevatedButton(
                onPressed: () {
                  if (_homeController.isListening.value == false) {
                    if (_homeController.generatingAnswer.value == false) {
                      _homeController.speak();
                    } else {
                      CustomWidget.toast('Generating answer', Colors.red);
                    }

                  } else {
                    _homeController.stop();
                  }
                },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
                fixedSize: const Size(100, 100),
                backgroundColor: Colors.white
              ),
              child: Center(
                child: Icon(
                    _homeController.isListening.value ? Icons.stop : Icons.keyboard_voice,
                  color: _homeController.isListening.value ? Colors.red : Colors.green,
                  size: 60,
                ),
              ),
                //child: Text(_homeController.isListening.value ? 'Stop' : 'Speak')
            ),
          ],
        );
      }),
    );
  }
}