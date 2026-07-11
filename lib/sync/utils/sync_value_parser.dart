class SyncValueParser {
  const SyncValueParser._();

  static int toInt(dynamic value) {
    if (value == null) return 0;

    if (value is int) return value;

    if (value is num) return value.toInt();

    return int.tryParse(value.toString()) ?? 0;
  }

  static double toDouble(dynamic value) {
    if (value == null) return 0.0;

    if (value is double) return value;

    if (value is num) return value.toDouble();

    return double.tryParse(value.toString()) ?? 0.0;
  }

  static bool toBool(dynamic value) {
    if (value == null) return false;

    if (value is bool) return value;

    if (value is num) return value != 0;

    return value.toString().toLowerCase() == "true";
  }

  static String toStringValue(dynamic value) {
    return value?.toString() ?? "";
  }

  static String? toNullableString(dynamic value) {
    if (value == null) return null;

    return value.toString();
  }

  static DateTime toDateTime(dynamic value) {
    if (value == null) {
      return DateTime.now();
    }

    if (value is DateTime) {
      return value;
    }

    return DateTime.parse(value.toString());
  }

  static DateTime? toNullableDateTime(dynamic value) {
    if (value == null) {
      return null;
    }

    if (value is DateTime) {
      return value;
    }

    return DateTime.tryParse(value.toString());
  }
}