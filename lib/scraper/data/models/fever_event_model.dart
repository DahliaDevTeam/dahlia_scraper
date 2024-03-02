import 'package:dahlia_scraper/core/business_objects/address.dart';
import 'package:dahlia_scraper/core/business_objects/event_organizer.dart';
import 'package:dahlia_scraper/core/business_objects/location.dart';
import 'package:dahlia_scraper/core/business_objects/price.dart';
import 'package:dahlia_scraper/core/utils/utf8_encode.dart';
import 'package:dahlia_scraper/core/value_objects/url.dart';
import 'package:dahlia_scraper/scraper/data/models/event_model.dart';

final class FeverEventModel extends EventModel {

  FeverEventModel({
    required super.name,
    required super.startDate,
    required super.endDate,
    required super.description,
    required super.image,
    required super.organizer,
    required super.price,
    required super.tags,
    required super.location,
    required super.url,
  }) : super(
    isOnline: false,
    isFree: false,
  );

  factory FeverEventModel.fromJson(Map<String, dynamic> json) {
    return FeverEventModel(
      name: utf8Encode(json['name']),
      startDate: DateTime.parse(json['default_session']['starts_at_iso']),
      endDate: DateTime.parse(json['default_session']['ends_at_iso']),
      description: utf8Encode(json['description']),
      image: Url(json['cover_image']),
      organizer: EventOrganizer(
        uid: json['partner']['id'].toString(),
        name: json['partner']['name'],
        followers: 0,
        events: 0
      ),
      price: Price(
        value: (json['price_info']['amount'] as num).toDouble(),
        currency: json['price_info']['currency']
      ),
      tags: [
        json['category']
      ],
      location: Location(
        name: json['place']['name'],
        address: Address(
          countryCode: utf8Encode(json['place']['city']['country']),
          city: utf8Encode(json['place']['city']['name']),
          region: '',
          street: utf8Encode((json['place']['address'] as String).split(", ").first),
          postalCode: (json['place']['address'] as String).split(", ").last
        )
      ),
      url: Url(json['default_session']['share_url']),
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
      organizer.uid,
      organizer.name,
      organizer.followers.toString(),
      organizer.events.toString(),
      price?.value.toString() ?? '',
      price?.currency ?? '',
      isFree.toString(),
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
    organizer,
    price,
    isFree,
    tags,
    location,
    url,
    isOnline,
  ];

}