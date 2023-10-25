import 'package:flutter/material.dart';
import 'package:mobile/components/reusable_text.dart';
import 'package:mobile/common/constants/app_style.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LikedItemWidget extends StatefulWidget {
  const LikedItemWidget({super.key});

  @override
  State<LikedItemWidget> createState() => _LikedItemWidgetState();
}

class _LikedItemWidgetState extends State<LikedItemWidget> {
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
                ReusableText(
                    text: "Button Learn more' ",
                    style: appstyle(15, Color(0xffF6F0F0), FontWeight.w600)),
                ReusableText(
                    text: "đ100.000đ ",
                    style: appstyle(15, Color(0xff8026D9).withOpacity(1.0),
                        FontWeight.w300)),
                //bookmarked times
                Row(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          MdiIcons.heartOutline,
                          color: Color(0xffF6F0F0),
                          size: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                          child: ReusableText(
                              text: " 2099 ",
                              style: appstyle(
                                  13, Color(0xffF6F0F0), FontWeight.w400)),
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
                        color: Color(0xffF6F0F0),
                        size: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        child: ReusableText(
                            text: " 2099 ",
                            style: appstyle(
                                13, Color(0xffF6F0F0), FontWeight.w400)),
                      ),
                    ]),
                  ]),
                ]),
              ],
            )
          ],
        ),
        //item1 ending
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
                ReusableText(
                    text: "Button Learn more' ",
                    style: appstyle(15, Color(0xffF6F0F0), FontWeight.w600)),
                ReusableText(
                    text: "đ100.000đ ",
                    style: appstyle(15, Color(0xff8026D9).withOpacity(1.0),
                        FontWeight.w300)),
                //bookmarked times
                Row(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          MdiIcons.heartOutline,
                          color: Color(0xffF6F0F0),
                          size: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                          child: ReusableText(
                              text: " 2099 ",
                              style: appstyle(
                                  13, Color(0xffF6F0F0), FontWeight.w400)),
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
                        color: Color(0xffF6F0F0),
                        size: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        child: ReusableText(
                            text: " 2099 ",
                            style: appstyle(
                                13, Color(0xffF6F0F0), FontWeight.w400)),
                      ),
                    ]),
                  ]),
                ]),
              ],
            )
          ],
        ),
        //item1 ending
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
                ReusableText(
                    text: "Button Learn more' ",
                    style: appstyle(15, Color(0xffF6F0F0), FontWeight.w600)),
                ReusableText(
                    text: "đ100.000đ ",
                    style: appstyle(15, Color(0xff8026D9).withOpacity(1.0),
                        FontWeight.w300)),
                //bookmarked times
                Row(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          MdiIcons.heartOutline,
                          color: Color(0xffF6F0F0),
                          size: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                          child: ReusableText(
                              text: " 2099 ",
                              style: appstyle(
                                  13, Color(0xffF6F0F0), FontWeight.w400)),
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
                        color: Color(0xffF6F0F0),
                        size: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        child: ReusableText(
                            text: " 2099 ",
                            style: appstyle(
                                13, Color(0xffF6F0F0), FontWeight.w400)),
                      ),
                    ]),
                  ]),
                ]),
              ],
            )
          ],
        ),
        //item1 ending
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
                ReusableText(
                    text: "Button Learn more' ",
                    style: appstyle(15, Color(0xffF6F0F0), FontWeight.w600)),
                ReusableText(
                    text: "đ100.000đ ",
                    style: appstyle(15, Color(0xff8026D9).withOpacity(1.0),
                        FontWeight.w300)),
                //bookmarked times
                Row(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          MdiIcons.heartOutline,
                          color: Color(0xffF6F0F0),
                          size: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                          child: ReusableText(
                              text: " 2099 ",
                              style: appstyle(
                                  13, Color(0xffF6F0F0), FontWeight.w400)),
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
                        color: Color(0xffF6F0F0),
                        size: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        child: ReusableText(
                            text: " 2099 ",
                            style: appstyle(
                                13, Color(0xffF6F0F0), FontWeight.w400)),
                      ),
                    ]),
                  ]),
                ]),
              ],
            )
          ],
        ),
        //item1 ending
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
                ReusableText(
                    text: "Button Learn more' ",
                    style: appstyle(15, Color(0xffF6F0F0), FontWeight.w600)),
                ReusableText(
                    text: "đ100.000đ ",
                    style: appstyle(15, Color(0xff8026D9).withOpacity(1.0),
                        FontWeight.w300)),
                //bookmarked times
                Row(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          MdiIcons.heartOutline,
                          color: Color(0xffF6F0F0),
                          size: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                          child: ReusableText(
                              text: " 2099 ",
                              style: appstyle(
                                  13, Color(0xffF6F0F0), FontWeight.w400)),
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
                        color: Color(0xffF6F0F0),
                        size: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        child: ReusableText(
                            text: " 2099 ",
                            style: appstyle(
                                13, Color(0xffF6F0F0), FontWeight.w400)),
                      ),
                    ]),
                  ]),
                ]),
              ],
            )
          ],
        ),
        //item1 ending
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
                ReusableText(
                    text: "Button Learn more' ",
                    style: appstyle(15, Color(0xffF6F0F0), FontWeight.w600)),
                ReusableText(
                    text: "đ100.000đ ",
                    style: appstyle(15, Color(0xff8026D9).withOpacity(1.0),
                        FontWeight.w300)),
                //bookmarked times
                Row(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          MdiIcons.heartOutline,
                          color: Color(0xffF6F0F0),
                          size: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                          child: ReusableText(
                              text: " 2099 ",
                              style: appstyle(
                                  13, Color(0xffF6F0F0), FontWeight.w400)),
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
                        color: Color(0xffF6F0F0),
                        size: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        child: ReusableText(
                            text: " 2099 ",
                            style: appstyle(
                                13, Color(0xffF6F0F0), FontWeight.w400)),
                      ),
                    ]),
                  ]),
                ]),
              ],
            )
          ],
        ),
        //item1 ending
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
                ReusableText(
                    text: "Button Learn more' ",
                    style: appstyle(15, Color(0xffF6F0F0), FontWeight.w600)),
                ReusableText(
                    text: "đ100.000đ ",
                    style: appstyle(15, Color(0xff8026D9).withOpacity(1.0),
                        FontWeight.w300)),
                //bookmarked times
                Row(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          MdiIcons.heartOutline,
                          color: Color(0xffF6F0F0),
                          size: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                          child: ReusableText(
                              text: " 2099 ",
                              style: appstyle(
                                  13, Color(0xffF6F0F0), FontWeight.w400)),
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
                        color: Color(0xffF6F0F0),
                        size: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        child: ReusableText(
                            text: " 2099 ",
                            style: appstyle(
                                13, Color(0xffF6F0F0), FontWeight.w400)),
                      ),
                    ]),
                  ]),
                ]),
              ],
            )
          ],
        ),
        //item1 ending
      ]),
    );
  }
}
