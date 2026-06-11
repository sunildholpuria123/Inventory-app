import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

import 'package:googleapis/drive/v3.dart' as drive;
import 'package:googleapis_auth/auth_io.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';

import 'package:url_launcher/url_launcher.dart';


class GoogleDriveService {
  static const _scopes = [
    drive.DriveApi.driveFileScope,
  ];

  /// DESKTOP AUTHENTICATION
  static Future<AutoRefreshingAuthClient>
  getClient() async {

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
            mode: LaunchMode
                .externalApplication,
          );
        }
      },
    );
  }

  /// GOOGLE DRIVE UPLOAD
  static Future<void> uploadBackup(
      File backupFile,
      ) async {

    if (Platform.isWindows ||
        Platform.isLinux ||
        Platform.isMacOS) {

      await _uploadDesktop(
        backupFile,
      );

      return;
    }

    if (Platform.isAndroid ||
        Platform.isIOS) {

      await _uploadMobile(
        backupFile,
      );

      return;
    }

    throw UnsupportedError(
      'Platform not supported',
    );
  }

  /// DESKTOP UPLOAD
  static Future<void>
  _uploadDesktop(
      File backupFile,
      ) async {

    final client =
    await getClient();

    final driveApi =
    drive.DriveApi(client);

    final driveFile =
    drive.File()
      ..name =
          backupFile.uri
              .pathSegments
              .last;

    await driveApi.files.create(
      driveFile,

      uploadMedia:
      drive.Media(
        backupFile.openRead(),
        backupFile.lengthSync(),
      ),
    );
  }

  /// MOBILE UPLOAD
  static Future<void>
  _uploadMobile(
      File backupFile,
      ) async {

    final googleSignIn =
    GoogleSignIn(
      scopes: _scopes,
    );

    final user =
    await googleSignIn.signIn();

    if (user == null) {

      throw Exception(
        'Google Sign-In cancelled',
      );
    }

    final authClient =
    await googleSignIn
        .authenticatedClient();

    if (authClient == null) {

      throw Exception(
        'Authentication failed',
      );
    }

    final driveApi =
    drive.DriveApi(
      authClient,
    );

    final driveFile =
    drive.File()
      ..name =
          backupFile.uri
              .pathSegments
              .last;

    await driveApi.files.create(
      driveFile,

      uploadMedia:
      drive.Media(
        backupFile.openRead(),
        backupFile.lengthSync(),
      ),
    );

    await googleSignIn.signOut();
  }
}