import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class FocusedTime extends StatefulWidget {
  const FocusedTime({super.key});

  @override
  State<FocusedTime> createState() => _FocusedTimeState();
}

class _FocusedTimeState extends State<FocusedTime> {
  @override
  Widget build(BuildContext context) {
    int _selectedItem = 60;
    final ItemScrollController itemScrollController = ItemScrollController();
    final ScrollOffsetController scrollOffsetController =
        ScrollOffsetController();
    final ItemPositionsListener itemPositionsListener =
        ItemPositionsListener.create();
    final ScrollOffsetListener scrollOffsetListener =
        ScrollOffsetListener.create();
    const int from = -15;
    const int factor = 5;
    const double alignment = 0.42;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text("Focused Time",
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
              initialScrollIndex: ((_selectedItem - from) / factor).floor(),
              initialAlignment: alignment,
              itemCount: 55,
              itemBuilder: (context, index) {
                final int item = from + (index * factor);
                bool toHide = false;
                if (item < 5 || item > 240) {
                  toHide = true;
                }
                return toHide
                    ? Container(width: 50)
                    : InkWell(
                        onTap: () {
                          setState(() {
                            _selectedItem = item;
                          });
                          itemScrollController.scrollTo(
                            index: index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOutCubic,
                            alignment: alignment,
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: item == _selectedItem
                                  ? Colors.white
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8)),
                          width: 60,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          child: Center(
                              child: Text(
                            "$item",
                            style: item == _selectedItem
                                ? TextStyle(fontWeight: FontWeight.w700)
                                : TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black38),
                          )),
                        ),
                      );
              },
            ),
          ),
        ),
      ],
    );
  }
}
