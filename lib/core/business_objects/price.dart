import 'package:equatable/equatable.dart';

final class Price extends Equatable {

  final int value;
  final String currency;

  const Price({
    required this.value,
    required this.currency
  });

  @override
  List<Object?> get props => [
    value,
    currency,
  ];

}