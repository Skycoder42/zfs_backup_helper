import 'dart:async';

import 'package:meta/meta.dart';

import '../managed_snapshot.dart';

@visibleForTesting
class ManagedSnapshotTransformerSink implements EventSink<String> {
  final String? prefix;
  final EventSink<ManagedSnapshot> sink;

  ManagedSnapshotTransformerSink(this.prefix, this.sink);

  @override
  void add(String event) {
    if (!ManagedSnapshot.isManagedSnapshot(event)) {
      return;
    }

    final snapshot = ManagedSnapshot.parse(event);
    if (!snapshot.hasPrefix(prefix)) {
      return;
    }

    sink.add(snapshot);
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) =>
      sink.addError(error, stackTrace);

  @override
  void close() => sink.close();
}

class ManagedSnapshotTransformer
    implements StreamTransformer<String, ManagedSnapshot> {
  final String? prefix;

  const ManagedSnapshotTransformer(this.prefix);

  @override
  Stream<ManagedSnapshot> bind(Stream<String> stream) =>
      Stream.eventTransformed(
        stream,
        (sink) => ManagedSnapshotTransformerSink(prefix, sink),
      );

  // coverage:ignore-start
  @override
  StreamTransformer<RS, RT> cast<RS, RT>() => StreamTransformer.castFrom(this);
  // coverage:ignore-end
}

extension StringStreamX on Stream<String> {
  Stream<ManagedSnapshot> transformSnapshots(String? prefix) =>
      transform(ManagedSnapshotTransformer(prefix));
}
