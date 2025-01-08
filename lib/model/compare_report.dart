class CompareReport {
  static const keys = [
    'id',
    'area',
    'size',
    'waterAmount',
    'wateringTime',
    'fertilizer',
    'manure',
    'pesticide',
    'potassium'
  ];

  static List<Map<String, dynamic>> convert(List<dynamic> rawData) {
    return rawData.map((dynamic row) {
      if (row is! List<dynamic>) {
        throw ArgumentError('Each item in rawData must be a List<dynamic>');
      }

      Map<String, dynamic> item = {};
      for (int i = 0; i < keys.length; i++) {
        if (i >= row.length) {
          item[keys[i]] = null; // Handle missing values gracefully
          continue;
        }

        // Convert numeric ID to string
        if (keys[i] == 'id') {
          item[keys[i]] = row[i].toString();
          continue;
        }

        // Handle special formatting for different fields
        switch (keys[i]) {
          case 'size':
          case 'waterAmount':
          case 'wateringTime':
          case 'fertilizer':
          case 'manure':
          case 'pesticide':
          case 'potassium':
            item[keys[i]] = '${row[i]}';
            break;
          default:
            item[keys[i]] = row[i];
        }
      }
      return item;
    }).toList();
  }
}
