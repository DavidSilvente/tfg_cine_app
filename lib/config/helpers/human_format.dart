import 'package:intl/intl.dart';


class HumanFormats {
  static String number(double number, [int decimals = 0]){

    final formatterNumber = NumberFormat.compactCurrency(
      decimalDigits: decimals,
      symbol:'',
      locale: 'en'
    ).format(number);

    return formatterNumber;

  }

  static String shortDate( DateTime date) {
    final format = DateFormat.yMMMEd('es');
    return format.format(date);
  }

  static String humanReadbleNumber( double number ) {
    
    final formatterNumber = NumberFormat.compactCurrency(
      decimalDigits: 0,
      symbol: '',
    ).format( number );

    return formatterNumber;
  }

}