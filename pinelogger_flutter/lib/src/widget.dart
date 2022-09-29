import 'package:flutter/widgets.dart';
import 'package:pinelogger/pinelogger.dart';

class PineloggerContext extends InheritedWidget {
  final Pinelogger logger;

  const PineloggerContext({
    Key? key,
    required Widget child,
    required this.logger,
  }) : super(key: key, child: child);

  static Pinelogger of(BuildContext context) {
    final inherited = context.dependOnInheritedWidgetOfExactType<PineloggerContext>();
    return inherited!.logger;
  }

  @override
  bool updateShouldNotify(PineloggerContext oldWidget) {
    return logger != oldWidget.logger;
  }
}