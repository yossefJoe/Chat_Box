import 'package:flutter/material.dart';
import 'package:zoom_clone/core/resources/styles_manager.dart';

class ContactsSearchBar extends StatelessWidget {
  const ContactsSearchBar({super.key, this.onChanged});
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: 'Search Contacts',
          hintStyle: AppStyles.s14Regular.copyWith(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        style: AppStyles.s16Regular.copyWith(color: Colors.grey),
      ),
    );
  }
}
