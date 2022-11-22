import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'package:single_radio/theme.dart';
import 'package:single_radio/language.dart';

class ScheduleView extends StatelessWidget {
  const ScheduleView({Key? key}) : super(key: key);
  static const routeName = '/schedule';


  @override
  Widget build(BuildContext context) {
    final spacing = MediaQuery.of(context).size.width * 0.08;

    return Scaffold(
      appBar: AppBar(
        title: const Text(Language.Upcoming),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spacing),
        child: Container(
          constraints: const BoxConstraints(maxHeight: 1000,maxWidth: double.infinity),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Color(0xffffffff)
          ),
          child: const WebView( javascriptMode: JavascriptMode.unrestricted,
            initialUrl: 'https://www.radiojar.com/widget/radio/45dmu9tvf3hvv/calendar/',
          ),
        ),
      ),
    );
  }

}
