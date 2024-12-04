import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:homework_planner/common/common.dart';
import 'package:homework_planner/widgets/widgets.dart';

@RoutePage()
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BackgroundScaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('ProfileScreen.Title'.tr()),
      ),
      body: ListView(
        children: [
          const AccountSection(),
          const Divider(),
          _buildSubjects(context, ref),
          _buildTeachers(context, ref),
          _buildTerms(context, ref),
          _buildSettings(context),
          _buildAbout(context),
        ],
      ),
    );
  }

  Widget _buildSubjects(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: const Icon(Icons.science_outlined),
      title: Text('ProfileScreen.Subjects'.tr()),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => context.pushRoute(const SubjectsRoute()),
    );
  }

  Widget _buildTeachers(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: const Icon(Icons.people_outline),
      title: Text('ProfileScreen.Teachers'.tr()),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => context.pushRoute(const TeachersRoute()),
    );
  }

  Widget _buildTerms(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: const Icon(Icons.date_range_outlined),
      title: Text('ProfileScreen.Terms'.tr()),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => context.pushRoute(const TermsRoute()),
    );
  }

  Widget _buildSettings(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.settings_outlined),
      title: Text('ProfileScreen.Settings'.tr()),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => context.pushRoute(const SettingsRoute()),
    );
  }

  Widget _buildAbout(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.help_outline),
      title: Text('ProfileScreen.About'.tr()),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => context.pushRoute(const HelpRoute()),
    );
  }
}
