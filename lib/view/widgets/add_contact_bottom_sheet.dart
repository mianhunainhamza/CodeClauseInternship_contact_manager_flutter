import 'package:contact_with_object_box/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Padding localBottomSheet({
  required BuildContext context,
  required GlobalKey<FormState> formKey,
  required TextEditingController name,
  required TextEditingController phone,
  required WidgetRef ref,
  required Function() onPressed,
  required bool isEdit,
}) {
  return Padding(
    padding: EdgeInsets.only(
      bottom: MediaQuery.of(context).viewInsets.bottom,
      left: 30,
      right: 30,
    ),
    child: Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(
              height: 50,
            ),
            TextFormField(
              controller: name,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Name cannot be empty';
                }
                return null;
              },
              onChanged: (value) => name.text = value,
              decoration: InputDecoration(
                hintText: 'Enter your name',
                labelText: 'Name',
                labelStyle: TextStyle(
                  color: yellowColor
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(20)),
                focusedBorder: OutlineInputBorder(
                  borderSide:  BorderSide(color: yellowColor),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              controller: phone,
              maxLength: 13,
              validator: (value) {
                RegExp regx = RegExp(r'^(?:[+0]9)?[0-9]{13}$');
                if (value == null || value.isEmpty) {
                  return 'Phone Number cannot be empty';
                } else if (!regx.hasMatch(value)) {
                  return 'Enter a valid phone number';
                }
                return null;
              },
              onChanged: (value) => phone.text = value,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                counterText: '',
                labelStyle: TextStyle(
                    color: yellowColor
                ),
                hintText: 'Enter phone number',
                labelText: 'Phone',
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(20)),
                errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(20)),
                focusedBorder: OutlineInputBorder(
                  borderSide:  BorderSide(color: yellowColor),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Row(
              children: [
                const Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    name.clear();
                    phone.clear();
                  },
                  child: Text('Cancel',style: TextStyle(color: yellowColor),),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      onPressed();
                    }
                  },
                  child: Text('Add',style: TextStyle(color: yellowColor),),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}
