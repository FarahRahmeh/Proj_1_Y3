import 'package:booktaste/common/features/challenges/challenge_model.dart';
import 'package:booktaste/common/features/challenges/genre_challenge_view.dart';
import 'package:booktaste/common/features/challenges/random_challenge_view.dart';
import 'package:booktaste/common/widgets/custom_shapes/Containers/rounded_container.dart';
import 'package:booktaste/data/services/role.manager.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:booktaste/utils/popups/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'challenge_controller.dart';

class ChallengesView extends StatelessWidget {
  final controller = Get.put(ChallengeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Challenges'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: controller.challenges.length,
            itemBuilder: (context, index) {
              final challenge = controller.challenges[index];
              return RoundedContainer(
                margin: EdgeInsets.symmetric(
                    horizontal: Sizes.defaultSpace, vertical: Sizes.sm),
                backgroundColor: beige2,
                child: ListTile(
                  title: Text(
                    challenge!.name.toString(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    challenge!.description.toString(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  onTap: () {
                    Get.to(() => ChallengeDetailPage(challenge: challenge));
                  },
                  leading: Icon(Iconsax.cup),
                  trailing: Text(challenge.id.toString()),
                ),
              );
            },
          );
        }
      }),
    );
  }
}

class ChallengeDetailPage extends StatelessWidget {
  final Challenge challenge;
  final ChallengeController controller = Get.find<ChallengeController>();

  ChallengeDetailPage({required this.challenge});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(challenge.name.toString()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              challenge.name.toString(),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Description:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(challenge.description.toString()),
            SizedBox(height: 16),
            Text(
              'ID:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(challenge.id.toString()),
            SizedBox(height: 16),
            Text(
              'Type:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(challenge.type.toString()),
            if (challenge.challengeIs != null) ...[
              SizedBox(height: 16),
              Text(
                'Challenge Is:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(challenge.challengeIs!),
            ],
            SizedBox(height: 16),
            Text(
              'Is Open:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(challenge.isOpen == 1 ? 'Yes' : 'No'),
            SizedBox(height: 16),
            Text(
              'Open Date:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(challenge.openDate.toString()),
            SizedBox(height: 16),
            Text(
              'Duration:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('${challenge.durationUnits} ${challenge.durationType}(s)'),
            SizedBox(height: 16),
            Text(
              'Points:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('${challenge.points}'),
            if (challenge.rules != null) ...[
              SizedBox(height: 16),
              Text(
                'Rules:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(challenge.rules!),
            ],
            SizedBox(height: 16),
            FutureBuilder<bool>(
                future: isUser(),
                builder: (builder, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final user = snapshot.data;
                    if (user == true) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              controller.joinChallenge(challenge.id.toString());
                            },
                            child: Text('Join'),
                          ),
                          SizedBox(
                            width: Sizes.md,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              controller
                                  .leaveChallenge(challenge.id.toString());
                            },
                            child: Text('Leave'),
                          ),
                          SizedBox(
                            width: Sizes.md,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (challenge.id == 3) {
                                Get.to(() => BookDetailsPage(
                                    challengeId: challenge.id.toString()));
                              } else if (challenge.id == 2) {
                                Get.to(() => GenreDetailsPage(
                                    challengeId: challenge.id.toString()));
                              }
                            },
                            child: Text('details'),
                          ),
                        ],
                      );
                    } else {
                      return ElevatedButton(
                        onPressed: () {
                          // Example body data based on challenge type
                          if (challenge.name == 'Author Spotlight' ||
                              challenge.name == 'Personal Growth' ||
                              challenge.name == 'Time Travel') {
                            // controller.openChallenge(
                            //   challenge,
                            //   about: 'some about text',
                            // );
                            _showAboutDialog(context, challenge);
                            // MyDialogs.defaultDialog(context: context);
                          } else if (challenge.name == 'Entire Series') {
                            _showAboutAndBooksDialog(context, challenge);
                          } else {
                            controller.openChallenge(challenge);
                          }
                        },
                        child: Text('Open Challenge'),
                      );
                    }
                  }
                }),
          ],
        ),
      ),
    );
  }

  Future<void> _showAboutAndBooksDialog(
      BuildContext context, Challenge challenge) async {
    final TextEditingController aboutController = TextEditingController();
    final TextEditingController booksController = TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap a button to dismiss the dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter About and Books Information'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: aboutController,
                decoration: InputDecoration(hintText: 'Enter about details'),
              ),
              TextField(
                controller: booksController,
                decoration: InputDecoration(
                    hintText: 'Enter book IDs separated by commas'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Submit'),
              onPressed: () {
                final aboutText = aboutController.text;
                final booksText = booksController.text;
                if (aboutText.isNotEmpty && booksText.isNotEmpty) {
                  final booksArray =
                      booksText.split(',').map(int.parse).toList();
                  Get.find<ChallengeController>().openChallenge(
                    challenge,
                    about: aboutText,
                    booksArray: booksArray,
                  );
                  Navigator.of(context).pop();
                } else {
                  Get.snackbar('Error', 'Both fields must be filled');
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showAboutDialog(
      BuildContext context, Challenge challenge) async {
    final TextEditingController aboutController = TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap a button to dismiss the dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter About Information'),
          content: TextField(
            controller: aboutController,
            decoration: InputDecoration(hintText: 'Enter details'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Submit'),
              onPressed: () {
                final aboutText = aboutController.text;
                if (aboutText.isNotEmpty) {
                  Get.find<ChallengeController>().openChallenge(
                    challenge,
                    about: aboutText,
                  );
                  Navigator.of(context).pop();
                } else {
                  Get.snackbar('Error', 'About field cannot be empty');
                }
              },
            ),
          ],
        );
      },
    );
  }
}
