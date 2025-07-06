import 'package:flutter/material.dart';
import 'package:zoom_clone/core/resources/color_manager.dart';
import 'package:zoom_clone/core/resources/styles_manager.dart';
import 'package:zoom_clone/features/Contacts/widgets/media_shared_widget.dart';

class ContactInfoBody extends StatelessWidget {
  const ContactInfoBody({super.key});

  @override
  Widget build(BuildContext context) {
    const textStyleLabel = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: Colors.black87,
    );

    const textStyleValue = TextStyle(
      fontSize: 14,
      color: Colors.black54,
    );

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
          const InfoTile(title: 'Display Name', value: 'Jhon Abraham'),
          const SizedBox(height: 15),
          const InfoTile(
              title: 'Email Address', value: 'jhonabraham20@gmail.com'),
          const SizedBox(height: 15),
          const InfoTile(
            title: 'Address',
            value: '33 street west subidbazar, sylhet',
          ),
          const SizedBox(height: 15),
          const InfoTile(title: 'Phone Number', value: '(320) 555-0104'),
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
