import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:homework_planner/common/common.dart';
import 'package:homework_planner/helpers/helpers.dart';
import 'package:homework_planner/models/models.dart';
import 'package:homework_planner/providers/providers.dart';

class AccountSection extends ConsumerStatefulWidget {
  const AccountSection({super.key});

  @override
  ConsumerState<AccountSection> createState() => _AccountSectionState();
}

class _AccountSectionState extends ConsumerState<AccountSection> {
  final tooltipKey = GlobalKey<TooltipState>();

  @override
  Widget build(BuildContext context) {
    final account = ref.watch(authProvider);

    return Column(
      children: [
        FormLayout.defaultSpacer,
        CircleAvatar(
          radius: 32,
          foregroundImage: account.photoUrl.isNotEmpty ? NetworkImage(account.photoUrl) : null,
          child: const Icon(Icons.person, size: 32),
        ),
        FormLayout.defaultSpacer,
        account.userId.isNotEmpty
            ? _buildAccountInfo(account)
            : TextButton(
                onPressed: () => _signInHandler(context),
                child: Text('ProfileScreen.SignInButton'.tr()),
              ),
        FormLayout.defaultSpacer,
      ],
    );
  }

  Widget _buildAccountInfo(Account account) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Tooltip(
        key: tooltipKey,
        message: account.email,
        triggerMode: TooltipTriggerMode.tap,
        child: _buildWelcomeText(account.email, account.displayName),
      ),
    );
  }

  Widget _buildWelcomeText(String email, String displayName) {
    return Text(
      'ProfileScreen.WelcomeText'.tr(
        args: [displayName.isNotEmpty ? displayName : email],
      ),
      style: Theme.of(context).textTheme.titleMedium,
    );
  }

  void _signInHandler(BuildContext context) async {
    try {
      await authHelper.signIn();
      await remoteRepository.sync();
      logEvent(AnalyticsEvent.userSignIn);
    } on AuthException {
      showSnackBar(SnackBarStyle.error, 'ProfileScreen.AuthError'.tr());
    }
  }
}
