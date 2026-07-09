import 'dart:convert';

class SyncDevice {
  final String id;
  final String name;
  final String ip;
  final int port;
  final bool isDesktop;

  const SyncDevice({
    required this.id,
    required this.name,
    required this.ip,
    required this.port,
    required this.isDesktop,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'ip': ip,
    'port': port,
    'isDesktop': isDesktop,
  };

  factory SyncDevice.fromJson(Map<String, dynamic> json) {
    return SyncDevice(
      id: json['id'],
      name: json['name'],
      ip: json['ip'],
      port: json['port'],
      isDesktop: json['isDesktop'],
    );
  }

  String encode() => jsonEncode(toJson());

  factory SyncDevice.decode(String source) =>
      SyncDevice.fromJson(jsonDecode(source));
}
