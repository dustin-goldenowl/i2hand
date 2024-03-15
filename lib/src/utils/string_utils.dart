import 'dart:math';

class StringUtils {
  static bool isNullOrEmpty(String? value) => value == null || value.isEmpty;

  static String createGenerateRandomText(
      {required int length, bool hasNumber = true}) {
    var r = Random();
    const chars =
        "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890";
    const charsWithOutNumbers =
        "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz";
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => chars.codeUnitAt(
          r.nextInt(hasNumber ? chars.length : charsWithOutNumbers.length),
        ),
      ),
    );
  }

  static String createGenerateRandomOrderNumber({required int length}) {
    var r = Random();
    const numberChars = "1234567890";
    return "#${String.fromCharCodes(Iterable.generate(length, (_) => numberChars.codeUnitAt(
          r.nextInt(numberChars.length),
        )))}";
  }

  static String getAddressText({required String rawAddress}) {
    if (!rawAddress.contains('[')) return rawAddress;
    // Raw address: [address number, street], [city], [state], [country]
    // Remove '[' and ']'
    final addressRawText = rawAddress.replaceAll(RegExp(r'\[|\]'), '');
    final addressListData = addressRawText.split(',');

    // Remove empty field
    final removeEmptyAddressDataText =
        addressListData.where((element) => element.trim().isNotEmpty).toList();
    return removeEmptyAddressDataText.join(',');
  }

  static String getProvinceText({required String rawAddress}) {
    if (!rawAddress.contains('[')) return rawAddress;
    // Raw address: [address number, street], [city], [state], [country]

    final addressListRawData = rawAddress.split(',');
    final addressListData = addressListRawData
        .map((e) => e.replaceAll(RegExp(r'\[|\]'), '').trim())
        .toList();

    // Remove [address number, street] => Address: [city, state, country]
    addressListData.sublist(1);

    final removeEmptyAddressDataText =
        addressListData.where((element) => element.trim().isNotEmpty).toList();
    // Remove [country] in list address
    if (removeEmptyAddressDataText.length > 1) {
      removeEmptyAddressDataText.remove(removeEmptyAddressDataText.last);
    }
    return removeEmptyAddressDataText.join(', ');
  }
}
