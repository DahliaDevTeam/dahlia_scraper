import 'package:dahlia_scraper/core/business_objects/address.dart';
import 'package:dahlia_scraper/core/business_objects/location.dart';
import 'package:dahlia_scraper/core/utils/utf8_encode.dart';
import 'package:dahlia_scraper/core/value_objects/url.dart';
import 'package:dahlia_scraper/scraper/data/models/event_model.dart';

final class EventbriteEventModel extends EventModel {

  EventbriteEventModel({
    required super.name,
    required super.startDate,
    required super.endDate,
    required super.description,
    required super.image,
    required super.tags,
    required super.location,
    required super.url,
    required super.isOnline,
  });

  factory EventbriteEventModel.fromJson(Map<String, dynamic> json) {
    final startTime = "${json['start_date']} ${json['start_time']}";
    final endDate = "${json['end_date']} ${json['end_time']}";
    return EventbriteEventModel(
      name: json['name'],
      startDate: DateTime.parse(startTime),
      endDate: DateTime.parse(endDate),
      description: utf8Encode(json['summary'] as String? ?? ''),
      image: json['image'] == null
        ? null
        : Url(json['image']['url']),
      tags: (json['tags'] as List<dynamic>)
        .map<String>((e) => utf8Encode(e['display_name'] as String))
        .toList(),
      location: Location(
        name: utf8Encode(json['primary_venue']['name'] as String),
        address: Address(
          countryCode: json['primary_venue']['address']['country'],
          city: utf8Encode(json['primary_venue']['address']['city'] as String),
          region: utf8Encode(json['primary_venue']['address']['region'] as String),
          street: utf8Encode(json['primary_venue']['address']['localized_address_display'] as String),
          postalCode: json['primary_venue']['address']['postal_code'] ?? ''
        )
      ),
      url: Url(json['url']),
      isOnline: json['is_online_event']
    );
  }

  @override
  List<String> toCsvRow() {
    return [
      name,
      description,
      location.name,
      location.address.countryCode,
      location.address.city,
      location.address.region,
      location.address.postalCode,
      location.address.street,
      url.value,
      startDate.toIso8601String(),
      endDate.toIso8601String(),
      image?.value ?? '',
      tags.join(","),
      isOnline.toString(),
    ];
  }

  @override
  List<Object?> get props => [
    name,
    startDate,
    endDate,
    description,
    image,
    tags,
    location,
    url,
  ];

}