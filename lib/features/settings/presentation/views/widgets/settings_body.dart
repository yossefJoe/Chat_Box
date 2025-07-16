import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoom_clone/core/resources/assets_manager.dart';
import 'package:zoom_clone/core/resources/firebase_methods.dart';
import 'package:zoom_clone/core/resources/navigation.dart';
import 'package:zoom_clone/core/resources/snackbar_helper.dart';
import 'package:zoom_clone/core/resources/styles_manager.dart';
import 'package:zoom_clone/core/widgets/primary_button.dart';
import 'package:zoom_clone/features/Chat/presentation/views/widgets/user_image.dart';
import 'package:zoom_clone/features/settings/presentation/cubit/sign_out_cubit/sign_out_cubit.dart';
import 'package:zoom_clone/features/settings/presentation/cubit/sign_out_cubit/sign_out_state.dart';
import 'package:zoom_clone/features/settings/presentation/cubit/user_data_cubit/user_data_cubit.dart';
import 'package:zoom_clone/features/settings/presentation/cubit/user_data_cubit/user_data_state.dart';

class SettingsBody extends StatelessWidget {
  const SettingsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignOutCubit, SignOutState>(
      listener: (context, state) {
        if (state is SignOutSuccessState) {
          ToastHelper.showSuccess("Logout Succefully");
          NavigationHelper.goToWelcomeScreen(context);
        }
        if (state is SignOutFailureState) {
          ToastHelper.showError("Logout Failed");
        }
      },
      child: Column(
        children: [
          BlocBuilder<UserDataCubit, UserDataState>(
            builder: (context, state) {
              if (state is UserDataSuccessState) {
                final userData = state.userData;
                return Row(
                  children: [
                    UserImage(
                      imageUrl: userData['photoUrl'] ?? AssetsManager.homepic,
                      size: 60,
                    ),
                    const SizedBox(width: 20),
                    titleandBio(userData['name'], userData['email']),
                  ],
                );
              }
              if (state is UserDataFailureState) {
                return Text(state.message);
              }
              return const SizedBox();
            },
          ),
          const SizedBox(height: 10),
          featureListtile(
              "Account", Icons.person, "Manage your account details", () {}),
          featureListtile("Notifications", Icons.notifications,
              "Manage your notifications", () {}),
          featureListtile("Help", Icons.help, "Get help with Zoom", () {}),
          featureListtile("Invite Friends", Icons.share,
              "Invite your friends to Zoom", () {}),
          featureListtile("Logout", Icons.logout, "Quit the app", () {
            context.read<SignOutCubit>().signOut();
          }),
        ],
      ),
    );
  }

  Widget featureListtile(
      String title, IconData icon, String subtitle, void Function()? onTap) {
    return ListTile(
      subtitle: Text(
        subtitle,
        style: AppStyles.s14Light,
      ),
      title: Text(
        title,
        style: AppStyles.s16Medium,
      ),
      leading: Icon(icon),
      onTap: onTap,
    );
  }

  Widget titleandBio(String name, String email) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: AppStyles.s18Bold,
        ),
        Text(
          email,
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
