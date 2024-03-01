import 'package:contact_with_object_box/model/contact_model.dart';
import 'package:contact_with_object_box/objectbox.g.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ContactServices {
  late final Store store;
  static late final Box<ContactEntity> contactBox;
  ContactServices._create(this.store) {
    contactBox = store.box<ContactEntity>();
  }
  static Future<ContactServices> createBox() async {
    final docdir = await getApplicationDocumentsDirectory();
    final store = await openStore(
      directory: join(docdir.path, 'contacts'),
    );
    return ContactServices._create(store);
  }
}
