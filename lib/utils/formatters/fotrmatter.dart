import 'package:intl/intl.dart';

class TFormatters {
  static String formatDateTime(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat("dd-MM-yyyy").format(date);
  }

  static String formatCurrency(double amount) {
    return NumberFormat.currency(locale: "en_US", symbol: "\$").format(amount);
  }

  static String formatNumber(String phoneNumber) {
    if (phoneNumber.length == 10) {
      return phoneNumber
          .replaceRange(0, 3, '(${phoneNumber.substring(0, 3)}) ')
          .replaceRange(9, 10, '-${phoneNumber.substring(9, 10)}');
    } else if (phoneNumber.length == 11) {
      return phoneNumber
          .replaceRange(0, 3, '(${phoneNumber.substring(0, 3)}) ')
          .replaceRange(9, 10, '-${phoneNumber.substring(9, 10)}');
    }
    return phoneNumber;
  }

  static String internationalPhoneNumber(String phoneNumber) {
    var digitsOnly = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
    String countryCode = '+${digitsOnly.substring(0, 2)}';
    digitsOnly = digitsOnly.substring(2);

    final formattedNumber = StringBuffer();
    formattedNumber.write("$countryCode ");
    int i = 0;
    while (i < digitsOnly.length) {
      int groupLength = 2;
      if (i == 0 && countryCode == '+1') {
        groupLength = 3;
      }
      int end = i + groupLength;
      formattedNumber.write('');

      i = end;
    }
    return formattedNumber.toString();
  }
}
