import 'dart:convert';

import 'package:dahlia_scraper/scraper/data/models/eventbrite_event_model.dart';
import 'package:html/parser.dart' as parser;
import 'package:dahlia_scraper/scraper/domain/entities/event_entity.dart';
import 'package:dahlia_scraper/scraper/domain/factory/http_web_scraper.dart';

final class EventbriteWebScraper extends HttpWebScraper {

  EventbriteWebScraper(super.httpClient);

  Future<List<String>> getEventIds(int page) async {
    const String baseUrl = 'https://www.eventbrite.fr/d/france/all-events/';

    Uri getUri() {
      return Uri.parse("$baseUrl?page=$page");
    }

    final response = await httpClient.get(
        getUri(),
        headers: {
          "Referer": "https://www.eventbrite.com/d/france/events/",
          "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36"
        }
    );

    final html = parser.parse(response.body);

    final list = html
        .querySelectorAll('script[type="application/ld+json"]');
    final eventsIds = list
      .sublist(0, list.length-1)
      .map((e) => jsonDecode(e.text))
      .map((e) => (e['url'] as String).split("-").last)
      .toList();

    return eventsIds;
  }

  Future<List<EventbriteEventModel>> getEvents(List<String> ids) async {

    Uri getUri() {
      return Uri.parse(
        "https://www.eventbrite.fr/api/v3/destination/events/?event_ids=${ids.join(',')}&page_size=20&expand=event_sales_status,image,primary_venue,primary_organizer,"
      );
    }

    final res = await httpClient.get(getUri());

    final json = jsonDecode(res.body) as Map<String, dynamic>;

    return (json['events'] as List<dynamic>? ?? [])
      .map((e) => EventbriteEventModel.fromJson(e))
      .toList();
  }

  @override
  Future<List<EventEntity>> scrape() async {

    int page = 1;
    final List<EventEntity> result = [];

    while (true) {
      print("Fetching page $page");
      final ids = await getEventIds(page);
      final res = await getEvents(ids);
      result.addAll(res);
      ids.clear();
      if (res.isEmpty) return result;
      res.clear();
      page++;
    }


  }

}