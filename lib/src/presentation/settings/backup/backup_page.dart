import 'package:ambush_app/src/core/di/di.dart';
import 'package:ambush_app/src/core/settings/const.dart';
import 'package:ambush_app/src/designsystem/constrained_scaffold.dart';
import 'package:ambush_app/src/designsystem/show_dialogs.dart';
import 'package:ambush_app/src/presentation/settings/backup/backup_viewmodel.dart';
import 'package:ambush_app/src/presentation/utils/backup/backup_error.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class BackupPage extends StatelessWidget {
  BackupPage({super.key});

  final BackupViewModel _viewModel = getIt();

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
            onTap: () {
              _onBackupCreateClick(context);
            },
          ),
          const Divider(indent: regularMargin, endIndent: regularMargin),
          ListTile(
            title: const Text("Restore Backup"),
            subtitle: const Text("Restore a backup of your data"),
            trailing: const Icon(Icons.restore),
            onTap: () {
              _onBackupRestoreClick(context);
            },
          ),
        ],
      ),
    );
  }

  void _onBackupRestoreClick(BuildContext context) async {
    try {
      await _viewModel.restoreApplicationBackup();

      if(context.mounted) {
        await showOnButtonDialog(
          context,
          "Backup Restored",
          "Backup has been restored",
          "Ok",
        );
      }

    } catch (e) {
      if (context.mounted) {
        _showErrorDialog(
            context, e is BackupError ? e.message : genericErrorMessage);
      }
    }
  }

  void _onBackupCreateClick(BuildContext context) async {
    try {
      await _viewModel.createApplicationBackup();
      if(context.mounted) {
        await showOnButtonDialog(
          context,
          "Backup Created",
          "Backup has been created",
          "Ok",
        );
      }
    } catch (e) {
      if (context.mounted) {
        _showErrorDialog(
            context, e is BackupError ? e.message : genericErrorMessage);
      }
    }
  }

  void _showErrorDialog(BuildContext context, String message) =>
      showOnButtonDialog(context, genericErrorTitle, message, ok);
}
