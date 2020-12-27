import 'package:timeago/timeago.dart' as timeago;

class DateFormatting {
  static String dateFormat(String date) {
    try {
      final newStr = date.substring(0, 10) + ' ' + date.substring(11, 23);
      DateTime dt = DateTime.parse(newStr);
      final ago = DateTime.now().difference(dt);
      final newDate = DateTime.now().subtract(ago);
      return timeago.format(newDate);
    } catch (_) {
      return "";
    }
  }
}
