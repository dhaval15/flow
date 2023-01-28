import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart';

class AppProvider {
  Future<String> get rootPath async {
    if (_rootPath == null) _rootPath = await _getRootPath();
    return _rootPath!;
  }

  String? _rootPath;

  static Future<String> _getRootPath() async {
    if (kIsWeb) return 'data';
    if (Platform.isAndroid) {
      if (await Permission.storage.isGranted ||
          (await Permission.storage.request() == PermissionStatus.granted)) {
        final dir = await getExternalStorageDirectory();
        return join(dir!.parent.parent.parent.parent.path, 'Inbox');
      }
      throw 'You have denied Access';
    } else if (Platform.isLinux) {
      return '/home/dhaval/flow.temp';
    }
    throw 'Platform not supported yet';
  }
}
