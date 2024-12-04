import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:homework_planner/common/common.dart';

import 'package:homework_planner/providers/providers.dart';
import 'package:homework_planner/models/models.dart';
import 'package:homework_planner/helpers/helpers.dart';
import 'package:homework_planner/widgets/widgets.dart';

@RoutePage()
class TermsScreen extends ConsumerWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final terms = ref.watch(termsProvider);
    logEvent(AnalyticsEvent.termsShowList);

    return BackgroundScaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('TermsScreen.Title'.tr()),
      ),
      body: terms.isNotEmpty
          ? _buildTermList(context, ref, terms)
          : EmptyPlaceholder(text: 'TermsScreen.NoData'.tr()),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => context.pushRoute(TermDetailRoute()),
      ),
    );
  }

  Widget _buildTermList(BuildContext context, WidgetRef ref, List<Term> terms) {
    return ListView.builder(
      itemCount: terms.length,
      itemBuilder: (context, index) {
        final term = terms[index];

        return DismissibleTile(
          style: DismissibleStyle.deleteItem,
          promptTitle: term.name,
          promptText: 'TermsScreen.DeletePrompt'.tr(),
          onDismissed: (_) => _deleteTerm(ref, term.id),
          child: ListTile(
            leading: Icon(term.type == TermType.study ? Icons.school : Icons.beach_access),
            title: Text(term.name),
            subtitle: Text(DateHelper.formatDateRange(term.start, term.end)),
            onTap: () => context.pushRoute(TermDetailRoute(termId: term.id)),
          ),
        );
      },
    );
  }

  void _deleteTerm(WidgetRef ref, String termId) {
    ref.read(termsProvider.notifier).removeItem(termId);
    logEvent(AnalyticsEvent.termsDeleteItem);
  }
}
