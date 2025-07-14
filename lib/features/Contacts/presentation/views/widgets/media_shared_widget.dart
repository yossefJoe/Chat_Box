import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zoom_clone/core/resources/assets_manager.dart';
import 'package:zoom_clone/core/resources/color_manager.dart';
import 'package:zoom_clone/core/resources/styles_manager.dart';
import 'package:zoom_clone/core/widgets/text_button.dart';

class MediaSharedWidget extends StatelessWidget {
  const MediaSharedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Media shared",
              style: AppStyles.s14Medium,
            ),
            CustomTextButton(
              text: "View all",
              color: ColorManager.chatMeColor,
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 100.h,
          child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(width: 15),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return index != 2
                    ? Image.asset(AssetsManager.media1)
                    : Stack(
                        children: [
                          Image.asset(AssetsManager.media1),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            left: 0,
                            top: 0,
                            child: GestureDetector(
                              onTap: () {
                                print("Tapped");
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.all(5),
                                child: Center(
                                  child: Text(
                                    "+265",
                                    style: AppStyles.s12Medium.copyWith(
                                        color: ColorManager.whiteColor),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      );
              },
              itemCount: 3),
        ),
      ],
    );
  }
}
