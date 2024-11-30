import 'package:ambush_app/src/core/settings/const.dart';
import 'package:ambush_app/src/designsystem/constrained_scaffold.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class BackupPage extends StatelessWidget {
  const BackupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedScaffold(
      maxWidth: defaultPageMaxWidth,
      appBar: AppBar(title: const Text("Backup")),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: regularMargin),
        children: [
          ListTile(
            title: const Text("Create Backup"),
            subtitle: const Text("Create a backup of your data"),
            trailing: const Icon(Icons.save),
            onTap: () {},
          ),
          const Divider(indent: regularMargin, endIndent: regularMargin),
          ListTile(
            title: const Text("Restore Backup"),
            subtitle: const Text("Restore a backup of your data"),
            trailing: const Icon(Icons.restore),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
