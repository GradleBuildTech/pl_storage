import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'pl_storage_platform_interface.dart';

/// An implementation of [PlStoragePlatform] that uses method channels.
class MethodChannelPlStorage extends PlStoragePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('pl_storage');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
