import 'package:meta/meta.dart';

class CreditCardCustom {
  final String cardNumberHidden;
  final String cardNumber;
  final String brand;
  final String cvv;
  final String expiracyDate;
  final String cardHolderName;

  CreditCardCustom({
    @required this.cardNumberHidden,
    @required this.cardNumber,
    @required this.brand,
    @required this.cvv,
    @required this.expiracyDate,
    @required this.cardHolderName
  });
}