/*
 *  admob_disable.dart
 *
 *  Created by Ilya Chirkunov <xc@yar.net> on 08.07.2022.
 */

import 'dart:io';
import 'package:dart_common_utils/dart_common_utils.dart';

void main() {
  step0();
  step1();
  step2();
  step3();
  step4();
  //step5();
}

// Clean project.
void step0() {
  File('ios/Podfile.lock').adaptPath.deleteIfExistsSync();
  Directory('ios/Pods').adaptPath.deleteIfExistsSync(recursive: true);
  Directory('ios/.symlinks').adaptPath.deleteIfExistsSync(recursive: true);
}

// Remove dependencies from 'pubspec.yaml' file.
void step1() {
  const filename = 'pubspec.yaml';
  const line = 'google_mobile_ads: ^1.3.0';

  final content = File(filename).adaptPath.readAsStringSync();
  if (content.contains('#$line')) System.die('Admob is already disabled.');

  File(filename).adaptPath.replaceContent(line, '#$line');
}

// Remove initialization string from 'main.dart' file.
void step2() {
  const filename = 'lib/main.dart';
  const line1 = "import 'package:single_radio/services/admob_service.dart';";
  const line2 = "await AdmobService.init();";

  File(filename).adaptPath.replaceContent(line1, '//$line1');
  File(filename).adaptPath.replaceContent(line2, '//$line2');
}

// Rename 'admob_service.dart' file to 'admob_service.off'.
void step3() {
  const filename = 'lib/services/admob_service.dart';
  const filenameOff = 'lib/services/admob_service.off';

  if (!File(filename).adaptPath.existsSync()) {
    System.die('File "$filename" not found.');
  }

  File(filename).adaptPath.renameSync(File(filenameOff).adaptPath.path);
}

// Remove banner from 'lib/screens/player/player_view.dart' file.
void step4() {
  const filename = 'lib/screens/player/player_view.dart';
  const line1 = "import 'package:single_radio/services/admob_service.dart';";
  const line2 = "AdmobService.banner,";

  File(filename).adaptPath.replaceContent(line1, '//$line1');
  File(filename).adaptPath.replaceContent(line2, '//$line2');
}

// Remove the NSUserTrackingUsageDescription key from Info.plist.
void step5() {
  const filename = 'ios/Runner/Info.plist';
  const line1 = "<key>NSUserTrackingUsageDescription</key>";
  const line1tmp = "<key>AdmobKey1</key>";
  const line2 =
      "<string>This identifier will be used to deliver personalized ads to you.</string>";
  const line2tmp = "<string>AdmobString1</string>";

  File(filename).adaptPath.replaceContent(line1, line1tmp);
  File(filename).adaptPath.replaceContent(line2, line2tmp);
}
