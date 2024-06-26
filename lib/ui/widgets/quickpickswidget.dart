import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/models/quick_picks.dart';
import '../player/player_controller.dart';
import 'image_widget.dart';
import 'songinfo_bottom_sheet.dart';

class QuickPicksWidget extends StatelessWidget {
  const QuickPicksWidget({super.key, required this.content});
  final QuickPicks content;

  @override
  Widget build(BuildContext context) {
    final PlayerController playerController = Get.find<PlayerController>();
    return SizedBox(
      height: 340,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text(
                content.title,
                style: Theme.of(context).textTheme.titleLarge,
              )),
          const SizedBox(height: 10),
          Expanded(
            child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: content.songList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: .26 / 1,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 5,
                ),
                itemBuilder: (_, item) {
                  return ListTile(
                    contentPadding: const EdgeInsets.only(left: 5),
                    leading: ImageWidget(song: content.songList[item],size: 55,),
                    title: Text(
                      content.songList[item].title,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    subtitle: Text(
                      "${content.songList[item].artist}",
                      maxLines: 1,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    onTap: () {
                      playerController
                          .pushSongToQueue(content.songList[item]);
                    },
                    onLongPress: () async {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: playerController
                            .homeScaffoldkey.currentState!.context,
                        //constraints: BoxConstraints(maxHeight:Get.height),
                        barrierColor: Colors.transparent.withAlpha(100),
                        builder: (context) =>
                            SongInfoBottomSheet(
                            content.songList[item]),
                      ).whenComplete(() => Get.delete<SongInfoController>());
                    },
                  );
                }),
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }
}
