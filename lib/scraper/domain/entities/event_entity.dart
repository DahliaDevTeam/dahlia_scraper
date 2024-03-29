import 'package:dahlia_scraper/core/business_objects/event_organizer.dart';
import 'package:dahlia_scraper/core/business_objects/location.dart';
import 'package:dahlia_scraper/core/business_objects/price.dart';
import 'package:dahlia_scraper/core/value_objects/url.dart';
import 'package:equatable/equatable.dart';

abstract base class EventEntity extends Equatable {

  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final String description;
  final Url? image;
  final EventOrganizer organizer;
  final Price? price;
  final bool isFree;
  final List<String> tags;
  final Location location;
  final Url url;
  final bool isOnline;

  EventEntity({
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.image,
    required this.organizer,
    required this.price,
    required this.isFree,
    required this.tags,
    required this.location,
    required this.url,
    required this.isOnline,
  });

  List<String> toCsvRow();

}