import 'dart:convert';

import 'dart:io';

import 'package:flutter/services.dart';

import 'package:googleapis/drive/v3.dart'
as drive;

import 'package:googleapis_auth/auth_io.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:http/http.dart'
as http;

class GoogleDriveService {
  static const _scopes = [
    drive.DriveApi.driveFileScope,
  ];

  static Future<
      AutoRefreshingAuthClient>
  getClient() async {
    /// LOAD JSON
    final jsonString =
    await rootBundle.loadString(
      'assets/client_secret.json',
    );

    final credentials =
    json.decode(jsonString);

    final clientId = ClientId(
      credentials['installed']
      ['client_id'],

      credentials['installed']
      ['client_secret'],
    );

    return await clientViaUserConsent(
      clientId,
      _scopes,
          (url) async {
        final uri = Uri.parse(url);

        if (await canLaunchUrl(uri)) {
          await launchUrl(
            uri,
            mode:
            LaunchMode
                .externalApplication,
          );
        }
      },
    );
  }

  /// UPLOAD BACKUP
  static Future<void> uploadBackup(
      File backupFile,
      ) async {
    final client =
    await getClient();

    final driveApi =
    drive.DriveApi(client);

    final file = drive.File()
      ..name = backupFile
          .uri.pathSegments.last;

    await driveApi.files.create(
      file,

      uploadMedia: drive.Media(
        backupFile.openRead(),
        backupFile.lengthSync(),
      ),
    );
  }
}