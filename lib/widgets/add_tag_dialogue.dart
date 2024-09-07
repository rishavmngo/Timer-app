import 'package:flutter/material.dart';
import 'package:timer_app/utils/tag_color_data.dart';

class AddTagsDialogue extends StatefulWidget {
  const AddTagsDialogue({super.key});

  @override
  State<AddTagsDialogue> createState() => _AddTagsDialogueState();
}

class _AddTagsDialogueState extends State<AddTagsDialogue> {
  Color selectedTagColor = Colors.black;
  @override
  Widget build(BuildContext context) {
    print("debuging");
    print(Colors.white.value == selectedTagColor.value);
    print(selectedTagColor.value);
    return AlertDialog(
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Icon(
              Icons.style,
              color: Colors.white,
            ),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor, shape: BoxShape.circle),
          ),
          SizedBox(width: 15),
          Text(
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
            decoration: InputDecoration(label: Text("Tag Name")),
          ),
          SizedBox(height: 10),
          SizedBox(
              height: 100,
              width: MediaQuery.sizeOf(context).width,
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('Add'),
        ),
      ],
    );
  }
}
