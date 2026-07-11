import 'dart:async';
import 'dart:typed_data';

import '../network/network_constants.dart';

class PacketFramer {
  final List<int> _buffer = [];

  final _controller = StreamController<Uint8List>.broadcast();

  Stream<Uint8List> get packets => _controller.stream;

  /// Feed raw socket bytes
  void add(Uint8List chunk) {
    _buffer.addAll(chunk);

    while (true) {
      if (_buffer.length < 4) {
        return;
      }

      final length =
      (_buffer[0] << 24) |
      (_buffer[1] << 16) |
      (_buffer[2] << 8) |
      _buffer[3];

      if (_buffer.length < length + 4) {
        return;
      }

      final packet = Uint8List.fromList(
        _buffer.sublist(4, 4 + length),
      );

      _buffer.removeRange(0, length + 4);

      _controller.add(packet);
    }
  }

  /// Add 4-byte length header
  static Uint8List frame(
      Uint8List payload,
      ) {
    final output = Uint8List(
      payload.length + 4,
    );

    final length = payload.length;

    if(length > NetworkConstants.maxPacketSize){
      throw Exception("Packet too large");
    }

    output[0] = (length >> 24) & 0xff;
    output[1] = (length >> 16) & 0xff;
    output[2] = (length >> 8) & 0xff;
    output[3] = length & 0xff;

    output.setRange(
      4,
      output.length,
      payload,
    );

    return output;
  }

  Future<void> dispose() async {
    await _controller.close();
  }
}