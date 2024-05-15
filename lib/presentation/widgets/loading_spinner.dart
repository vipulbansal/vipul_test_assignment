import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:vipul_test_assignment/commons/theme/app_theme.dart';
import 'package:vipul_test_assignment/presentation/widgets/progress_indicator.dart';

import '../../services/loading_spinner_service.dart';



class LoadingSpinner extends StatefulWidget {
  static final GlobalKey<State<LoadingSpinner>> loadingKey = GlobalKey();

  final double opacity;
  final Widget? child;

  const LoadingSpinner({
    super.key,
    this.child,
    this.opacity = 0.5,
  });

  @override
  State<LoadingSpinner> createState() => _LoadingSpinnerState();
}

class _LoadingSpinnerState extends State<LoadingSpinner> {
  bool isLoading = false;
  StreamSubscription<bool>? loadingListener;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadingListener =
          LoadingSpinnerService.loadingStream.stream.listen((bool event) {
        setState(() {
          isLoading = event;
        });
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    LoadingSpinnerService().stopLoading();
    if (loadingListener != null) {
      loadingListener!.cancel();
      loadingListener = null;
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      key: LoadingSpinner.loadingKey,
      builder: (BuildContext builderContext, _) {
        return LoadingOverlay(
          isLoading: isLoading,
          opacity: widget.opacity,
          color: AppThemeManager.primaryColor,
          progressIndicator: const GetProgressIndicator(),
          child: widget.child ?? Container(),
        );
      },
    );
  }
}
