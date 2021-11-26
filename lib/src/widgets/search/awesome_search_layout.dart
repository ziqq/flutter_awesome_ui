import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_awesome_ui/src/awesome_ui_kit_theme.dart';

class AwesomeSearchLayout extends StatelessWidget {
  final Widget? body;
  final FocusNode? focusNode;
  final String? searchPlaceholder;
  final void Function()? onClear;
  final void Function(String)? onSearch;
  final TextEditingController? searchController;

  const AwesomeSearchLayout({
    this.searchPlaceholder = 'Поиск',
    this.searchController,
    this.onSearch,
    this.onClear,
    this.focusNode,
    this.body,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        transitionBetweenRoutes: true,
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        padding: EdgeInsetsDirectional.only(
          start: AwesomeUiKitTheme.padding,
          end: AwesomeUiKitTheme.padding,
        ),
        middle: CupertinoSearchTextField(
          focusNode: focusNode,
          onSubmitted: onSearch,
          controller: searchController,
          placeholder: searchPlaceholder,
          prefixIcon: Icon(Icons.search_rounded),
          prefixInsets: EdgeInsetsDirectional.fromSTEB(6, 5, 0, 5),
        ),
        trailing: CupertinoButton(
          child: const Text('Отменить'),
          padding: EdgeInsets.only(left: AwesomeUiKitTheme.padding / 2),
          onPressed: onClear,
        ),
      ),
      child: body ?? Container(),
    );
  }
}
