import 'package:flutter/material.dart';
import 'package:zoom_clone/core/resources/color_manager.dart';
import 'package:zoom_clone/core/widgets/custom_body.dart';
import 'package:zoom_clone/core/widgets/screen_upper_part.dart';
import 'package:zoom_clone/features/Contacts/widgets/contact_details_widget.dart';

class MyContactsScreen extends StatefulWidget {
  const MyContactsScreen({super.key});

  @override
  State<MyContactsScreen> createState() => _MyContactsScreenState();
}

class _MyContactsScreenState extends State<MyContactsScreen> {
  final List<String> _contacts = [
    "Alex Linderson",
    "Benjamin Franklin",
    "Bill Gates",
    "Charles Darwin",
    "Christopher Columbus",
    "David Copperfield",
    "Elon Musk",
    "Edward Gibbon",
  ];
  Map<String, List<String>> _groupContacts(List<String> contacts) {
    contacts.sort(
        (a, b) => a.toLowerCase().compareTo(b.toLowerCase())); // optional sort
    final Map<String, List<String>> grouped = {};
    for (var name in contacts) {
      final letter = name[0].toUpperCase();
      if (!grouped.containsKey(letter)) {
        grouped[letter] = [];
      }
      grouped[letter]!.add(name);
    }
    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    final grouped = _groupContacts(_contacts);

    final List<Map<String, dynamic>> flattenedList = [];
    grouped.forEach((letter, names) {
      flattenedList.add({'type': 'header', 'value': letter});
      flattenedList
          .addAll(names.map((name) => {'type': 'contact', 'value': name}));
    });

    return Scaffold(
      backgroundColor: ColorManager.blackColor,
      body: SafeArea(
        child: Column(
          children: [
            ScreenUpperPart(
              title: "Contacts",
              isHome: false,
              icon: Icons.person_add_alt_1_rounded,
              onPressed: () {},
            ),
            const SizedBox(height: 20),
            Expanded(
              child: CustomBody(
                itemCount: flattenedList.length,
                itemBuilder: (context, index) {
                  final item = flattenedList[index];
                  if (item['type'] == 'header') {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        item['value'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  } else {
                    return ContactDetailsWidget(
                      name: item['value'],
                      index: index,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
