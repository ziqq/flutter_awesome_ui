import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_awesome_ui/flutter_awesome_ui.dart';

import 'package:example/models/models.dart';
import 'package:example/ui/widgets/widgets.dart';

class SearchView extends AbstractPlatformSearchDelegate {
  final List<PlatformItem> Function(String text) search;

  SearchView(this.search);

  Widget buildResults(BuildContext context) {
    final List<PlatformItem> result = search(query);
    return PlatformList(result);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<PlatformItem> result = search(query);
    return PlatformList(result);
  }

  @override
  Widget buildScaffold(Widget? body, BuildContext context) {
    return AwesomeSearchLayout(
      body: body,
      focusNode: focusNode,
      searchController: queryTextController,
      onSearch: (String _) {
        showResults(context);
      },
      onClear: () {
        close(context, null);
      },
    );
  }
}
