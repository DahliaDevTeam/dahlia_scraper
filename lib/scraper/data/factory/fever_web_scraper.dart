import 'dart:convert';
import 'dart:io';

import 'package:dahlia_scraper/scraper/data/models/fever_event_model.dart';
import 'package:dahlia_scraper/scraper/domain/entities/event_entity.dart';
import 'package:dahlia_scraper/scraper/domain/factory/http_web_scraper.dart';

final class FeverWebScraper extends HttpWebScraper {

  FeverWebScraper(super.httpClient);

  final String _eventsUrl = 'https://data-search.apigw.feverup.com/plan';

  String eventDetailsUrl(String id) {
    return "https://beam.feverup.com/api/4.1/plans/$id";
  }

  Future<List<String>> getEventsIds(int page, String cityCode) async {

    final response = await httpClient.post(
      Uri.parse(_eventsUrl),
      headers: {
        "accept": "application/json, text/plain, */*",
        "accept-language": "fr",
        "content-type": "application/json",
        "Referer": "https://feverup.com/",
      },
      body: "{\"query\":\"\",\"locale\":\"fr\",\"city_code\":\"$cityCode\",\"page\":$page,\"page_size\":40}"
    );
    final json = jsonDecode(response.body);

    return (json['results'] as List<dynamic>? ?? [])
      .map<String>((e) => e['id'].toString())
      .toList();
  }

  Future<EventEntity> getEvent(String id) async {
    final response = await httpClient.get(
      Uri.parse(eventDetailsUrl(id)),
      headers: {
        "Accept-Language": "fr-FR"
      }
    );

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    return FeverEventModel.fromJson(json);
  }

  Future<List<EventEntity>> getEvents(List<String> ids) async {
    final List<EventEntity> result = [];
    for (final id in ids) {
      result.add(await getEvent(id));
    }
    return result;
  }

  Future<List<EventEntity>> getCityEvents(String cityCode) async {

    int page = 1;
    final List<EventEntity> result = [];

    while (true) {
      stdout.write("\rFetching page $page");
      final ids = await getEventsIds(page, cityCode);
      final res = await getEvents(ids);
      result.addAll(res);
      ids.clear();
      if (res.isEmpty) return result;
      res.clear();
      page++;
    }

  }

  @override
  Future<List<EventEntity>> scrape() async {
    final List<EventEntity> result = [];
    const cities = [
      'LIG',
      'DGU',
      'PGF',
      'NCE',
      'MRS',
      'CFE',
      'LEH',
      'ORE',
      'RNS',
      'URO',
      'TUF',
      'CMR',
      'BES',
      'LME',
      'ANE',
      'MLH',
      'DIJ',
      'BIQ',
      'EBU',
      'XLE',
      'GNB',
      'ETZ',
      'ENC',
      'XVS',
      'LIL',
      'BOD',
      'TLS',
      'NCY',
      'LYS',
      'AJA',
      'FNI',
      'QXB',
      'TLN',
      'AVN',
      'XNA',
      'LRH',
      'SXB',
      'MPL',
      'PAR',
      'NTE',
    ];
    for (final String cityCode in cities) {
      print('');
      print(cityCode);
      print('');
      final cityEvents = await getCityEvents(cityCode);
      result.addAll(cityEvents);
    }
    return result;
  }

}