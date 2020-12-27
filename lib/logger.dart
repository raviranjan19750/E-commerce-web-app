import 'package:logger/logger.dart';

class LogBuilder {
  static var _logger;

  static Logger getLogger() {
    if (_logger == null) {
      _logger = Logger(
          level: Level.error,
          printer: PrettyPrinter(
              printEmojis: true,
              colors: true,
              printTime: true,
              methodCount: 3));
    }

    return _logger;
  }
}
