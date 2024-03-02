import 'dart:convert';
import 'dart:io';

import 'package:dahlia_scraper/csv/csv_service.dart';
import 'package:dahlia_scraper/scraper/data/factory/eventbrite_web_scraper.dart';
import 'package:dahlia_scraper/scraper/domain/enums/scraped_sites_enum.dart';
import 'package:dahlia_scraper/scraper/domain/factory/web_scraper_factory.dart';
import 'package:http/http.dart';

void main(List<String> arguments) async {
  final csvService = CsvService();
  final client = Client();
  final factory = ScraperFactory()
    ..register(site: ScrapedSite.eventbrite, scraper: EventbriteWebScraper(client));

  print("Choose your events provider");
  print(ScrapedSite.values.map((e) => "- ${e.name}"));

  ScrapedSite? selectedSite;
  while(selectedSite == null) {
    selectedSite = ScrapedSite.fromString(
      stdin.readLineSync(encoding: utf8) ?? ''
    );
  }

  final scraper = factory.get(selectedSite);
  if (scraper == null) {
    print("No scraper implementation for ${selectedSite.name}");
    exit(1);
  }

  final res = await scraper.scrape();

  const header = [
    'Name',
    'Description',
    'Location name',
    'Country',
    'City',
    'Region',
    'Postal code',
    'Street',
    'Url',
    'Start',
    'End',
    'Image',
    'Organizer ID',
    'Organizer Name',
    'Organizer followers',
    'Organizer events',
    'Price value',
    'Price currency',
    'Free',
    'Tags',
    'Online',
  ];

  print("writing csv file...");
  csvService.write(
    fileName: selectedSite.name,
    header: header,
    data: res
      .map((e) => e.toCsvRow())
      .toList()
  );

}