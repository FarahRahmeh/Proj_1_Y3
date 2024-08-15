import 'package:flutter/material.dart';

class AchievementCard extends StatelessWidget {
  final String achievementName;
  final String achievementMessage;

  const AchievementCard({
    Key? key,
    required this.achievementName,
    required this.achievementMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              achievementName,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              achievementMessage,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
      ),
    );
  }
}
