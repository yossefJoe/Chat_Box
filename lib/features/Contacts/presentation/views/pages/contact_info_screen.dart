import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zoom_clone/core/resources/assets_manager.dart';
import 'package:zoom_clone/core/resources/color_manager.dart';
import 'package:zoom_clone/core/resources/navigation.dart';
import 'package:zoom_clone/core/resources/routes_manager.dart';
import 'package:zoom_clone/core/resources/styles_manager.dart';
import 'package:zoom_clone/core/widgets/empty_pic_widget.dart';
import 'package:zoom_clone/features/Chat/presentation/views/widgets/user_image.dart';
import 'package:zoom_clone/features/Contacts/data/models/user_data_model.dart';
import 'package:zoom_clone/features/Contacts/presentation/views/widgets/contact_info_body.dart';

class ContactInfoScreen extends StatelessWidget {
  const ContactInfoScreen({super.key, required this.userData});
  final UserDataModel userData;
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
                    const SizedBox(height: 10),
                    userData.photoUrl == "none"
                        ? EmptyPicWidget(
                            userFirstLetter:
                                userData.name?.substring(0, 1).toUpperCase() ??
                                    "")
                        : UserImage(
                            imageUrl: userData.photoUrl ?? "",
                            size: 80,
                          ),
                    const SizedBox(height: 10),
                    Text(
                      userData.name ?? "",
                      style: AppStyles.s18Medium.copyWith(color: Colors.white),
                    ),
                    Text(
                      "@${userData.email?.split('@')[0]}",
                      style: AppStyles.s12Medium
                          .copyWith(color: ColorManager.greyColor),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildIcon(Icons.chat, () {
                          NavigationHelper.pushToPageWithParams(context,
                              AppRoutes.chatRoomScreen, {"userData": userData});
                        }),
                        buildIcon(Icons.videocam, () {}),
                        buildIcon(Icons.phone, () {}),
                        buildIcon(Icons.more_horiz, () {}),
                      ],
                    ),
                    Padding(
                        padding:const EdgeInsets.only(top: 20.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.w),
                            topRight: Radius.circular(20.w),
                          ),
                          child: Container(
                            color: ColorManager.whiteColor,
                            child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: ContactInfoBody(
                                  userData: userData,
                                )),
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

  Widget buildIcon(IconData icon, Function()? onTap) {
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
