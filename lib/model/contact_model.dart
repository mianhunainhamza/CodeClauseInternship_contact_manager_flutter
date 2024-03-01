import 'package:objectbox/objectbox.dart';

@Entity()
class ContactEntity {
  @Id()
  int id;
  String name;
  String phone;
  ContactEntity({this.id = 0, required this.name, required this.phone});
}
