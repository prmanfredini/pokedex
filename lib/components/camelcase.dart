extension StringExtension on String {
  String toCamelCase() {
    return replaceAll(RegExp(' +'), ' ')
        .split(' ')
        .map((str) => str.capital())
        .join(' ');
  }

  String capital() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
}
