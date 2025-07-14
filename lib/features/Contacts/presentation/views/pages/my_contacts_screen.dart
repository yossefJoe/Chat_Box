import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoom_clone/core/resources/color_manager.dart';
import 'package:zoom_clone/core/widgets/custom_body.dart';
import 'package:zoom_clone/core/widgets/screen_upper_part.dart';
import 'package:zoom_clone/features/Contacts/data/models/user_data_model.dart';
import 'package:zoom_clone/features/Contacts/presentation/cubits/get_contacts_cubit/get_contacts_cubit.dart';
import 'package:zoom_clone/features/Contacts/presentation/cubits/get_contacts_cubit/get_contacts_state.dart';
import 'package:zoom_clone/features/Contacts/presentation/views/widgets/contact_details_widget.dart';

class MyContactsScreen extends StatefulWidget {
  const MyContactsScreen({super.key});

  @override
  State<MyContactsScreen> createState() => _MyContactsScreenState();
}

class _MyContactsScreenState extends State<MyContactsScreen> {
  Map<String, List<Map<String, dynamic>>> _groupContacts(
      List<Map<String, dynamic>> contacts) {
    contacts.sort(
      (a, b) => a['name'].toLowerCase().compareTo(b['name'].toLowerCase()),
    );
    final Map<String, List<Map<String, dynamic>>> grouped = {};
    for (var contact in contacts) {
      final name = contact['name'] ?? '';
      final letter = name.isNotEmpty ? name[0].toUpperCase() : '#';
      if (!grouped.containsKey(letter)) {
        grouped[letter] = [];
      }
      grouped[letter]!.add(contact);
    }
    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.blackColor,
      body: BlocBuilder<UserContactsCubit, UserContactsState>(
        builder: (context, state) {
          if (state is UserContactsSuccessState) {
            final grouped = _groupContacts(state.userContacts);

            final List<Map<String, dynamic>> flattenedList = [];
            grouped.forEach((letter, contacts) {
              flattenedList.add({'type': 'header', 'value': letter});
              flattenedList.addAll(
                contacts.map((contact) => {
                      'type': 'contact',
                      'value': contact, // Pass full contact data here
                    }),
              );
            });

            return SafeArea(
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
                          final user = item['value'] as Map<String, dynamic>;
                          return ContactDetailsWidget(
                            userData: UserDataModel(
                              name: user['name'] ?? '',
                              email: user['email'] ?? '',
                              photoUrl: user['photoURL'] ?? 'none',
                              uid: user['uid'] ?? '',
                            ),
                            index: index,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          }
          if (state is UserContactsFailureState) {
            return Text(state.message);
          }
          return const SizedBox();
        },
      ),
    );
  }
}
