import 'package:permission_handler/permission_handler.dart';

Future<bool> requestStoragePermission() async {
  final status = await Permission.storage.request();
  return status == PermissionStatus.granted;
}
