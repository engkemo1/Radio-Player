/*
 *  metadata_service.dart
 *
 *  Created by Ilya Chirkunov <xc@yar.net> on 03.02.2022.
 */

import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:dart_common_utils/dart_common_utils.dart';
import 'package:single_radio/config.dart';

class MetadataService {
  MetadataService({
    required this.callback,
  });

  Function(List<String>) callback;
  List<String>? _previousMetadata;
  Timer? _timer;

  void start() => _timer =
      Timer.periodic(const Duration(seconds: Config.timerPeriod), _parser);
  void stop() => _timer?.cancel();

  Future<void> _parser(Timer t) async {
    var metadata = ['', '', ''];
    var title = '';
    final response = await get(Uri.parse(Config.metadataUrl));

    // Parse Json.
    try {
      final body = json.decode(response.body) as Map<String, dynamic>;
      title = body[Config.titleTag] ?? '';
      metadata[0] = body[Config.artistTag] ?? '';
      metadata[1] = body[Config.trackTag] ?? '';
      metadata[2] = body[Config.coverTag] ?? '';
    }

    // Parse XML.
    catch (_) {
      final s = utf8.decode(response.bodyBytes);
      title = s.betweenTag(Config.titleTag);
      metadata[0] = s.betweenTag(Config.artistTag);
      metadata[1] = s.betweenTag(Config.trackTag);
      metadata[2] = s.betweenTag(Config.coverTag);
    }

    // Check title.
    if (title.isNotEmpty) {
      final titleList = title.split(Config.titleSeparator);
      metadata[0] = titleList[0];
      metadata[1] = (titleList.length > 1) ? titleList[1] : '';
    }

    // Check for empty metadata.
    if (metadata[0].isEmpty && metadata[1].isEmpty) {
      return;
    }

    // The single line is always at the top.
    if (metadata[0].isEmpty) {
      metadata[0] = metadata[1];
      metadata[1] = '';
    }

    // The second line cannot be empty.
    if (metadata[1].isEmpty) {
      metadata[1] = Config.title;
    }

    // Update metadata.
    if (!listEquals(metadata, _previousMetadata)) {
      _previousMetadata = metadata;
      callback(metadata);
    }
  }
}
