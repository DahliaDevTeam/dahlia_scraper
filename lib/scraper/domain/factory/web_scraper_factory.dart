import 'package:dahlia_scraper/scraper/domain/enums/scraped_sites_enum.dart';
import 'package:dahlia_scraper/scraper/domain/factory/web_scraper_interface.dart';

final class ScraperFactory {

  final Map<ScrapedSite, WebScraperInterface> record = {};

  ScraperFactory();

  void register({
    required ScrapedSite site,
    required WebScraperInterface scraper,
  }) {
    record[site] = scraper;
  }

  WebScraperInterface? get(ScrapedSite site) {
    return record[site];
  }

}