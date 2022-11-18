import 'package:logger/logger.dart';
import 'package:stack_trace/stack_trace.dart';

mixin Logging {
  Logger get logger => Logger(
        level: Level.debug,
        filter: DevelopmentFilter(),
        printer: SimpleLogPrinter(),
      );
}

class SimpleLogPrinter extends LogPrinter {
  SimpleLogPrinter();

  @override
  List<String> log(LogEvent event) {
    final level = event.level;
    final dynamic message = event.message;
    final prefix = SimplePrinter.levelPrefixes[level]!;
    final emoji = PrettyPrinter.levelEmojis[level]!;

    final trace = Trace.current();
    final classAndMethod =
        trace.frames.length > 3 ? trace.frames[3].member : '';

    return ['[${_getTime()}] $prefix $emoji $classAndMethod - $message'];
  }

  String _getTime() {
    String threeDigits(int n) {
      if (n >= 100) return '$n';
      if (n >= 10) return '0$n';
      return '00$n';
    }

    String twoDigits(int n) {
      if (n >= 10) return '$n';
      return '0$n';
    }

    final now = DateTime.now();
    final h = twoDigits(now.hour);
    final min = twoDigits(now.minute);
    final sec = twoDigits(now.second);
    final ms = threeDigits(now.millisecond);
    return '$h:$min:$sec.$ms';
  }
}
