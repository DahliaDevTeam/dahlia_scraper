import 'package:dahlia_scraper/scraper/domain/entities/event_entity.dart';

abstract interface class WebScraperInterface {

  Future<List<EventEntity>> scrape();

}