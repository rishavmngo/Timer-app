import 'package:flutter/material.dart';

class StatsBtn extends StatelessWidget {
  final int currentPage;
  final Function togglePage;
  const StatsBtn(
      {super.key, required this.currentPage, required this.togglePage});

  @override
  Widget build(BuildContext context) {
    ButtonStyle active = TextButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)));
    return Container(
      decoration: BoxDecoration(
        //color: Colors.black.withAlpha(100),
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: TextButton(
                style: currentPage == 0 ? active : null,
                onPressed: () {
                  togglePage(0);
                },
                child: Text("Day",
                    style: TextStyle(
                      fontSize: 15,
                      color: currentPage == 0 ? Colors.white : Colors.black87,
                    ))),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: TextButton(
                style: currentPage == 1 ? active : null,
                onPressed: () {
                  //pageController.jumpToPage(1);
                  togglePage(1);
                },
                child: Text("Week",
                    style: TextStyle(
                      fontSize: 15,
                      color: currentPage == 1 ? Colors.white : Colors.black87,
                    ))),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: TextButton(
                style: currentPage == 2 ? active : null,
                onPressed: () {
                  //pageController.jumpToPage(1);
                  togglePage(2);
                },
                child: Text("Month",
                    style: TextStyle(
                      fontSize: 15,
                      color: currentPage == 2 ? Colors.white : Colors.black87,
                    ))),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: TextButton(
                style: currentPage == 3 ? active : null,
                onPressed: () {
                  //pageController.jumpToPage(1);
                  togglePage(3);
                },
                child: Text("Year",
                    style: TextStyle(
                      fontSize: 15,
                      color: currentPage == 3 ? Colors.white : Colors.black87,
                    ))),
          ),
        ],
      ),
    );
  }
}
