class SyncRequest {
  final String deviceId;

  final String deviceName;

  final List<String> tables;

  final Map<String, int> statistics;

  final int totalRecords;

  final int estimatedBytes;


  const SyncRequest({
    required this.deviceId,
    required this.deviceName,
    required this.tables,
    required this.statistics,
    required this.totalRecords,
    required this.estimatedBytes,
  });

  Map<String, dynamic> toJson() => {
    "deviceId": deviceId,

    "deviceName": deviceName,

    "tables": tables,
    "statistics": statistics,
    "totalRecords": totalRecords,
    "estimatedBytes": estimatedBytes,
  };

  factory SyncRequest.fromJson(Map<String, dynamic> json) {
    return SyncRequest(
      deviceId: json["deviceId"],

      deviceName: json["deviceName"],

      tables: List<String>.from(json["tables"]),
      statistics: Map<String, int>.from(json["statistics"]),
      totalRecords: json["totalRecords"],
      estimatedBytes: json["estimatedBytes"],
    );
  }
}
