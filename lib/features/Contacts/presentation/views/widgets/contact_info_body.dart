import 'package:flutter/material.dart';
import 'package:zoom_clone/core/resources/color_manager.dart';
import 'package:zoom_clone/core/resources/styles_manager.dart';
import 'package:zoom_clone/features/Contacts/data/models/user_data_model.dart';
import 'package:zoom_clone/features/Contacts/presentation/views/widgets/media_shared_widget.dart';

class ContactInfoBody extends StatelessWidget {
  const ContactInfoBody({super.key, required this.userData});
  final UserDataModel userData;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(top: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoTile(title: 'Display Name', value: userData.name ?? ''),
          const SizedBox(height: 15),
          InfoTile(title: 'Email Address', value: userData.email ?? ''),
          const SizedBox(height: 15),
          InfoTile(
            title: 'Address',
            value: userData.address ?? 'No address added',
          ),
          const SizedBox(height: 15),
          InfoTile(
              title: 'Phone Number',
              value: userData.phoneNumber ?? 'No phone number added'),
          const SizedBox(height: 25),
          const MediaSharedWidget(),
        ],
      ),
    );
  }
}

class InfoTile extends StatelessWidget {
  final String title;
  final String value;

  const InfoTile({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppStyles.s16SemiBold),
        const SizedBox(height: 5),
        Text(value,
            style:
                AppStyles.s14Regular.copyWith(color: ColorManager.greyColor)),
      ],
    );
  }
}
