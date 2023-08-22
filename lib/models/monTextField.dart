// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MonTexfield extends StatelessWidget {
  const MonTexfield({
    Key? key,
    required this.label,
    required this.icon,
    required this.controller,
    required this.readOnly, this.onTap, 
  }) : super(key: key);

  final String label;
  final IconData icon;
 
  final TextEditingController controller;
  final bool readOnly;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: onTap,
      readOnly: readOnly,
      controller: controller,
      decoration:  InputDecoration(
        prefixIcon: Icon(icon, color: Colors.yellow[600], size: 30,), label: Text(label, style: const TextStyle(color: Colors.grey),)),);
  }
}
