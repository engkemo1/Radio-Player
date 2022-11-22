/*
 *  main.dart
 *
 *  Created by Ilya Chirkunov <xc@yar.net> on 14.11.2020.
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:single_radio/theme.dart';
import 'package:single_radio/config.dart';
//import 'package:single_radio/services/admob_service.dart';
//import 'package:single_radio/services/fcm_service.dart';
import 'package:single_radio/screens/player/player_view.dart';
import 'package:single_radio/screens/player/player_viewmodel.dart';
import 'package:single_radio/screens/timer/timer_view.dart';
import 'package:single_radio/screens/timer/timer_viewmodel.dart';
import 'package:single_radio/screens/about/about_view.dart';
import 'package:single_radio/screens/about/schedule.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set device orientation.
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // Init services.
  //await AdmobService.init();
  //await FcmService.init();

  runApp(App());
}

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  final providers = [
    ChangeNotifierProvider<PlayerViewModel>(create: (_) => PlayerViewModel()),
    ChangeNotifierProxyProvider<PlayerViewModel, TimerViewModel>(
      create: (context) => TimerViewModel(),
      update: (context, playerViewModel, timerViewModel) =>
          timerViewModel!..onTimer = playerViewModel.pause,
    ),
  ];

  final routes = {
    PlayerView.routeName: (_) => const PlayerView(),
    AboutView.routeName: (_) => const AboutView(),
    ScheduleView.routeName: (_) => const ScheduleView(),
    TimerView.routeName: (_) => const TimerView(),
  };

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Config.title,
        theme: AppTheme.themeData,
        routes: routes,
      ),
    );
  }
}
