

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StreamClockWidget extends StatefulWidget {
  const StreamClockWidget({super.key});

  @override
  _StreamClockWidgetState createState() => _StreamClockWidgetState();
}

class _StreamClockWidgetState extends State<StreamClockWidget> {
  late final Stream<String> _clockStream;

  @override
  void initState() {
    super.initState();
    _clockStream = _createClockStream();
  }

  Stream<String> _createClockStream() async* {
    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      yield _formatDateTime(DateTime.now());
    }
  }

  static String _formatDateTime(DateTime dateTime) {
    return DateFormat('HH:mm:ss').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: _clockStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          return Text(
            snapshot.data ?? '',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
