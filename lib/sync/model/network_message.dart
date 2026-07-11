import 'dart:convert';

import 'message_type.dart';

class NetworkMessage {
  final MessageType type;

  /// Base64 encoded payload (optional)
  final String? payload;

  /// Error message (optional)
  final String? message;

  const NetworkMessage({required this.type, this.payload, this.message});

  Map<String, dynamic> toJson() {
    return {'type': type.name, 'payload': payload, 'message': message};
  }

  factory NetworkMessage.fromJson(Map<String, dynamic> json) {
    final type = MessageType.values.where((e) => e.name == json['type']);

    return NetworkMessage(
      type: type.isEmpty ? MessageType.error : type.first,
      payload: json['payload'] as String?,
      message: json['message'] as String?,
    );
  }

  String encode() => jsonEncode(toJson());

  factory NetworkMessage.decode(String source) {
    return NetworkMessage.fromJson(jsonDecode(source));
  }
}
