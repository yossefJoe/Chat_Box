import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zoom_clone/core/resources/assets_manager.dart';
import 'package:zoom_clone/core/resources/color_manager.dart';
import 'package:zoom_clone/core/resources/styles_manager.dart';
import 'package:zoom_clone/core/widgets/custom_body.dart';
import 'package:zoom_clone/features/Chat/presentation/views/widgets/user_image.dart';
import 'package:zoom_clone/features/Contacts/widgets/contact_info_body.dart';
import 'package:zoom_clone/features/calls/recent_calls_widget.dart';

class ContactInfoScreen extends StatelessWidget {
  const ContactInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.blackColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Center(
                child: Column(
                  children: [
                    UserImage(
                      imageUrl: AssetsManager.status1,
                      size: 80,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Jhon abraham",
                      style: AppStyles.s18Medium.copyWith(color: Colors.white),
                    ),
                    Text(
                      "@Jhon abraham",
                      style: AppStyles.s12Medium
                          .copyWith(color: ColorManager.greyColor),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildIcon(Icons.chat,(){}),
                        buildIcon(Icons.videocam,(){}),
                        buildIcon(Icons.phone,(){}),
                        buildIcon(Icons.more_horiz,(){}),
                   
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.w),
                            topRight: Radius.circular(20.w),
                          ),
                          child: Container(
                            color: ColorManager.whiteColor,
                            child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: ContactInfoBody()),
                          ),
                        )),
                  ],
                ),
              ),
              Positioned(
                  child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  size: 20,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.of(context).pop(),
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIcon(IconData icon,Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          width: 50,
          height: 50,
          child: Icon(
            icon,
            color: Colors.white,
            size: 25,
          )),
    );
  }
}
