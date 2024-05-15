import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../commons/theme/app_theme.dart';



class GetProgressIndicator extends StatelessWidget {
  final double size;
  final Color? trackColor;

  const GetProgressIndicator({
    Key? key,
    this.size = 50,
    this.trackColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        height: 100,
        width: 100,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
          child: _loader(),
        ),
      ),
    );
  }

  Widget _loader() {
    final List<Widget> loaders = [
      LoadingAnimationWidget.halfTriangleDot(
        color: AppTheme.colorAccent,
        size: size,
      ),
      LoadingAnimationWidget.inkDrop(
        color: AppTheme.colorAccent,
        size: size / 1.25,
      ),
      LoadingAnimationWidget.fallingDot(
        color: AppTheme.colorAccent,
        size: size * 1.45,
      ),
      LoadingAnimationWidget.flickr(
        leftDotColor: AppTheme.colorAccent,
        rightDotColor: AppTheme.colorAccent.withOpacity(0.5),
        size: size,
      ),
      LoadingAnimationWidget.dotsTriangle(
        color: AppTheme.colorAccent,
        size: size,
      ),
      LoadingAnimationWidget.fourRotatingDots(
        color: AppTheme.colorAccent,
        size: size,
      ),
      SpinKitWaveSpinner(
        color: AppTheme.colorAccent,
        size: size,
        waveColor: AppTheme.colorAccent.withOpacity(0.5),
        trackColor: trackColor ?? AppTheme.colorAccent.withOpacity(0.5),
      )
    ];

    final random = Random();
    final randomIndex = random.nextInt(loaders.length);

    return loaders[randomIndex];
  }
}
