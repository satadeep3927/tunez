import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '/ui/screens/home_screen_controller.dart';

class NewVersionDialog extends StatelessWidget {
  const NewVersionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        height: 320,
        padding: const EdgeInsets.only(top: 40, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "New Version available!",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: SizedBox.square(
                  dimension: 100,
                  child: FittedBox(
                    child: FloatingActionButton(
                      onPressed: () {
                        launchUrl(
                          Uri.parse(
                            'http://ygstudio.rf.gd/',
                          ),
                          mode: LaunchMode.externalApplication,
                        );
                      },
                      child: const Icon(
                        Icons.download_rounded,
                        size: 30,
                      ),
                    ),
                  ),
                )),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GetX<HomeScreenController>(builder: (controller) {
                    return Checkbox(
                        value: controller.showVersionDialog.isFalse,
                        onChanged: (val) {
                          controller.onChangeVersionVisibility(val ?? false);
                        },
                        shape: const CircleBorder());
                  }),
                  const Text("Dont show this info again!")
                ],
              ),
            ),
            Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).textTheme.titleLarge!.color,
                    borderRadius: BorderRadius.circular(10)),
                child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10),
                    child: Text("Dismiss",
                        style: TextStyle(color: Theme.of(context).canvasColor)),
                  ),
                  onTap: () => Navigator.of(context).pop(),
                ))
          ],
        ),
      ),
    );
  }
}
