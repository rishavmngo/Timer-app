import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:timer_app/riverpod/tags.dart';
import 'package:timer_app/riverpod/tagsList.dart';
import 'package:timer_app/riverpod/timer.dart';
import 'package:timer_app/utils/unset_tag.dart';
import 'package:timer_app/widgets/settings.dart';
import 'package:timer_app/widgets/tag_item.dart';

class TimerTag extends ConsumerWidget {
  const TimerTag({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int id = ref.watch(currentTagProvider);
    bool isRunning = ref.watch(timerProvider)?.isRunning ?? false;
    final tagAsync = ref.watch(tagsListProvider);

    return tagAsync.when(
      data: (tags) {
        final tag =
            tags.firstWhere((tag) => tag.id == id, orElse: () => unsetTag);
        return SizedBox(
          height: 40,
          child: TagItem(
            name: tag.name,
            color: tag.color,
            textColor: Colors.white70,
            onPressed: () {
              //ref.read(tagsListProvider.notifier).refreshTags();
              if (!isRunning) {
                showBarModalBottomSheet(
                    context: context,
                    expand: false,
                    builder: (context) => const Settings());
              }
            },
          ),
        );
      },
      error: (error, stack) => Center(child: Text('Error: $error')),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
