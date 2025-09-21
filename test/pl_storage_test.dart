import 'package:flutter_test/flutter_test.dart';
import 'package:pl_storage/pl_storage.dart';
import 'package:pl_storage/pl_storage_platform_interface.dart';
import 'package:pl_storage/pl_storage_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockPlStoragePlatform
    with MockPlatformInterfaceMixin
    implements PlStoragePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final PlStoragePlatform initialPlatform = PlStoragePlatform.instance;

  test('$MethodChannelPlStorage is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelPlStorage>());
  });

  test('getPlatformVersion', () async {
    PlStorage plStoragePlugin = PlStorage();
    MockPlStoragePlatform fakePlatform = MockPlStoragePlatform();
    PlStoragePlatform.instance = fakePlatform;

    expect(await plStoragePlugin.getPlatformVersion(), '42');
  });
}
