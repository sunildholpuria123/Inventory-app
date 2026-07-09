import 'dart:convert';

import 'message_type.dart';

class NetworkMessage {
  final MessageType type;

  /// Base64 encoded payload (optional)
  final String? payload;

  /// Error message (optional)
  final String? message;

  const NetworkMessage({
    required this.type,
    this.payload,
    this.message,
  });

  Map<String, dynamic> toJson() {
    return {
      'type': type.name,
      'payload': payload,
      'message': message,
    };
  }

  factory NetworkMessage.fromJson(
      Map<String, dynamic> json,
      ) {
    return NetworkMessage(
      type: MessageType.values.firstWhere(
            (e) => e.name == json['type'],
      ),
      payload: json['payload'],
      message: json['message'],
    );
  }

  String encode() => jsonEncode(toJson());

  factory NetworkMessage.decode(
      String source,
      ) {
    return NetworkMessage.fromJson(
      jsonDecode(source),
    );
  }
}