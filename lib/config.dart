/*
 *  config.dart
 *
 *  Created by Recipe Codes <info@recipe.codes> on 12.12.2020.
 */
///c4wcxametv8uv
///
///
class Config {
  static const title = 'Radio WaW';
  static const description = 'Playing the Music You Love';
  static const streamUrl = 'https://stream.radiojar.com/7csmg90fuqruv';

  // // Social links
  static const instagram = 'https://www.instagram.com/wow.fm';
  static const tiktok = 'https://tiktok.com/wow.fm';
  static const facebook = 'https://www.facebook.com/wowradiowow';
  static const website = 'https://radiomiracle.org';
  static const email = 'info@recipe.codes';

  // Share
  static const shareSubject = 'Radio WaW App';
  static const shareText = "I'm Listening to Radio WaW.";

  // Rate Us
  static const appStoreId = '1479408317';

  // Automatically start playing when the app is launched.
  static const autoplay = true;

  // Replace default image with album cover.
  static const albumCover = true;

  // Search album cover on iTunes.
  static const albumCoverFromItunes = true;

  // See documentation to enable Admob.
  static const admobIosAdUnit = 'ca-app-pub-3940256099942544/6300978111';
  static const admobAndroidAdUnit = 'ca-app-pub-3940256099942544/6300978111';

  // Parse metadata from third-party sources.
  static const metadataUrl =
      'https://www.radiojar.com/api/stations/7csmg90fuqruv/now_playing/';
  static const artistTag = 'title';
  static const trackTag = 'artist';
  static const coverTag = 'thumb';
  static const titleTag = '';
  static const titleSeparator = ' - ';
  static const timerPeriod = 2;
}
