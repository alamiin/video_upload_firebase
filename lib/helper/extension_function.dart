
import 'dart:math';
import 'package:intl/intl.dart';

extension FileFormatter on String {
  String readableFileSize() {
    num bytes = num.parse(this);
    const suffixes = ["B", "kB", "MB", "GB", "TB"];
    if (bytes == 0) return '0${suffixes[0]}';
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(2)) + suffixes[i];
  }
}

extension DateFormatter on String {
  String readableDate({bool base1024 = true}) {
    DateTime dateTime = DateTime.parse(this).toLocal();
    return DateFormat('dd-MM-yyyy hh:mm a').format(dateTime);
  }
}

