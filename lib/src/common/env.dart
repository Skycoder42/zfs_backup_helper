const isLocalDebugMode = bool.fromEnvironment('LOCAL_DEBUG');

const zshBinary = String.fromEnvironment('FAKE_ZSH_BIN', defaultValue: 'zsh');
