import 'package:dahlia_scraper/core/utils/iterable_extensions.dart';

enum ScrapedSite {
  eventbrite,
  fever;

  static ScrapedSite? fromString(String name) {
    return ScrapedSite
      .values
      .firstWhereOrNull(
        (site) => site.name == name.toLowerCase()
      );
  }

}