import 'package:barrier_free_life/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MAppbar extends StatelessWidget {
  const MAppbar({
    super.key,
  });
 
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      backgroundColor: colorBg,
      actions: [
        IconButton(
          onPressed: () {
            context.goNamed('settings');
          },
          icon: const Icon(
            Icons.settings_outlined,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
