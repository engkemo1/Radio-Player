/*
 *  timer_view.dart
 *
 *  Created by Ilya Chirkunov <xc@yar.net> on 14.11.2020.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:single_radio/language.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:single_radio/theme.dart';
import 'package:single_radio/extensions/duration_extension.dart';
import 'package:single_radio/screens/timer/timer_viewmodel.dart';

class TimerView extends StatefulWidget {
  const TimerView({Key? key}) : super(key: key);
  static const routeName = '/timer';

  @override
  TimerViewState createState() => TimerViewState();
}

class TimerViewState extends State<TimerView> {
  late final viewModel = Provider.of<TimerViewModel>(context, listen: true);
  late final width = MediaQuery.of(context).size.width - 60;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Language.sleepTimer),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            _buildSlider(),
            const Spacer(flex: 2),
            _buildButton(
              title: Language.startTimer,
              visible: viewModel.timer?.isActive != true,
              color: AppTheme.timerButtonBackgroundColor,
              textColor: AppTheme.timerButtonTextColor,
              onTap: () {
                viewModel.startTimer();
              },
            ),
            _buildButton(
              title: Language.stopTimer,
              visible: viewModel.timer?.isActive == true,
              color: AppTheme.timerStopButtonBackgroundColor,
              textColor: AppTheme.timerStopButtonTextColor,
              onTap: () {
                viewModel.stopTimer();
              },
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }

  Widget _buildSlider() {
    return SleekCircularSlider(
      appearance: CircularSliderAppearance(
        size: 260,
        startAngle: 270,
        angleRange: 360,
        customWidths: CustomSliderWidths(
          trackWidth: 5,
          progressBarWidth: 30,
          handlerSize: 6,
          shadowWidth: 42,
        ),
        customColors: CustomSliderColors(
          trackColor: AppTheme.timerSliderTrackColor,
          progressBarColor: AppTheme.timerSliderColor,
          shadowColor: AppTheme.timerSliderColor,
          dotColor: AppTheme.timerSliderDotColor,
          shadowMaxOpacity: 0.1,
        ),
      ),
      onChange: (double value) {
        viewModel.setTimer(Duration(seconds: value.toInt()));
      },
      initialValue: viewModel.timerDuration.inSeconds.toDouble(),
      min: 0,
      max: 5400,
      innerWidget: (value) {
        return _buildCenterText();
      },
    );
  }

  Widget _buildCenterText() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          Language.timeLeft,
          style: TextStyle(
            color: AppTheme.timerSliderTextColor,
          ),
        ),
        const SizedBox(height: 15),
        Text(
          viewModel.timerDuration.format(),
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
            color: AppTheme.timerSliderTextColor,
          ),
        ),
      ],
    );
  }

  Widget _buildButton({
    required title,
    required visible,
    required color,
    required textColor,
    required onTap,
  }) {
    return Visibility(
      visible: visible,
      child: ElevatedButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(textColor),
          backgroundColor: MaterialStateProperty.all<Color>(color),
          minimumSize: MaterialStateProperty.all<Size>(const Size(180, 40)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          ),
        ),
        onPressed: onTap,
        child: Text(title),
      ),
    );
  }
}
