// ignore_for_file: do_not_use_environment

const isLocalDebugMode = bool.fromEnvironment('LOCAL_DEBUG');

const zfsBinary = String.fromEnvironment('FAKE_ZFS_BIN', defaultValue: 'zfs');
