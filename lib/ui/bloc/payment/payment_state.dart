part of 'payment_bloc.dart';

@immutable
class PaymentState {
  final double amount;
  final String currency;
  final bool targetIsActive;
  final CreditCardCustom creditCard;

  PaymentState({
    this.amount,
    this.currency,
    this.targetIsActive = false,
    this.creditCard
  });

  PaymentState copyWith({
    double amount = 250.55,
    String currency = 'USD',
    bool targetIsActive = false,
    CreditCardCustom creditCard
  }) => PaymentState(
    amount: amount ?? this.amount,
    currency: currency ?? this.currency,
    targetIsActive: targetIsActive ?? this.targetIsActive,
    creditCard: creditCard ?? this.creditCard
  );

  String get amuntString => '${(this.amount * 100).floor()}';
}
