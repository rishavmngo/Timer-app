import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timer_app/db/db_service.dart';
import 'package:timer_app/riverpod/tagsList.dart';
import 'package:timer_app/utils/tag_color_data.dart';

class AddTagsDialogue extends ConsumerStatefulWidget {
  const AddTagsDialogue({super.key});

  @override
  AddTagsDialogueState createState() => AddTagsDialogueState();
}

class AddTagsDialogueState extends ConsumerState<AddTagsDialogue> {
  Color selectedTagColor = Colors.black;
  final TextEditingController _nameController = TextEditingController();

  Future<void> createTag(String name, Color color) async {
    final dbService = DbService();

    try {
      await dbService.addTag(name, color);
      ref.read(tagsListProvider.notifier).refreshTags();
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor, shape: BoxShape.circle),
            child: const Icon(
              Icons.style,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 15),
          const Text(
            "Create a tag",
            style: TextStyle(
                color: Colors.black, fontSize: 24, fontWeight: FontWeight.w400),
          )
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(label: Text("Tag Name")),
          ),
          const SizedBox(height: 10),
          SizedBox(
              height: 100,
              width: MediaQuery.sizeOf(context).width,
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 8, // Number of columns
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: tagColors.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTagColor = tagColors[index];
                        });
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: tagColors[index]),
                          child: (tagColors[index].value ==
                                  selectedTagColor.value)
                              ? Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Theme.of(context).primaryColor,
                                        width: 2.0),
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    size: 17,
                                    color: Colors.white,
                                  ),
                                )
                              : Container()),
                    );
                  })),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            await createTag(_nameController.text, selectedTagColor);
            if (context.mounted) {
              Navigator.pop(context, 'OK');
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
