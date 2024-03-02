import 'package:equatable/equatable.dart';

final class Address extends Equatable {

  final String countryCode;
  final String city;
  final String region;
  final String street;
  final String postalCode;

  Address({
    required this.countryCode,
    required this.city,
    required this.region,
    required this.street,
    required this.postalCode
  });

  @override
  List<Object?> get props => [
    countryCode,
    city,
    region,
    street,
    postalCode,
  ];

}