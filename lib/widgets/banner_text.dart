import 'package:flutter/material.dart';

class BannerText extends StatelessWidget {
  const BannerText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Start planting today!',
      style: Theme.of(context).textTheme.headlineSmall,
    );
    ;
  }
}
