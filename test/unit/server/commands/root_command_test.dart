import 'dart:async';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:dart_test_tools/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:zfs_backup_helper/src/common/managed_process.dart';
import 'package:zfs_backup_helper/src/server/commands/executable_info.dart';
import 'package:zfs_backup_helper/src/server/commands/root_command.dart';
import 'package:zfs_backup_helper/src/server/ffi/libc_interop.dart';

class MockArgResults extends Mock implements ArgResults {}

class MockManagedProcess extends Mock implements ManagedProcess {}

class MockLibcInterop extends Mock implements LibcInterop {}

class MockExecutableInfo extends Mock implements ExecutableInfo {}

class MockCommand extends Mock implements Command<Stream<List<int>>> {}

class MockRootCommand extends Mock implements RootCommand {}

class SutRootCommand extends RootCommand {
  final mock = MockRootCommand();

  SutRootCommand(
    super.managedProcess,
    super._libcInterop,
    super._executableInfo,
  );

  @override
  String get name => mock.name;

  @override
  String get description => mock.description;

  @override
  Command<Stream<List<int>>>? get parent => mock.parent;

  @override
  ArgResults? get argResults => mock.argResults;

  @override
  ArgResults? get globalResults => mock.globalResults;

  @override
  FutureOr<Stream<List<int>>>? runAsRoot() => mock.runAsRoot();
}

void main() {
  group('$RootCommand', () {
    final mockManagedProcess = MockManagedProcess();
    final mockLibcInterop = MockLibcInterop();
    final mockExecutableInfo = MockExecutableInfo();
    final mockGlobalArgs = MockArgResults();

    late SutRootCommand sut;

    setUp(() {
      reset(mockManagedProcess);
      reset(mockLibcInterop);
      reset(mockExecutableInfo);
      reset(mockGlobalArgs);

      sut = SutRootCommand(
        mockManagedProcess,
        mockLibcInterop,
        mockExecutableInfo,
      );

      when(() => sut.mock.globalResults).thenReturn(mockGlobalArgs);
    });

    group('run', () {
      test('runs runAsRoot if already the root user', () {
        final data = Stream.value([1, 2, 3]);

        when(() => mockLibcInterop.geteuid()).thenReturn(0);
        when(() => sut.mock.runAsRoot()).thenAnswer((i) => data);

        final result = sut.run();

        verifyInOrder([
          () => sut.mock.globalResults,
          () => mockLibcInterop.geteuid(),
          () => sut.mock.runAsRoot(),
        ]);
        expect(result, same(data));
      });

      test('invokes itself as root if root option is set', () {
        const commandName = 'command';
        const parentName = 'parent';
        const parentOfParentName = 'parentOfParent';
        const globalArgsArguments = ['a', 'b', 'c'];
        const localArgsArguments = ['d', 'e'];
        const executablePath = 'app/program.exe';

        final data = Stream.value([1, 2, 3]);
        final parent = MockCommand();
        final parentOfParent = MockCommand();
        final mockLocalArgs = MockArgResults();

        when(() => sut.mock.parent).thenReturn(parent);
        when(() => parent.parent).thenReturn(parentOfParent);
        when(() => sut.mock.name).thenReturn(commandName);
        when(() => parent.name).thenReturn(parentName);
        when(() => parentOfParent.name).thenReturn(parentOfParentName);
        when(() => mockGlobalArgs.arguments).thenReturn(globalArgsArguments);
        when(() => mockLocalArgs.arguments).thenReturn(localArgsArguments);
        when(() => sut.mock.argResults).thenReturn(mockLocalArgs);
        when(() => mockExecutableInfo.executablePath)
            .thenReturn(executablePath);

        when(() => mockLibcInterop.geteuid()).thenReturn(42);
        when<dynamic>(() => mockGlobalArgs[any()]).thenReturn(true);
        when(() => mockManagedProcess.runRaw(any(), any())).thenStream(data);

        final result = sut.run();

        verifyInOrder<dynamic>([
          () => mockLibcInterop.geteuid(),
          () => mockGlobalArgs['root'],
          () => sut.mock.name,
          () => sut.mock.parent,
          () => parent.name,
          () => parent.parent,
          () => parentOfParent.name,
          () => parentOfParent.parent,
          () => mockGlobalArgs.arguments,
          () => mockLocalArgs.arguments,
          () => mockManagedProcess.runRaw('sudo', [
                executablePath,
                ...globalArgsArguments,
                parentOfParentName,
                parentName,
                commandName,
                ...localArgsArguments,
              ]),
        ]);
        expect(result, same(data));
      });

      test('throws exception if not root and root option not set', () async {
        when(() => mockLibcInterop.geteuid()).thenReturn(42);
        when<dynamic>(() => mockGlobalArgs[any()]).thenReturn(false);
        when(() => sut.mock.name).thenReturn('test-command');

        await expectLater(() => sut.run(), throwsA(isException));

        verifyInOrder<dynamic>([
          () => mockLibcInterop.geteuid(),
          () => mockGlobalArgs['root'],
        ]);
      });
    });
  });
}
