import 'dart:convert';
import 'dart:io';

import 'dart:typed_data';

import '../model/sync_packet.dart';

class SyncCodec {
  const SyncCodec();

  /// SyncPacket -> Compressed Bytes
  Uint8List encode(SyncPacket packet) {
    final json = jsonEncode(packet.toJson());

    final bytes = utf8.encode(json);

    final compressed = gzip.encode(bytes);

    return Uint8List.fromList(compressed);
  }

  /// Compressed Bytes -> SyncPacket
  SyncPacket decode(Uint8List bytes) {
    final decompressed = gzip.decode(bytes);

    final json = utf8.decode(decompressed);

    return SyncPacket.fromJson(Map<String, dynamic>.from(jsonDecode(json)));
  }

  String encodeBase64(SyncPacket packet) {
    return base64Encode(encode(packet));
  }

  SyncPacket decodeBase64(String payload) {
    return decode(base64Decode(payload));
  }
}
