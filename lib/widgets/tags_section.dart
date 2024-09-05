import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:timer_app/riverpod/tags.dart';
import 'package:timer_app/utils/tagsData.dart';
import 'package:timer_app/widgets/tag_item.dart';
import 'package:timer_app/utils/tag_color.dart';

class TagsSection extends ConsumerStatefulWidget {
  const TagsSection({super.key});

  @override
  TagsSectionState createState() => TagsSectionState();
}

class TagsSectionState extends ConsumerState<TagsSection> {
  int selectedTagId = 1;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    setState(() {
      selectedTagId = ref.watch(tagProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    final ItemScrollController itemScrollController = ItemScrollController();

    final ScrollOffsetController scrollOffsetController =
        ScrollOffsetController();
    final ItemPositionsListener itemPositionsListener =
        ItemPositionsListener.create();
    final ScrollOffsetListener scrollOffsetListener =
        ScrollOffsetListener.create();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text("Tags",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.7))),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SizedBox(
            height: 40,
            child: ScrollablePositionedList.builder(
                scrollDirection: Axis.horizontal,
                itemScrollController: itemScrollController,
                scrollOffsetController: scrollOffsetController,
                itemPositionsListener: itemPositionsListener,
                scrollOffsetListener: scrollOffsetListener,
                initialScrollIndex: selectedTagId,
                initialAlignment: 0.42,
                itemCount: tags.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return IconButton(
                        onPressed: () {},
                        style: IconButton.styleFrom(
                            backgroundColor: Colors.grey.shade400.withAlpha(80),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10)),
                        icon: const Icon(Icons.add));
                  }
                  Tag tag = tags[index - 1];
                  return TagItem(
                    name: tag.name,
                    color: tag.color,
                    isSelected: tag.id == selectedTagId,
                    onPressed: () {
                      ref.watch(tagProvider.notifier).setItemId(tag.id);
                      itemScrollController.scrollTo(
                        index: index,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOutCubic,
                        alignment: 0.42,
                      );
                      setState(() {
                        selectedTagId = tag.id;
                      });
                    },
                  );
                }),
          ),
        )
      ],
    );
  }
}
