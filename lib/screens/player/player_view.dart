/*
 *  player_view.dart
 *
 *  Created by Recipe Codes <info@recipe.codes> on 14.11.2022.
 */

import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:single_radio/config.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:single_radio/screens/player/local_widgets/sidebar.dart';
import 'package:single_radio/screens/player/player_viewmodel.dart';
import 'package:single_radio/theme.dart';

import 'wave_cover.dart';

class PlayerView extends StatefulWidget {
  const PlayerView({Key? key}) : super(key: key);
  static const routeName = '/';

  @override
  PlayerViewState createState() => PlayerViewState();
}

class PlayerViewState extends State<PlayerView>
    with SingleTickerProviderStateMixin {
  late final viewModel = Provider.of<PlayerViewModel>(context, listen: true);

  double get padding => MediaQuery.of(context).size.width * 0.08;

  ConnectivityResult? _connectivityResult;
  late StreamSubscription _connectivitySubscription;
  bool? _isConnectionSuccessful;
  late AnimationController _animationController;

  bool isActive = false;

  void _runAnimation() async {
    for (int i = 0; i < 1; i++) {
      await _animationController.forward();
      await _animationController.reverse();
    }
  }

  @override
  initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      print('Current connectivity status: $result');
      setState(() {
        _connectivityResult = result;
      });
    });
  }

  @override
  dispose() {
    super.dispose();

    _connectivitySubscription.cancel();
  }

  Future<void> _tryConnection() async {
    try {
      final response = await InternetAddress.lookup('google.com');

      setState(() {
        _isConnectionSuccessful = response.isNotEmpty;
      });
    } on SocketException catch (e) {
      print(e);
      setState(() {
        _isConnectionSuccessful = false;
      });
    }
  }

  final Waves _waves = Waves();

  @override
  Widget build(BuildContext context) {
    _tryConnection();
    return _isConnectionSuccessful != null && _isConnectionSuccessful!
        ? Scaffold(
            appBar: AppBar(
                title: Image.asset('assets/images/sidebar.png', height: 80),
                elevation: 0,
                toolbarHeight: 90),
            drawer: Sidebar(),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: padding,
                    ),
                    child: Column(
                      children: <Widget>[
                        _buildStreamCover(),
                        _builStreamTitle(),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            _buildlike(),
                            _buildControlButton(),
                            _builddislike(),
                          ],
                        ),
                        SizedBox(height: 20),
                        _buildshare(),
                        SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
                //AdmobService.banner,
              ],
            ),
          )
        : const Scaffold(
            body: Center(
              child: Text("No internet connection"),
            ),
          );
  }

  Widget _buildStreamCover() {
    return Center(
        child: Stack(alignment: Alignment.center, children: <Widget>[
      Visibility(
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        visible: viewModel.isPlaying,
        child: _waves,
      ),
      Padding(
          padding: const EdgeInsets.all(10.00),
          child: Container(
              width: 300.00,
              height: 300.00,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.grey[800]!, Colors.black]),
              ),
              child: Padding(
                  padding: const EdgeInsets.all(5.00),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(viewModel.cover),
                            fit: BoxFit.scaleDown,
                            colorFilter: const ColorFilter.mode(
                                Colors.black, BlendMode.softLight)) // Image
                        ), // Box Decoration
                  ) // Container,

                  ) // Padding,

              ) // Container,
          )
    ]));
    // Padding
  }

  Widget _builStreamTitle() {
    return Expanded(
      child: SizedBox(
        height: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 40),
                  child: Text(
                    viewModel.artist,
                    softWrap: false,
                    overflow: TextOverflow.fade,
                    style: GoogleFonts.cairo(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: AppTheme.artistTextColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                RotationTransition(
                    turns: Tween(begin: 0.0, end: -.1)
                        .chain(CurveTween(curve: Curves.elasticIn))
                        .animate(_animationController),
                    child: IconButton(
                      icon: Icon(
                        Icons.notifications_active_outlined,
                        color: isActive == true ? Colors.blue : Colors.grey,
                      ),
                      onPressed: () {
                        _runAnimation();
                        if(isActive==true){
                        setState(() {
                         isActive=false;
                        });}else{
                          setState(() {
                            isActive=true;

                          });
                        }
                      },
                    )),
              ],
            ),
            Text(
              viewModel.track,
              softWrap: false,
              overflow: TextOverflow.fade,
              textAlign: TextAlign.center,
              style: GoogleFonts.cairo(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: AppTheme.trackTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlButton() {
    return ClipOval(
      child: Material(
        color: AppTheme.controlButtonColor,
        child: InkWell(
          splashColor: AppTheme.controlButtonSplashColor,
          child: SizedBox(
            width: 70,
            height: 70,
            child: Icon(
              viewModel.isPlaying
                  ? Icons.pause_rounded
                  : Icons.play_arrow_rounded,
              size: 38,
              color: AppTheme.controlButtonIconColor,
            ),
          ),
          onTap: () {
            viewModel.isPlaying ? viewModel.pause() : viewModel.play();
          },
        ),
      ),
    );
  }

  Widget _buildlike() {
    return ClipOval(
      child: Material(
        color: AppTheme.controlButtonColor,
        child: InkWell(
          splashColor: AppTheme.controlButtonSplashColor,
          child: SizedBox(
            width: 50,
            height: 50,
            child: Icon(
              viewModel.isPlaying ? Icons.thumb_up : Icons.thumb_up,
              size: 28,
              color: AppTheme.controlButtonIconColor,
            ),
          ),
          onTap: () {},
        ),
      ),
    );
  }

  Widget _builddislike() {
    return ClipOval(
      child: Material(
        color: AppTheme.controlButtonColor,
        child: InkWell(
          splashColor: AppTheme.controlButtonSplashColor,
          child: SizedBox(
            width: 50,
            height: 50,
            child: Icon(
              viewModel.isPlaying ? Icons.thumb_down : Icons.thumb_down,
              size: 28,
              color: AppTheme.controlButtonIconColor,
            ),
          ),
          onTap: () {},
        ),
      ),
    );
  }

  Widget _buildshare() {
    return ClipOval(
      child: Material(
        color: AppTheme.controlButtonColor,
        child: InkWell(
          splashColor: AppTheme.controlButtonSplashColor,
          child: SizedBox(
            width: 50,
            height: 50,
            child: Icon(
              viewModel.isPlaying ? Icons.share : Icons.share,
              size: 28,
              color: AppTheme.controlButtonIconColor,
            ),
          ),
          onTap: () async {
            await Share.share(Config.shareText, subject: Config.shareSubject);
          },
        ),
      ),
    );
  }
}
