import 'package:dahlia_scraper/core/business_objects/address.dart';
import 'package:equatable/equatable.dart';

final class Location extends Equatable {

  final String name;
  final Address address;

  Location({
    required this.name,
    required this.address
  });

  @override
  List<Object?> get props => [
    name,
    address,
  ];

}