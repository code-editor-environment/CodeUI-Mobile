import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/components/reusable_text_long.dart';

import '../common/constants/app_constants.dart';
import '../common/constants/app_style.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.black,
        child: Column(
          children: [
            Row(
              // row chưa nguyên cái app bar
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Color(0xFFAB55F7),
                  ),
                ),
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Color(0xff292929),
                  child: Card(
                    color: Color(0xff292929),
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Stack(
                      children: [
                        Ink.image(
                          image: NetworkImage(
                              "https://scontent.fsgn5-15.fna.fbcdn.net/v/t1.6435-9/149013484_190222949125848_8721369720258518493_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=7a1959&_nc_ohc=N32UJLQwOdoAX94R7wG&_nc_ht=scontent.fsgn5-15.fna&_nc_e2o=f&oh=00_AfBLjixnY7hmvy7hpaVx_4AuzB7z2MJ32NxxT6JNV1gw-w&oe=6554FBF9"),
                          height: 64,
                          width: 64,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableTextLong(
                        text: "Bích Ngọc",
                        style:
                            appstyle(16, Color(kLight.value), FontWeight.w800),
                      ),
                      Row(
                        children: [
                          ReusableTextLong(
                            text: "Hoạt động 16 phút trước",
                            style: appstyle(
                                14, Color(kLight.value), FontWeight.w400),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                //row chứa 2 cái icon button
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.call,
                    color: Color(0xFFAB55F7),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.videocam,
                    color: Color(0xFFAB55F7),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(
        double.maxFinite,
        60,
      );
}
