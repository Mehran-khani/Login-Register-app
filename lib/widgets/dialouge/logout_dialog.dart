import 'package:flutter/material.dart';
import 'package:login_register_app/widgets/dialouge/generic_dialog.dart';

Future<bool> showLogOutDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Log Out',
    content: "Are you sure you want to log out?",
    optionsBuilder: () => {
      'Cancle': false,
      'Log out': true,
    },
  ).then((value) => value ?? false);
}
