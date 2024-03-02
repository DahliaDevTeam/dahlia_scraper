import 'package:dahlia_scraper/scraper/domain/factory/web_scraper_interface.dart';
import 'package:http/http.dart';

abstract base class HttpWebScraper implements WebScraperInterface {

  final Client httpClient;

  HttpWebScraper(this.httpClient);

}