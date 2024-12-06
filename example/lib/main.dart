import 'package:example/slider_captcha_client_verify.dart';
import 'package:example/slider_captcha_server_verify.dart';
import 'package:flutter/material.dart';
import 'package:slider_captcha/slider_captcha.dart';

import 'service/slider_captcha_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TestPage()
    );
    // home: const SliderCaptchaClientVerify(title: 'Slider to verify'));
  }
}

class TestPage extends StatelessWidget {
  final _service = SliderCaptchaService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Test")),
      body: Container(
        child: Center(
          child: TextButton(
            onPressed: () async {
              final captcha = await _service.getCaptcha();
              showDialog(context: context, builder: (context) {
                return Dialog(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: SliderCaptchaClient(
                    provider: SliderCaptchaClientProvider(
                      puzzleBase64: captcha?.puzzleImage ?? '',
                      pieceBase64: captcha?.pieceImage ?? '',
                      coordinatesY: captcha?.y ?? 0,
                    ),
                    onConfirm: (value) async {
                      /// Can you verify captcha at here
                      // await Future.delayed(const Duration(seconds: 1));
                      // debugPrint(value.toString());
                      await _service.postAnswer(Solution(
                        id: captcha!.id,
                        x: value.toInt(),
                        endTime: DateTime.now().millisecondsSinceEpoch
                      ));
                    },
                  ),
                );
              });
            },
            child: Text("PressMe"),
          ),
        ),
      ),
    );
  }
}
