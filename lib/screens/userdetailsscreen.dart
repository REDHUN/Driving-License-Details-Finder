import 'package:flutter/material.dart';

class UserDetails extends StatelessWidget {
  UserDetails({super.key, required this.details});
  String details;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(details),
    );
  }
}
