abstract interface class CsvServiceInterface {

  void write({
    required String fileName,
    required List<String> header,
    required List<List<dynamic>> data,
  });

}