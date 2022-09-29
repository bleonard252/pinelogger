import 'package:flutter/widgets.dart';
import 'package:pinelogger/pinelogger.dart';

import 'widget.dart';

extension PineloggerFlutter on BuildContext {
  Pinelogger get logger => PineloggerContext.of(this).child(widget.runtimeType.toString());

  logVerbose(dynamic message, {PinelogExtraData? extraData, Object? error, StackTrace? stackTrace}) {
    logger.verbose(message, extraData: extraData, error: error, stackTrace: stackTrace);
  }
  logDebug(dynamic message, {PinelogExtraData? extraData, Object? error, StackTrace? stackTrace}) {
    logger.debug(message, extraData: extraData, error: error, stackTrace: stackTrace);
  }
  logInfo(dynamic message, {PinelogExtraData? extraData, Object? error, StackTrace? stackTrace}) {
    logger.info(message, extraData: extraData, error: error, stackTrace: stackTrace);
  }
  logWarning(dynamic message, {PinelogExtraData? extraData, Object? error, StackTrace? stackTrace}) {
    logger.warning(message, extraData: extraData, error: error, stackTrace: stackTrace);
  }
  logError(dynamic message, {PinelogExtraData? extraData, Object? error, StackTrace? stackTrace}) {
    logger.error(message, extraData: extraData, error: error, stackTrace: stackTrace);
  }
}