class AppSettings {
  final bool darkMode;

  final String currency;

  final double taxPercent;

  final String companyName;

  final String companyAddress;

  final String invoicePrefix;

  const AppSettings({
    required this.darkMode,
    required this.currency,
    required this.taxPercent,
    required this.companyName,
    required this.companyAddress,
    required this.invoicePrefix,
  });

  AppSettings copyWith({
    bool? darkMode,
    String? currency,
    double? taxPercent,
    String? companyName,
    String? companyAddress,
    String? invoicePrefix,
  }) {
    return AppSettings(
      darkMode: darkMode ?? this.darkMode,

      currency: currency ?? this.currency,

      taxPercent: taxPercent ?? this.taxPercent,

      companyName: companyName ?? this.companyName,

      companyAddress: companyAddress ?? this.companyAddress,

      invoicePrefix: invoicePrefix ?? this.invoicePrefix,
    );
  }
}
