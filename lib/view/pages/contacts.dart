import 'package:contact_with_object_box/controller/contact_provider.dart';
import 'package:contact_with_object_box/model/contact_model.dart';
import 'package:contact_with_object_box/utils/colors.dart';
import 'package:contact_with_object_box/view/widgets/add_contact_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactPage extends ConsumerWidget {
  ContactPage({super.key});

  // controllers
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // List of contacts from Object-box
    final List<ContactEntity> contactList =
        ref.watch(contactProvider(search.text));
    return Scaffold(
      appBar: AppBar(
        // Animated search bar
        centerTitle: true,
        title: AnimatedCrossFade(
            firstChild: const Text(
              'Contacts',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            secondChild: TextField(
              controller: search,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                hintText: "Search contacts",
                suffixIcon: IconButton(
                  onPressed: () {
                    search.clear();
                  },
                  icon: const Icon(Icons.clear),
                ),
              ),
              onChanged: (value) {
                ref.watch(ContactProvider(value));
              },
            ),
            crossFadeState: ref.watch(isSearch)
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: const Duration(milliseconds: 300)),
        actions: [
          IconButton(
            onPressed: () {
              ref.watch(isSearch.notifier).state = !ref.read(isSearch);
            },
            icon:  Icon(Icons.search,color: yellowColor,),
          ),
        ],
      ),
      body: contactList.isEmpty
          // if object-box is empty
          ? const Center(
              child: Text('No Contacts'),
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: contactList.length,
              itemBuilder: (context, index) {
                return ListTile(
                    title: Text(
                      contactList[index].name,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    subtitle: Text(contactList[index].phone),
                    leading: CircleAvatar(
                      backgroundColor: yellowDark.withOpacity(.7),
                      child: Text(
                        contactList[index].name[0].toUpperCase(),
                        style: TextStyle(
                            color:yellowColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                    trailing: PopupMenuButton(itemBuilder: (context) {
                      return [
                        // Edit ContactEntity
                        PopupMenuItem<int>(
                          child: TextButton(
                              onPressed: () {
                                name.text = contactList[index].name;
                                phone.text = contactList[index].phone;
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return localBottomSheet(
                                        formKey: formKey,
                                        name: name,
                                        phone: phone,
                                        ref: ref,
                                        onPressed: () {
                                          final ContactEntity contact =
                                              ContactEntity(
                                            id: contactList[index].id,
                                            name: name.text,
                                            phone: phone.text,
                                          );
                                          ref
                                              .watch(
                                                  contactProvider(search.text)
                                                      .notifier)
                                              .putContact(contact);
                                          Navigator.pop(context);
                                          name.clear();
                                          phone.clear();
                                        },
                                        context: context,
                                        isEdit: true);
                                  },
                                );
                              },
                              child: const Text('Edit')),
                        ),
                        // delete contact
                        PopupMenuItem(
                          child: TextButton(
                            onPressed: () {
                              ref
                                  .watch(contactProvider(search.text).notifier)
                                  .removeContact(contactList[index].id);
                              Navigator.pop(context);
                            },
                            child: const Text('  Delete'),
                          ),
                        )
                      ];
                    }));
              },
            ),
      // add-more-contacts
      floatingActionButton: SizedBox(
        height: 45,
        width: 100,
        child: FloatingActionButton.extended(
          onPressed: () {
            phone.clear();
            name.clear();

            showModalBottomSheet(
              context: context,
              builder: (context) {
                // bottom sheet for enter contact info
                return localBottomSheet(
                  ref: ref,
                  formKey: formKey,
                  name: name,
                  phone: phone,
                  context: context,
                  isEdit: false,
                  onPressed: () {
                    final ContactEntity contact =
                        ContactEntity(name: name.text, phone: phone.text);
                    ref
                        .watch(contactProvider(search.text).notifier)
                        .putContact(contact);
                    name.clear();
                    phone.clear();
                    Navigator.pop(context);
                  },
                );
              },
            );
          },
          label:const Text(
            'New Contact',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
          ),
          backgroundColor: yellowDark.withOpacity(.9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22.0),
          ),
        ),
      ),
    );
  }
}
