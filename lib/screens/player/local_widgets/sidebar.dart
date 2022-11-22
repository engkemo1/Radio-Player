/*
 *  sidebar.dart
 *
 *  Created by Ilya Chirkunov <xc@yar.net> on 14.11.2020.
 */

import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:single_radio/config.dart';
import 'package:single_radio/theme.dart';
import 'package:single_radio/language.dart';
import 'package:single_radio/widgets/markdown.dart';
import 'package:single_radio/screens/about/about_view.dart';
import 'package:single_radio/screens/about/schedule.dart';

class Sidebar extends StatelessWidget {
  Sidebar({Key? key}) : super(key: key);
  final inAppReview = InAppReview.instance;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppTheme.drawerBackgroundColor,
      child: ListView(
        padding: const EdgeInsets.only(top: 0),
        children: [
          _buildHeader(),
          ..._buildItems(context),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: AppTheme.drawerHeaderColor,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DrawerHeader(
        margin: EdgeInsets.zero,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.asset(
                'assets/images/sidebar.png',
                width: 55,
                height: 55,
                fit: BoxFit.cover,
              ),
            ),
            const Text(
              Config.title,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                height: 1.8,
                color: AppTheme.drawerTitleColor,
              ),
            ),
            Text(
              Config.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                height: 1.6,
                color: AppTheme.drawerDescriptionColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildItems(BuildContext context) {
    return [
      // Timer
      _buildListTile(
        icon: Icons.watch_later_outlined,
        title: Language.timer,
        onTap: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, '/timer');
        },
      ),

      // Instagram
      Visibility(
        visible: Config.instagram.isNotEmpty,
        child: _buildListTile(
          svgFileName: 'assets/svg/instagram.svg',
          title: Language.instagram,
          onTap: () async {
            Navigator.pop(context);
            await launchUrl(Uri.parse(Config.instagram));
          },
        ),
      ),

      // Twitter
      Visibility(
        visible: Config.tiktok.isNotEmpty,
        child: _buildListTile(
          svgFileName: 'assets/svg/twitter.svg',
          title: Language.twitter,
          onTap: () async {
            Navigator.pop(context);
            await launchUrl(Uri.parse(Config.tiktok));
          },
        ),
      ),

      // Facebook
      Visibility(
        visible: Config.facebook.isNotEmpty,
        child: _buildListTile(
          svgFileName: 'assets/svg/facebook.svg',
          title: Language.facebook,
          onTap: () async {
            Navigator.pop(context);
            await launchUrl(Uri.parse(Config.facebook));
          },
        ),
      ),

      // Website
      Visibility(
        visible: Config.website.isNotEmpty,
        child: _buildListTile(
          svgFileName: 'assets/svg/website.svg',
          title: Language.website,
          onTap: () async {
            Navigator.pop(context);
            await launchUrl(Uri.parse(Config.website));
          },
        ),
      ),

      // Email
      Visibility(
        visible: Config.email.isNotEmpty,
        child: _buildListTile(
          icon: Icons.email_outlined,
          title: Language.email,
          onTap: () async {
            Navigator.pop(context);
            launchUrl(
              Uri(
                scheme: 'mailto',
                path: Config.email,
                query: 'subject=${Config.title}',
              ),
            );
          },
        ),
      ),

      // Rate Us
      _buildListTile(
        icon: Icons.star_outline,
        title: Language.rateUs,
        onTap: () {
          Navigator.pop(context);
          inAppReview.openStoreListing(appStoreId: Config.appStoreId);
        },
      ),

      // Privacy Policy
      _buildListTile(
        icon: Icons.description_outlined,
        title: Language.privacyPolicy,
        onTap: () {
          Navigator.pop(context);

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const MarkdownDialog('assets/text/privacy_policy.md');
            },
          );
        },
      ),

      // Up Coming
      _buildListTile(
        icon: Icons.description_outlined,
        title: Language.Upcoming,
        onTap: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, ScheduleView.routeName);
        },
      ),

      // About Us
      _buildListTile(
        icon: Icons.group_outlined,
        title: Language.aboutUs,
        onTap: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, AboutView.routeName);
        },
      ),
    ];
  }

  Widget _buildListTile({
    IconData? icon,
    String? svgFileName,
    required String title,
    required Function() onTap,
  }) =>
      ListTile(
        leading: icon != null
            ? Icon(
                icon,
                size: 24,
                semanticLabel: '$title Icon',
              )
            : SvgPicture.asset(
                svgFileName!,
                width: 24,
                height: 24,
                color: AppTheme.drawerIconColor,
                semanticsLabel: '$title Icon',
              ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        onTap: onTap,
      );
}
