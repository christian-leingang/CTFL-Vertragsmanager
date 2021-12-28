import 'package:ctfl_vertragsmanager/constants/Color_Themes.dart';
import 'package:flutter/material.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Text title;
  final AppBar appBar;
  final List<Widget> widgets;
  final Image leading;

  /// you can add more fields that meet your needs

  const BaseAppBar({
    Key? key,
    required this.title,
    required this.appBar,
    required this.widgets,
    required this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: title,
      backgroundColor: ColorThemes.primaryColor,
      actions: widgets,
      leading: leading,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
