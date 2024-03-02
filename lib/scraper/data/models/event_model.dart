import 'package:dahlia_scraper/scraper/domain/entities/event_entity.dart';

abstract base class EventModel extends EventEntity {

  EventModel({
    required super.name,
    required super.startDate,
    required super.endDate,
    required super.description,
    required super.image,
    required super.organizer,
    required super.price,
    required super.isFree,
    required super.tags,
    required super.location,
    required super.url,
    required super.isOnline,
  });

}