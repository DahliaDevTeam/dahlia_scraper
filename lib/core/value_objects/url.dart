import 'package:dahlia_scraper/core/regexp/url_regexp.dart';
import 'package:dahlia_scraper/core/value_objects/value_object.dart';

final class Url extends ValueObject<String> {

  Url(super.value) {
    if (!value.isValidUrl) throw ArgumentError('not a valid url');
  }

  Uri get uri => Uri.parse(value);

}