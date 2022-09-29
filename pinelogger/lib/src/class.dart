import 'dart:async';

import 'package:rxdart/rxdart.dart';

import 'messages.dart';
import 'printer.dart';
import 'severity.dart';

/// The function signature used by [Pinelogger] to print messages.
typedef PinelogPrinter = FutureOr<void> Function(PinelogMessage message);

class Pinelogger {
  final String name;
  final Pinelogger? parent;
  final Severity severity;
  final PinelogPrinter printer;
  final List<PinelogMessage> messages = [];
  final StreamController<PinelogMessage> _streamController = StreamController();
  Stream<PinelogMessage>? _stream;
  Stream<PinelogMessage> get stream => _stream ??= _streamController.stream.asBroadcastStream();

  Pinelogger(this.name, {
    this.parent,
    this.severity = Severity.info,
    this.printer = consolePrinter
  });

  Pinelogger child(String name, {Severity? severity}) {
    return independentChild("${this.name}.$name", severity: severity);
  }

  /// Get the topmost parent of this logger.
  Pinelogger get topParent => parent?.topParent ?? this;

  /// Only independent in name, just like a child.
  ///
  /// The parent is the same, and it still inherits properties,
  /// it just has a different name.
  Pinelogger independentChild(String name, {Severity? severity}) => Pinelogger(
    name,
    parent: this,
    severity: severity ?? this.severity,
    printer: printer
  );

  /// This is a print-friendly method. It returns a string like this:
  /// ```
  /// [Pinelogger] PineloggerName: 24 messages
  /// ```
  @override
  String toString() {
    return "[Pinelogger] $name: ${messages.length} messages";
  }

  /// Log a custom message. [severity] defaults to [Severity.info].
  void log(dynamic message, {Severity severity = Severity.info, PinelogExtraData? extraData, Object? error, StackTrace? stackTrace, bool logToTopParent = true}) {
    final logMessage = PinelogMessage(this,
      message: message,
      severity: severity,
      timestamp: DateTime.now(),
      extraData: extraData,
      error: error,
      stackTrace: stackTrace
    );
    messages.add(logMessage);
    _streamController.add(logMessage);
    if (logToTopParent) {
      topParent.messages.add(logMessage);
      topParent._streamController.add(logMessage);
    }
    if (severity >= this.severity) printer(logMessage);
  }

  /// Log a message with severity [Severity.verbose].
  void verbose(dynamic message, {PinelogExtraData? extraData, Object? error, StackTrace? stackTrace}) => log(message, severity: Severity.verbose, extraData: extraData, error: error, stackTrace: stackTrace);
  /// Log a message with severity [Severity.debug].
  void debug(dynamic message, {PinelogExtraData? extraData, Object? error, StackTrace? stackTrace}) => log(message, severity: Severity.debug, extraData: extraData, error: error, stackTrace: stackTrace);
  /// Log a message with severity [Severity.info].
  void info(dynamic message, {PinelogExtraData? extraData, Object? error, StackTrace? stackTrace}) => log(message, severity: Severity.info, extraData: extraData, error: error, stackTrace: stackTrace);
  /// Log a message with severity [Severity.warning].
  void warning(dynamic message, {PinelogExtraData? extraData, Object? error, StackTrace? stackTrace}) => log(message, severity: Severity.warning, extraData: extraData, error: error, stackTrace: stackTrace);
  /// Log a message with severity [Severity.error].
  void error(dynamic message, {PinelogExtraData? extraData, Object? error, StackTrace? stackTrace}) => log(message, severity: Severity.error, extraData: extraData, error: error, stackTrace: stackTrace);
}
