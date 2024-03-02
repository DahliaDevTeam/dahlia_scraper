import 'dart:io';

import 'package:csv/csv.dart';
import 'package:dahlia_scraper/csv/csv_service_interface.dart';

final class CsvService implements CsvServiceInterface{

  @override
  void write({
    required String fileName,
    required List<String> header,
    required List<List<dynamic>> data
  }) async {
    final csv = ListToCsvConverter(fieldDelimiter: ';')
      .convert([
        header,
        ...data
      ]);
    final file = File('output/$fileName-${DateTime.now().toIso8601String()}.csv')
      ..createSync(recursive: true);
    file.writeAsStringSync(csv);
  }

}