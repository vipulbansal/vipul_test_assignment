import 'dart:async';

import 'package:flutter/cupertino.dart';

class LoadingSpinnerService {
  static final LoadingSpinnerService _instance =
      LoadingSpinnerService._internal();

  factory LoadingSpinnerService() => _instance;

  static final StreamController<bool> loadingStream =
      StreamController<bool>.broadcast();
  Timer? timer;
  final List<_LoadingEvent> eventQueue = <_LoadingEvent>[];

  void push({bool silent = false}) {
    _addLoadingEvent(_LoadingEvent(silent: silent));
  }

  void pop({bool silent = false}) {
    _consumeLoadingEvent(silent);
  }

  void stopLoading() {
    clearQueue();
    _cancelTimer();
    _checkQueue();
  }

  void clearQueue() {
    eventQueue.clear();
  }

  void _addLoadingEvent(_LoadingEvent event) {
    eventQueue.add(event);
    _checkQueue();
  }

  void _consumeLoadingEvent([bool silent = false]) {
    _LoadingEvent? event;
    try {
      event = eventQueue
          .firstWhere((_LoadingEvent element) => element.silent == silent);
    } catch (_) {}

    if (event != null) {
      eventQueue.remove(event);
    }

    if (eventQueue.isEmpty) {
      _setTimer(() {
        loadingStream.add(false);
      });
    } else {
      _checkQueue(silent: silent);
    }
  }

  void _cancelTimer() {
    if (timer != null) {
      if (timer!.isActive) {
        timer!.cancel();
      }
      timer = null;
    }
  }

  void _setTimer(VoidCallback callback) {
    if (timer == null) {
      timer = Timer(const Duration(milliseconds: 200), () {
        callback();
        timer = null;
      });
    } else {
      _cancelTimer();
      _setTimer(callback);
    }
  }

  void _checkQueue({bool silent = false}) {
    _LoadingEvent? event;
    bool scheduledDisplayable;

    try {
      event = eventQueue
          .firstWhere((_LoadingEvent element) => element.silent == silent);
    } catch (_) {}

    if (event == null) {
      if (!silent) {
        _setTimer(() {
          loadingStream.add(false);
        });
      }
      return;
    }

    bool showLoading = !event.silent;
    if (showLoading) {
      loadingStream.add(true);
    }

    try {
      scheduledDisplayable =
          eventQueue.where((_LoadingEvent event) => !event.silent).length > 1;
    } catch (e) {
      scheduledDisplayable = false;
    }

    if (!scheduledDisplayable && !showLoading) {
      loadingStream.add(false);
    }
  }

  LoadingSpinnerService._internal();
}

class _LoadingEvent {
  bool silent;

  _LoadingEvent({
    this.silent = false,
  });

  @override
  String toString() {
    return '{silent: $silent}';
  }
}
