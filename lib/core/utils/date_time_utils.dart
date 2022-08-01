abstract class DateTimeUtils {
  static DateTime? dateTimeFromString(String dateString) {
    final date = DateTime.parse(dateString);
    return date;
  }
}
