import 'package:intl/intl.dart'; // Add intl to pubspec if needed for date formatting

class Helpers {
  /// Format a date from 'yyyy-MM-dd' to a more readable format like 'MMM dd, yyyy'.
  static String formatDate(String dateStr) {
    if (dateStr.isEmpty) return 'N/A';
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('MMM dd, yyyy').format(date);
    } catch (_) {
      return dateStr;
    }
  }

  /// Format a rating (e.g., from double to a string with one decimal, or "N/A" if no rating).
  static String formatRating(double? rating) {
    if (rating == null || rating == 0.0) return 'N/A';
    return rating.toStringAsFixed(1);
  }

  /// Shorten an overview or text to a given length, adding ellipses if longer.
  static String shortenText(String text, [int maxLength = 100]) {
    if (text.length <= maxLength) return text;
    return text.substring(0, maxLength) + '...';
  }
}
