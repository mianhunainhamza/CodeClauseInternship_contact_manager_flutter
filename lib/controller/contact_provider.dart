import 'package:contact_with_object_box/model/contact_model.dart';
import 'package:contact_with_object_box/objectbox.g.dart';
import 'package:contact_with_object_box/service/contact_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'contact_provider.g.dart';

@riverpod
class Contact extends _$Contact {
  @override
  List<ContactEntity> build(String search) {
    return searcMethod(search);
  }

  // List<ContactEntity> currentList(String str) {
  //   if (str.isNotEmpty) {
  //     List<ContactEntity> localList = sortedList(str);
  //     List<ContactEntity> list = [
  //       for (ContactEntity model in localList)
  //         if (model.name.startsWith(str)) model
  //     ];
  //     return list;
  //   } else {
  //     return searcMethod('');
  //   }
  // }

  List<ContactEntity> sortedList(String search) {
    final Query<ContactEntity> query = ContactServices.contactBox
        .query()
        .order(
          ContactEntity_.name,
        )
        .build();
    // final PropertyQuery<String> pq = query.property(ContactEntity_.name);
    // pq.distinct = true;

    return query.find();
  }

  searcMethod(String search) {
    final Query<ContactEntity> query = ContactServices.contactBox
        .query(search.isEmpty ? null : ContactEntity_.name.contains(search))
        .build();
    if (search.isEmpty) {
      return sortedList(search);
    } else if (search.isNotEmpty) {
      return query.find();
    }
  }

  void putContact(ContactEntity contact) {
    ContactServices.contactBox.put(contact);
    state = List.from(sortedList(''));
  }

  void removeContact(int id) {
    ContactServices.contactBox.remove(id);
    state = List.from(sortedList(''));
  }
}

final isSearch = StateProvider((ref) => true);
