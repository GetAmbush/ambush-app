import 'package:flutter/material.dart';

class ConstrainedScaffold extends StatefulWidget {
  final AppBar? appBar;
  final double maxWidth;
  final Widget? body;
  final Widget? floatingActionButton;

  const ConstrainedScaffold({
    super.key,
    required this.appBar,
    required this.maxWidth,
    required this.body,
    this.floatingActionButton,
  });

  @override
  State<ConstrainedScaffold> createState() => _ConstrainedScaffoldState();
}

class _ConstrainedScaffoldState extends State<ConstrainedScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      floatingActionButton: widget.floatingActionButton,
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: widget.maxWidth),
          child: widget.body,
        ),
      ),
    );
  }
}
