import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timer_app/db/db_service.dart';
import 'package:timer_app/models/tag.dart';
import 'package:timer_app/riverpod/tagsList.dart';
import 'package:timer_app/utils/tag_color_data.dart';

class ModifyDailogue extends StatefulWidget {
  final Tag tag;
  const ModifyDailogue({super.key, required this.tag});

  @override
  State<ModifyDailogue> createState() => _ModifyDailogueState();
}

class _ModifyDailogueState extends State<ModifyDailogue> {
  bool isSecondScreen = false;

  void toggleScreen() {
    setState(() {
      isSecondScreen = !isSecondScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: AnimatedSize(
        duration: const Duration(milliseconds: 300),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
            maxWidth: MediaQuery.of(context).size.width * 0.9,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: isSecondScreen
                ? SecondScreen(tag: widget.tag, onBack: toggleScreen)
                : FirstScreen(tag: widget.tag, onNext: toggleScreen),
          ),
        ),
      ),
    );
  }
}

class FirstScreen extends ConsumerStatefulWidget {
  final Tag tag;
  final VoidCallback onNext;

  const FirstScreen({super.key, required this.tag, required this.onNext});

  @override
  FirstScreenState createState() => FirstScreenState();
}

class FirstScreenState extends ConsumerState<FirstScreen> {
  Future<void> deleteTag(int id) async {
    final dbService = DbService();
    try {
      await dbService.deleteTag(id);

      ref.read(tagsListProvider.notifier).refreshTags();
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle),
                child: const Icon(
                  Icons.style,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 15),
              const Text(
                "Delete a tag",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          const SizedBox(height: 25),
          //const Spacer(),
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    onPressed: () {
                      widget.onNext();
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 15,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Edit",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ],
                    )),
                Row(
                  children: [
                    TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            side: BorderSide.none),
                        onPressed: () {
                          //toggleEdit();
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                        child: const Text("Cancel")),
                    TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            side: BorderSide.none),
                        onPressed: () async {
                          await deleteTag(widget.tag.id);
                          if (context.mounted) {
                            Navigator.of(context, rootNavigator: true).pop();
                          }
                        },
                        child: const Text("Delete"))
                  ],
                ),
              ],
            ),
          ])
        ],
      ),
    );
  }
}

class SecondScreen extends ConsumerStatefulWidget {
  final Tag tag;
  final VoidCallback onBack;

  const SecondScreen({super.key, required this.tag, required this.onBack});

  @override
  SecondScreenState createState() => SecondScreenState();
}

class SecondScreenState extends ConsumerState<SecondScreen> {
  final TextEditingController _nameController = TextEditingController();
  Color selectedTagColor = Colors.black;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.tag.name;
    setState(() {
      selectedTagColor = widget.tag.color;
    });
  }

  Future<void> updateTag(Tag tag) async {
    final dbService = DbService();
    try {
      await dbService.updateTag(tag);
      ref.read(tagsListProvider.notifier).refreshTags();
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: widget.onBack,
            child: const Icon(size: 20, Icons.arrow_back_ios),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(label: Text("Tag Name")),
          ),
          const SizedBox(height: 20),
          SizedBox(
              height: 80,
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
          //const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      side: BorderSide.none),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  child: const Text("Discard")),
              TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      side: BorderSide.none),
                  onPressed: () async {
                    await updateTag(Tag(
                        id: widget.tag.id,
                        name: _nameController.text,
                        color: selectedTagColor));
                    if (context.mounted) {
                      Navigator.of(context, rootNavigator: true).pop();
                    }
                  },
                  child: const Text("Save"))
            ],
          )
        ],
      ),
    );
  }
}
