import 'dart:convert';

class SyncPacket {
  final String deviceId;
  final String deviceName;
  final DateTime createdAt;

  final Map<String, dynamic> payload;

  const SyncPacket({
    required this.deviceId,
    required this.deviceName,
    required this.createdAt,
    required this.payload,
  });

  Map<String, dynamic> toJson() {
    return {
      'deviceId': deviceId,
      'deviceName': deviceName,
      'createdAt': createdAt.toIso8601String(),
      'payload': payload,
    };
  }

  factory SyncPacket.fromJson(Map<String, dynamic> json) {
    return SyncPacket(
      deviceId: json['deviceId'],
      deviceName: json['deviceName'],
      createdAt: DateTime.parse(json['createdAt']),
      payload: Map<String, dynamic>.from(json['payload']),
    );
  }

  String encode() => jsonEncode(toJson());

  factory SyncPacket.decode(String source) {
    return SyncPacket.fromJson(
      jsonDecode(source),
    );
  }

}