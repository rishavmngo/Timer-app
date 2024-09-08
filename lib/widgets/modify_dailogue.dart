import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timer_app/db/db_service.dart';
import 'package:timer_app/riverpod/tagsList.dart';
import 'package:timer_app/utils/tag_color.dart';
import 'package:timer_app/utils/tag_color_data.dart';

class ModifyDailogue extends StatefulWidget {
  final Tag tag;
  const ModifyDailogue({super.key, required this.tag});

  @override
  State<ModifyDailogue> createState() => _ModifyDailogueState();
}

class _ModifyDailogueState extends State<ModifyDailogue> {
  bool isEdit = false;

  void toggleEditMode() {
    setState(() {
      isEdit = !isEdit;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        clipBehavior: Clip.hardEdge,
        height: isEdit
            ? (MediaQuery.sizeOf(context).height / 3)
            : (MediaQuery.sizeOf(context).height / 6),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
        child: Navigator(
          clipBehavior: Clip.hardEdge,
          onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => YourFirstScreen(
              tag: widget.tag,
              toggleEdit: toggleEditMode,
            ), // First screen
          ),
        ),
      ),
    );
  }
}

class YourFirstScreen extends ConsumerStatefulWidget {
  final Function toggleEdit;
  final Tag tag;
  const YourFirstScreen(
      {super.key, required this.toggleEdit, required this.tag});

  @override
  YourFirstScreenState createState() => YourFirstScreenState();
}

class YourFirstScreenState extends ConsumerState<YourFirstScreen> {
  Future<void> deleteTag(String id) async {
    final dbService = DbService();
    try {
      await dbService.deleteTag(id);

      ref.read(tagsListProvider.notifier).refreshTags();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      //decoration: BoxDecoration(),
      child: Scaffold(
        appBar: AppBar(
            title: Row(
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
            )
          ],
        )),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
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
                      widget.toggleEdit();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => YourSecondScreen(
                                toggleEdit: widget.toggleEdit,
                                tag: widget.tag)),
                      );
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
          ]),
        ),
      ),
    );
  }
}

class YourSecondScreen extends ConsumerStatefulWidget {
  final Function toggleEdit;
  final Tag tag;
  const YourSecondScreen(
      {super.key, required this.toggleEdit, required this.tag});

  @override
  YourSecondScreenState createState() => YourSecondScreenState();
}

class YourSecondScreenState extends ConsumerState<YourSecondScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                widget.toggleEdit();
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back)),
          title: Text('Edit')),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(label: Text("Tag Name")),
            ),
            const SizedBox(height: 20),
            SizedBox(
                height: 80,
                width: MediaQuery.sizeOf(context).width,
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                                shape: BoxShape.circle,
                                color: tagColors[index]),
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
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        side: BorderSide.none),
                    onPressed: () {
                      //toggleEdit();
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                    child: const Text("Discard")),
                TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        side: BorderSide.none),
                    onPressed: () {},
                    child: const Text("Save"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
