import 'package:flutter/material.dart';

void snackbarMassege(BuildContext context , String massege , {Color? background}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content:
    Text(massege),
    backgroundColor: background,
  ),
  );
}