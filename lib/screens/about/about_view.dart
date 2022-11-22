/*
 *  about_view.dart
 *
 *  Created by Ilya Chirkunov <xc@yar.net> on 05.04.2021.
 */

import 'package:flutter/material.dart';
import 'package:single_radio/config.dart';
import 'package:single_radio/theme.dart';
import 'package:single_radio/language.dart';
import 'package:single_radio/widgets/markdown.dart';

class AboutView extends StatelessWidget {
  const AboutView({Key? key}) : super(key: key);
  static const routeName = '/about';

  @override
  Widget build(BuildContext context) {
    final spacing = MediaQuery.of(context).size.width * 0.08;

    return Scaffold(
      appBar: AppBar(
        title: const Text(Language.aboutUs),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildProfileContainer(),
            SizedBox(height: spacing),
            _buildDescriptionContainer(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(bottom: 6, left: 18),
          child: Text(
            Language.profile,
            style: TextStyle(
              color: AppTheme.aboutUsContainerTitleColor,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppTheme.aboutUsContainerBackgroundColor,
          ),
          child: Column(
            children: <Widget>[
              const Text(
                Config.title,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: AppTheme.aboutUsTitleColor,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                Config.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: AppTheme.aboutUsDescriptionColor,
                ),
              ),
              const SizedBox(height: 14),
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.asset(
                  'assets/images/about.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(bottom: 6, left: 18),
          child: Text(
            Language.description,
            style: TextStyle(
              color: AppTheme.aboutUsContainerTitleColor,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppTheme.aboutUsContainerBackgroundColor,
          ),
          child: MarkdownText(
            'assets/text/about.md',
            textStyle: TextStyle(
              fontSize: 14,
              height: 1.3,
              color: AppTheme.aboutUsTextColor,
            ),
          ),
        ),
      ],
    );
  }
}
