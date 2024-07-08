// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeFormats {
  static const String FORMAT_1 = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
  static const String FORMAT_2 = "EEEE, MMM d, yyyy";
  static const String FORMAT_3 = "HH:mm";
  static const String FORMAT_4 = "MMMM d, yyyy";
  static const String FORMAT_5 = "dd/MM/yyyy";
  static const String FORMAT_6 = "yyyy-MM-dd HH:mm:ss";
  static const String FORMAT_7 = "dd/MM/yyyy";
  static const String FORMAT_8 = "yyyy-MM-dd";
  static const String FORMAT_9 = "MMM yyyy";
}

class DateTimeUtils {
  //Parse Date
  static DateTime parseDate(
      {DateTime? dateTime,
      String? date,
      String format = DateTimeFormats.FORMAT_1,
      bool isUtc = false}) {
    return DateFormat(format).parse(date ?? dateTime.toString(), isUtc);
  }

  static String parseDateAndGetFormattedString(
      {DateTime? dateTime,
      String? date,
      String format = DateTimeFormats.FORMAT_1,
      bool isUtc = false}) {
    DateTime newDate =
        DateFormat(format).parse(date ?? dateTime.toString(), isUtc);
    return changeDateFormat(dateTime: newDate, format: format);
  }

  //Convert date to local date
  static DateTime parseDateToLocal({required String date, bool isUtc = false}) {
    return parseDate(dateTime: DateTime.parse(date), isUtc: isUtc).toLocal();
  }

  //Get local date string
  static String getLocalDate(
      {required String date,
      String format = DateTimeFormats.FORMAT_1,
      bool isUtc = false}) {
    return changeDateFormat(
        dateTime: parseDateToLocal(date: date, isUtc: isUtc), format: format);
  }

  //Change datetime format
  static String changeDateFormat(
      {required DateTime dateTime, String format = DateTimeFormats.FORMAT_1}) {
    return DateFormat(format).format(dateTime);
  }

  //Get TimeAgo
  static String getTimeAgoValue({required String createdTime}) {
    final DateTime createDateTime = DateTime.parse(createdTime);
    final int diffInHours = DateTime.now().difference(createDateTime).inHours;

    String timeAgo = '';
    String timeUnit = '';
    int timeValue = 0;

    if (diffInHours < 1) {
      final diffInMinutes = DateTime.now().difference(createDateTime).inMinutes;
      timeValue = diffInMinutes;
      timeUnit = 'm';
    } else if (diffInHours < 24) {
      timeValue = diffInHours;
      timeUnit = 'h';
    } else if (diffInHours >= 24 && diffInHours < 24 * 7) {
      timeValue = (diffInHours / 24).floor();
      timeUnit = 'd';
    } else if (diffInHours >= 24 * 7 && diffInHours < 24 * 30) {
      timeValue = (diffInHours / (24 * 7)).floor();
      timeUnit = 'w';
    } else if (diffInHours >= 24 * 30 && diffInHours < 24 * 12 * 30) {
      timeValue = (diffInHours / (24 * 30)).floor();
      timeUnit = 'mo';
    } else {
      timeValue = (diffInHours / (24 * 365)).floor();
      timeUnit = 'yr';
    }
    timeAgo = timeValue.toString() + '' + timeUnit;
    timeAgo += timeValue > 1 ? '' : '';
    if (timeValue == 0 && timeUnit == "m") {
      timeAgo = "now";
    }
    return timeAgo;
  }

  //Get difference between two dates
  static int daysBetween({required DateTime from, required DateTime to}) {
    from = DateTime(
        from.year, from.month, from.day, from.hour, from.minute, from.second);
    to = DateTime(to.year, to.month, to.day, to.hour, to.minute, to.second);

    return (to.difference(from).inHours / 24).round();
  }

  //Get current dateTime
  static DateTime getCurrentDateTime() {
    return DateTime.now();
  }

  static String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }

  static Future<DateTime?> openDatePicker(
      {required BuildContext context,
      DateTime? selectedDate,
      String? helpText,
      DateTime? startDate}) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate ?? DateTime.now(),
        helpText: helpText,
        //get today's date
        firstDate: startDate ?? DateTime(1900),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(DateTime.now().year + 100));
    return pickedDate;
  }

  static Future<TimeOfDay?> openTimePicker({
    required BuildContext context,
    TimeOfDay? selectedTime,
    bool is24HourFormat = false,
  }) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: (selectedTime ?? TimeOfDay.now()),
      initialEntryMode: TimePickerEntryMode.dial,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(alwaysUse24HourFormat: is24HourFormat),
          child: child!,
        );
      },
    );

    return timeOfDay;
  }

  static Future<DateTime?> openDateAndTimePicker(
      {required BuildContext context,
      TimeOfDay? selectedTime,
      bool is24HourFormat = false,
      DateTime? selectedDate,
      String? helpText,
      DateTime? startDate}) async {
    DateTime? date = await openDatePicker(
      context: context,
      selectedDate: selectedDate,
      startDate: DateTime.now(),
    );
    if (date != null) {
      TimeOfDay? time = await openTimePicker(
        context: context,
        selectedTime: selectedTime,
      );
      if (time != null) {
        return DateTime(
            date.year, date.month, date.day, time.hour, time.minute);
      }
    } else {
      return null;
    }
    return null;
  }

  static bool compareDates(DateTime date1, DateTime date2) {
    if (date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day) {
      // Dates are the same
      return true;
    } else {
      // Dates are different
      return false;
    }
  }

  static String getTimeDifference(DateTime start, DateTime end) {
    // Set the end date to be the same as the start date, but with the end time
    // This ensures that we are calculating the difference between two times on the same day
    // end = DateTime(start.year, start.month, start.day, end.hour, end.minute);

    // Calculate the difference between the two times
    Duration difference = end.difference(start);

    // If the difference is negative, add 24 hours to it to get the correct duration
    if (difference.isNegative) {
      difference += Duration(hours: 24);
    }

    // Calculate the number of days, hours, and minutes between the two times
    int days = difference.inDays;
    int hours = difference.inHours % 24;
    int minutes = difference.inMinutes % 60;

    // Build the time difference string
    String result = "";
    if (days > 0) {
      result += "$days days ";
    }
    if (hours > 0) {
      result += "$hours hours ";
    }
    if (minutes > 0) {
      result += "$minutes minutes";
    }

    // Return the time difference string
    return result.trim();
  }
}

String formatDuration(Duration duration) {
  // Extract hours, minutes, and seconds from the duration
  int hours = duration.inHours;
  int minutes = duration.inMinutes.remainder(60);
  int seconds = duration.inSeconds.remainder(60);

  // Format the duration as "hh:mm:ss"
  String formattedDuration =
      '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

  return formattedDuration;
}

extension TimeOfDayExtension on TimeOfDay {
  int compareTo(TimeOfDay other) {
    if (hour < other.hour) return -1;
    if (hour > other.hour) return 1;
    if (minute < other.minute) return -1;
    if (minute > other.minute) return 1;
    return 0;
  }

  TimeOfDay addHour(int hour) {
    return this.replacing(hour: this.hour + hour, minute: this.minute);
  }
}

extension DateTimeExtension on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}
