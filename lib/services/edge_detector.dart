import 'package:edge_detection/edge_detection.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class EdgeDetector {
  Future<String> detect(String direction) async {
    bool isCameraGranted = await Permission.camera.request().isGranted;
    if (!isCameraGranted) {
      isCameraGranted =
          await Permission.camera.request() == PermissionStatus.granted;
    }

    if (!isCameraGranted) {
      return 'Error';
    }

    String imagePath = join((await getApplicationSupportDirectory()).path,
        "${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.jpeg");

    try {
      await EdgeDetection.detectEdge(
        canUseGallery: false,
        imagePath,
        androidScanTitle: 'Scan $direction',
        androidCropTitle: 'Crop $direction',
        androidCropBlackWhiteTitle: 'Black White',
        androidCropReset: 'Reset',
      );

      return imagePath;
    } catch (e) {
      return 'Error';
    }
  }
}
