import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:timer_app/riverpod/tags.dart';
import 'package:timer_app/riverpod/timer.dart';
import 'package:timer_app/utils/tag_color.dart';
import 'package:timer_app/utils/tagsData.dart';
import 'package:timer_app/widgets/settings.dart';
import 'package:timer_app/widgets/tag_item.dart';

class TimerTag extends ConsumerWidget {
  const TimerTag({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int id = ref.watch(tagProvider);
    bool isRunning = ref.watch(timerProvider)?.isRunning ?? false;

    Tag tag = tags.firstWhere((tag) => tag.id == id,
        orElse: () => Tag(id: 0, name: "Study", color: Colors.grey.shade300));
    return SizedBox(
      height: 45,
      child: TagItem(
        name: tag.name,
        color: tag.color,
        textColor: Colors.white70,
        onPressed: () {
          if (!isRunning) {
            showBarModalBottomSheet(
                context: context,
                expand: false,
                builder: (context) => const Settings());
          }
          ;
        },
      ),
    );
  }
}
