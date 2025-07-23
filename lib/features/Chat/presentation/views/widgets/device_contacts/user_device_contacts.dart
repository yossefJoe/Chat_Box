import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:zoom_clone/core/resources/assets_manager.dart';
import 'package:zoom_clone/core/resources/color_manager.dart';
import 'package:zoom_clone/core/resources/firebase_methods.dart';
import 'package:zoom_clone/core/resources/methods.dart';
import 'package:zoom_clone/core/resources/styles_manager.dart';
import 'package:zoom_clone/features/Chat/data/models/chat_message_model.dart';
import 'package:zoom_clone/features/Chat/presentation/cubits/get_my_contacts_cubit/get_my_contacts_cubit.dart';
import 'package:zoom_clone/features/Chat/presentation/cubits/get_my_contacts_cubit/get_my_contacts_state.dart';
import 'package:zoom_clone/features/Chat/presentation/views/widgets/device_contacts/contacts_search_bar.dart';
import 'package:zoom_clone/features/Contacts/data/models/user_data_model.dart';

Future<Contact?> showContactsDialog(
    BuildContext context, UserDataModel userData) {
  return showDialog<Contact>(
    context: context,
    builder: (context) {
      return UserDeviceContacts(userData: userData);
    },
  );
}

class UserDeviceContacts extends StatefulWidget {
  const UserDeviceContacts({super.key, required this.userData});
  final UserDataModel userData;

  @override
  State<UserDeviceContacts> createState() => _UserDeviceContactsState();
}

class _UserDeviceContactsState extends State<UserDeviceContacts> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetMyContactsCubit, GetMyContactsState>(
      builder: (context, state) {
        if (state is GetMyContactsSuccessState) {
          final contactsCubit = context.read<GetMyContactsCubit>();
          final allContacts = state.myContacts ?? [];
          final filteredContacts = contactsCubit.filteredContacts;
          final contactsToShow =
              filteredContacts.isNotEmpty ? filteredContacts : allContacts;

          return AlertDialog(
            title: ContactsSearchBar(
              onChanged: (query) =>
                  context.read<GetMyContactsCubit>().searchContacts(
                        query,
                      ),
            ),
            content: SizedBox(
              width: double.maxFinite,
              height: 400,
              child: contactsToShow.isEmpty
                  ? const Center(child: Text('No contacts found'))
                  : ListView.builder(
                      itemCount: contactsToShow.length,
                      itemBuilder: (context, index) {
                        final contact = contactsToShow[index];
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
                          title: TextHighlight(
                            text: name,
                            words: contactsCubit.searchQuery.isNotEmpty
                                ? {
                                    contactsCubit.searchQuery: HighlightedWord(
                                      textStyle: AppStyles.s16Bold.copyWith(
                                        color: ColorManager.primaryColor,
                                      ),
                                    ),
                                  }
                                : {},
                            textStyle: AppStyles.s16Regular,
                          ),
                          subtitle: Text(phone ?? ''),
                          onTap: () {
                            final message = ChatMessage(
                              message: name,
                              isFromMe: true,
                              time: DateTime.now(),
                              contact: {"displayName": name, "phones": phone},
                            );
                            Methods.basicSendMessage(
                              context,
                              widget.userData.uid ?? "",
                              message,
                              widget.userData,
                              FirebaseHelper.currentUser,
                            );
                            context.pop();
                          },
                        );
                      },
                    ),
            ),
          );
        }
        if (state is GetMyContactsFailureState) {
          return const AlertDialog(
            title: Text('Error'),
            content: Text('Failed to load contacts'),
          );
        } else {
          return AlertDialog(
            title: const Text('Select Contact'),
            content: SizedBox(
              height: 100,
              child: Center(child: Image.asset(AssetsManager.imageLoading2)),
            ),
          );
        }
      },
    );
  }
}
