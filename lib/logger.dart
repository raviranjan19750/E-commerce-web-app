import 'package:logger/logger.dart';

class LogBuilder {
  static var _logger;

  static Logger getLogger() {
    if (_logger == null) {
      _logger = Logger(
        printer: SimplePrinter(colors: true)
      );
    }

    return _logger;
  }
}