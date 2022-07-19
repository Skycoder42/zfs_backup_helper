const isLocalDebugMode = bool.fromEnvironment('LOCAL_DEBUG');

const zfsBinary = String.fromEnvironment('FAKE_ZFS_BIN', defaultValue: 'zfs');
