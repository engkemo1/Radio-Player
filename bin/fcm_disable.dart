/*
 *  fcm_disable.dart
 *
 *  Created by Ilya Chirkunov <xc@yar.net> on 24.04.2022.
 */

import 'dart:io';
import 'package:dart_common_utils/dart_common_utils.dart';

void main() {
  step0();
  step1();
  step2();
  step3();
  step4();
  step5();
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
  const dep1 = 'firebase_core: ^1.19.1';
  const dep2 = 'firebase_messaging: ^11.4.4';
  const dep3 = 'flutter_local_notifications: ^9.6.1';

  final content = File(filename).adaptPath.readAsStringSync();
  if (content.contains('#$dep1')) System.die('Fsm is already disabled.');

  File(filename).adaptPath.replaceContent(dep1, '#$dep1');
  File(filename).adaptPath.replaceContent(dep2, '#$dep2');
  File(filename).adaptPath.replaceContent(dep3, '#$dep3');
}

// Remove initialization string from 'main.dart' file.
void step2() {
  const filename = 'lib/main.dart';
  const line1 = "import 'package:single_radio/services/fcm_service.dart';";
  const line2 = "await FcmService.init();";

  File(filename).adaptPath.replaceContent(line1, '//$line1');
  File(filename).adaptPath.replaceContent(line2, '//$line2');
}

// Rename 'fcm_service.dart' file to 'fcm_service.off'.
void step3() {
  const filename = 'lib/services/fcm_service.dart';
  const filenameOff = 'lib/services/fcm_service.off';

  if (!File(filename).adaptPath.existsSync()) {
    System.die('File "$filename" not found.');
  }

  File(filename).adaptPath.renameSync(File(filenameOff).adaptPath.path);
}

// Remove Push Notifications capability from Xcode.
void step4() {
  const filename = 'ios/Runner/Runner.entitlements';
  const debugFilename = 'ios/Runner/RunnerDebug.entitlements';
  const entitlements = '''<dict>
	<key>aps-environment</key>
	<string>development</string>
</dict>''';

  File(filename).adaptPath.replaceContent(entitlements, '<dict/>');
  File(debugFilename).adaptPath.replaceContent(entitlements, '<dict/>');
}

// Remove firebase from gradle.
void step5() {
  const filename1 = 'android/build.gradle';
  const filename2 = 'android/app/build.gradle';
  const line1 = "classpath 'com.google.gms:google-services:4.3.10'";
  const line2 = "apply plugin: 'com.google.gms.google-services'";
  const line3 =
      "implementation platform('com.google.firebase:firebase-bom:29.2.1')";
  const line4 = "implementation 'com.google.firebase:firebase-analytics-ktx'";

  File(filename1).adaptPath.replaceContent(line1, '//$line1');
  File(filename2).adaptPath.replaceContent(line2, '//$line2');
  File(filename2).adaptPath.replaceContent(line3, '//$line3');
  File(filename2).adaptPath.replaceContent(line4, '//$line4');
}
