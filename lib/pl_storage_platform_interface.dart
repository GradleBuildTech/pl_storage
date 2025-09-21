import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'pl_storage_method_channel.dart';

abstract class PlStoragePlatform extends PlatformInterface {
  /// Constructs a PlStoragePlatform.
  PlStoragePlatform() : super(token: _token);

  static final Object _token = Object();

  static PlStoragePlatform _instance = MethodChannelPlStorage();

  /// The default instance of [PlStoragePlatform] to use.
  ///
  /// Defaults to [MethodChannelPlStorage].
  static PlStoragePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PlStoragePlatform] when
  /// they register themselves.
  static set instance(PlStoragePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
