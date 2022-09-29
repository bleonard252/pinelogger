import 'package:flutter/foundation.dart';
import 'package:pinelogger/pinelogger.dart';
import 'dart:developer' as developer;

var _loggerSequence = 0;

void flutterLogger(PinelogMessage message) {
  developer.log(
    message.message.toString(),
    name: message.logger.name,
    error: message.error,
    stackTrace: message.stackTrace,
    time: message.timestamp,
    level: message.severity.index,
    sequenceNumber: _loggerSequence,
  );
  _loggerSequence++;
}

/// Filters the printer to only work in debug mode.
/// This is most useful with [MultiPrinter].
class DebugOnlyPrinter {
  final PinelogPrinter printer;

  DebugOnlyPrinter(this.printer);

  void call(PinelogMessage message) {
    if (kDebugMode) {
      printer(message);
    }
  }
}

/// Filters the printer to only work in release mode.
/// This is most useful with [MultiPrinter].
class ReleaseOnlyPrinter {
  final PinelogPrinter printer;

  ReleaseOnlyPrinter(this.printer);

  void call(PinelogMessage message) {
    if (kReleaseMode) {
      printer(message);
    }
  }
}