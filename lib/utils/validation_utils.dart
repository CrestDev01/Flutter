extension StrExt on String? {
  //Check string is null or empty
  bool isNullEmptyString() {
    return (this == null || this!.trim().isEmpty);
  }

  //Return string
  String returnString({bool showDash = false}) {
    return isNullEmptyString()
        ? showDash
            ? "-"
            : ""
        : this!;
  }

  //Validate E-mail
  bool validateEmail() {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    return (!regex.hasMatch(this!.trim())) ? false : true;
  }

  //Validate postal code
  bool validatePostal() {
    Pattern pattern = r'^\d{5}$';
    RegExp regex = RegExp(pattern.toString());
    return (!regex.hasMatch(this!.trim())) ? true : false;
  }

  //Validate postal code
  bool validateZipCode() {
    Pattern pattern = r'^\d{5}(?:[-\s]\d{4})?$';
    RegExp regex = RegExp(pattern.toString());
    return (!regex.hasMatch(this!.trim())) ? true : false;
  }

  //Validate phone number
  bool validatePhoneNumber() {
    Pattern pattern = r'/^\(?(\d{3})\)?[- ]?(\d{3})[- ]?(\d{4})$/';
    RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(this!.trim())) {
      return true;
    } else {
      return false;
    }
  }

  //Compare string
  bool compareString({required String text}) {
    return this?.toLowerCase() == text.toLowerCase();
  }

  //Check length
  bool checkLength({int count = 6}) {
    return this!.length >= count;
  }

  //Sub string
  String getSubString({int startIndex = 0, required int endIndex}) {
    return isNullEmptyString() ? "" : this!.substring(startIndex, endIndex);
  }

  //Capitalize string
  String capitalizeString() {
    return isNullEmptyString()
        ? ""
        : "${this![0].toUpperCase()}${this!.getSubString(startIndex: 1, endIndex: this!.length).toLowerCase()}";
  }

  String removeNonCharacterText() {
    return isNullEmptyString() ? "" : this!.replaceAll(RegExp(r'[^\w\s]+'), '');
  }

  //String to int convert
  int? stringToInt() {
    return int.parse(isNullEmptyString() ? '0' : this!);
  }
}

extension DoubleExt on double? {
  //Set decimal point
  String? setDecimalPoint({int length = 2}) {
    return this?.toStringAsFixed(length);
  }

  //Return double
  double? returnDouble() {
    return this ?? 0.0;
  }

  //Check num is null or zero
  bool isNullZero() {
    return (this == null || this == 0.0);
  }

  //Remove 0 after decimal point
  String removeDecimalZeroInDouble() {
    RegExp regex = RegExp(r'([.]*0)(?!.*\d)');

    return this.toString().replaceAll(regex, '');
  }
}

extension NumExt on num? {
  //Return num
  double? returnNumDouble() {
    return this == null ? 0.0 : this?.toDouble();
  }

  //Check num is null or zero
  bool isNullZero() {
    return (this == null || this == 0.0);
  }
}

extension ListExt on List? {
  //Check list is null or empty
  bool isListNullEmpty() {
    return (this == null || this!.isEmpty);
  }

  //Return list
  List? returnList() {
    return isListNullEmpty() ? [] : this;
  }
}

bool isNullEmptyOrFalse(dynamic o) {
  if (o is Map<String, dynamic> || o is List<dynamic>) {
    return o == null || o.length == 0;
  }
  return o == null || false == o || "" == o;
}
