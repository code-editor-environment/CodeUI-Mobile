import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/components/reusable_text.dart';
import 'package:mobile/constants/app_style.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile/view/widget/elements_detail.dart';

class BookmarkedItemWidget extends StatefulWidget {
  const BookmarkedItemWidget({super.key});

  @override
  State<BookmarkedItemWidget> createState() => _BookmarkedItemWidgetState();
}

class _BookmarkedItemWidgetState extends State<BookmarkedItemWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(children: [
        //item1
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.asset(
                "assets/images/Mask_group.png",
                width: 120,
                height: 100,
              ),
            ),
            // trên là cái hình elements
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors
                        .transparent, // Set the button background color to transparent
                    elevation: 0, // Remove the button shadow
                    padding: EdgeInsets.zero, // Remove default button padding
                    // Reduce the button's tap target size
                  ),
                  onPressed: () {
                    Get.to(DetailedWidget());
                  },
                  child: ReusableText(
                      text: "Button Learn more' ",
                      style: appstyle(15, Color(0xffF6F0F0), FontWeight.w600)),
                ),

                //bookmarked times
                Row(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          MdiIcons.heartOutline,
                          color: Color(0xffAB55F7),
                          size: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(2, 0, 0, 0),
                          child: ReusableText(
                              text: " 2099 ",
                              style: appstyle(
                                  13, Color(0xffAB55F7), FontWeight.w400)),
                        ),
                      ]),
                  SizedBox(
                    width: 12,
                  ),
                  //save times idk
                  Row(children: [
                    Row(children: [
                      Icon(
                        MdiIcons.bookmarkOutline,
                        color: Color(0xffAB55F7),
                        size: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(2, 0, 0, 0),
                        child: ReusableText(
                            text: " 2099 ",
                            style: appstyle(
                                13, Color(0xffAB55F7), FontWeight.w400)),
                      ),
                    ]),
                  ]),
                ]),
              ],
            )
          ],
        ),
        //item1 ending

        //item1 ending
      ]),
    );
  }
}
