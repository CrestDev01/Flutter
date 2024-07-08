import 'dart:developer';

import 'package:flutter/material.dart';

class ConstantUtils {
  static GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();
  static bool isDevEnv = false;
  static bool isLoading = false;
  static String localesPath = "assets/translations";
  // static String userType = UserType.CSP;

  static String authError = "Authentication Error";

  static const double responsiveFactor = 0.3;
  static const double desktopWindowWidth = 400;
  static const double desktopWindowHeight = 850;

  static const List<String> checklistGroups = [
    CheckListGroupType.EXTERIOR,
    CheckListGroupType.INTERIOR,
    CheckListGroupType.UTILITIES,
    CheckListGroupType.SECURITY,
  ];
}

class CheckListGroupType {
  static const String INTERIOR = "Interior";
  static const String EXTERIOR = "Exterior";
  static const String UTILITIES = "Utilities";
  static const String SECURITY = "Security";
}

class IssueManagedByType {
  static const String csp = "csp";
  static const String property = "property_owner";
}

class ContactType {
  static const String primary = "primary";
  static const String secondary = "secondary";
  static const String other = "other";
}

class EventRepeatType {
  static const String none = "none";
  static const String daily = "daily";
  static const String weekly = "weekly";
  static const String monthly = "monthly";
  static const String yearly = "yearly";
}

class AddressType {
  static const String property = "property";
  static const String mailing = "mailing";
  static const String other = "other";
}

class VisitType {
  static const String REGULAR = "regular";
  static const String EMERGENCY = "emergency";
  static const String ADDITIONAL = "additional";
  static const String CONCIERGE = "concierge";
  static const String MOVE_MANAGEMENT = "move_management";
}

class ParameterUtils {
  static const String TOKEN = 'token';
  static const String NAME = "name";
  static const String EMAIL = "email";
  static const String PASSWORD = "pass";
  static const String PASSWORDFULL = "password";
  static const String LANG = "lang";
  static const String CATEGORIES = "categories";
  static const String NOTTIFICATIONS = "notifications";
  static const String PROVIDER = "provider";
  static const String PAGE = "page";
  static const String PERPAGE = "perPage";
  static const String SEARCH = "search";
  static const String CONSUMERKEY = "consumer_key";
  static const String CONSUMERSECRET = "consumer_secret";
}

class ScaffoldUtils {
  static final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey(); // Create a key
}

class RatesTypeConstants {
  static const String HOURLY = "Hourly";
  static const String DAILY = "Daily";
  static const String WEEKLY = "Weekly";
  static const String MONTHLY = "Monthly";
  static const String FIXED = "Fixed";
  static const String OTHER = "Other";
}

class UserType {
  static const String CSP = "CSP";
  static const String CUSTOMER = "Customer";
}

class CheckListType {
  static const String TEXT_FIELD = "text_field";
  static const String COMMON_TYPE = "common_type";
  static const String OPTIONS = "options";
  static const String NUMBER = "number";
  static const String DATE = "date";
  static const String MEDIA = "media";
}

class StringUtils {
  static const String MEDIA = "MEDIA";
  static const String NOTE = "NOTE";
  static const String TEXT_FIELD = "Text Field";
  static const String NUMBER = "Number";
  static const String OPTION = "Option";
  static const String DATE = "Date";
  static const String TIME = "TIME";
}
