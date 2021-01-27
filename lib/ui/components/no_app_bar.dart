import 'package:flutter/material.dart';

class NoAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) => Container();

  @override
  final Size preferredSize = const Size.fromHeight(0.0);
}