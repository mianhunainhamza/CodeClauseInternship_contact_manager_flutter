import 'package:contact_with_object_box/service/contact_services.dart';
import 'package:contact_with_object_box/service/theme_services.dart';
import 'package:contact_with_object_box/view/pages/contacts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ContactServices.createBox();
  await LocalSharePrefarences.create();
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      // Theme-Switcher
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: ContactPage(),
    );
  }
}
