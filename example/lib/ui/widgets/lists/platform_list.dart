import 'package:flutter/material.dart';
import 'package:example/models/models.dart';

import '../widgets.dart';

class PlatformList extends StatelessWidget {
  final List<PlatformItem> items;

  const PlatformList(this.items);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (_, index) => PlatformListItem(items[index]),
    );
  }
}
