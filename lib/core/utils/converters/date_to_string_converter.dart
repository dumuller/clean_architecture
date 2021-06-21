class DateToStringConverter {
  static String convert(DateTime date) {
    var dateSpplitted = date.toString().split(' ');
    return dateSpplitted.first;
  }
}