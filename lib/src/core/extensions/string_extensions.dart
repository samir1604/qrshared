extension StringExtensions on String {
  String toCardFormat() {
    final clean = replaceAll(RegExp('[^0-9]'), '');

    var formated = clean.replaceAllMapped(
      RegExp('.{4}'),
      (match) => '${match.group(0)}-',
    );

    if (formated.endsWith('-')) {
      formated = formated.substring(0, formated.length - 1);
    }

    return formated;
  }
}
