import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:zoom_clone/core/resources/assets_manager.dart';
import 'package:zoom_clone/core/resources/color_manager.dart';
import 'package:zoom_clone/core/resources/firebase_methods.dart';
import 'package:zoom_clone/core/resources/methods.dart';
import 'package:zoom_clone/features/Chat/data/models/chat_message_model.dart';
import 'package:zoom_clone/features/Chat/presentation/cubits/get_my_contacts_cubit/get_my_contacts_cubit.dart';
import 'package:zoom_clone/features/Chat/presentation/cubits/get_my_contacts_cubit/get_my_contacts_state.dart';
import 'package:zoom_clone/features/Contacts/data/models/user_data_model.dart';

Future<Contact?> showContactsDialog(
    BuildContext context, UserDataModel userData) {
  return showDialog<Contact>(
    context: context,
    builder: (context) {
      return BlocBuilder<GetMyContactsCubit, GetMyContactsState>(
        builder: (context, state) {
          if (state is GetMyContactsSuccessState) {
            final contacts = state.myContacts ?? [];
            return AlertDialog(
              title: Text('Select Contact'),
              content: SizedBox(
                width: double.maxFinite,
                height: 400,
                child: contacts.isEmpty
                    ? const Center(child: Text('No contacts found'))
                    : ListView.builder(
                        itemCount: contacts.length,
                        itemBuilder: (context, index) {
                          final contact = contacts[index];
                          final name = contact.displayName ?? 'No Name';
                          final phone = contact.phones?.isNotEmpty == true
                              ? contact.phones!.first.value
                              : 'No Number';

                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor:
                                  ColorManager.primaryColor.withOpacity(0.3),
                              radius: 25.r,
                              child: Text(name.substring(0, 1).toUpperCase()),
                            ),
                            title: Text(name),
                            subtitle: Text(phone ?? ''),
                            onTap: () {
                              final message = ChatMessage(
                                  message: contact.displayName ?? '',
                                  isFromMe: true,
                                  time: DateTime.now(),
                                  contact: {
                                    "displayName": contact.displayName ?? '',
                                    "phones": contact.phones?.isNotEmpty == true
                                        ? contact.phones!.first.value
                                        : 'No Number'
                                  });
                              Methods.basicSendMessage(
                                  context,
                                  userData.uid ?? "",
                                  message,
                                  userData,
                                  FirebaseHelper.currentUser);
                              context.pop();
                            },
                          );
                        },
                      ),
              ),
            );
          }
          if (state is GetMyContactsFailureState) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Failed to load contacts'),
            );
          } else {
            return AlertDialog(
              title: Text('Select Contact'),
              content: SizedBox(
                height: 100,
                child: Center(child: Image.asset(AssetsManager.imageLoading2)),
              ),
            );
          }
        },
      );
    },
  );
}
