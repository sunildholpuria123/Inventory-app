class TrustedDevice {
  final String deviceId;
  final String deviceName;

  const TrustedDevice({
    required this.deviceId,
    required this.deviceName,
  });

  Map<String, dynamic> toJson() => {
    "deviceId": deviceId,
    "deviceName": deviceName,
  };

  factory TrustedDevice.fromJson(
      Map<String, dynamic> json) {
    return TrustedDevice(
      deviceId: json["deviceId"],
      deviceName: json["deviceName"],
    );
  }
}