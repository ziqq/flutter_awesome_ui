import 'package:flutter/material.dart';
import 'package:example/models/models.dart';
import 'package:example/constants/app_constants.dart';

class PlatformListItem extends StatelessWidget {
  final PlatformItem item;

  const PlatformListItem(this.item);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding,
            vertical: kDefaultPadding / 2,
          ),
          child: Row(
            children: [
              item.asset,
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding / 2,
                ),
                child: Text(
                  item.name,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 1,
          indent: 57,
          thickness: 1,
          endIndent: kDefaultPadding,
        ),
      ],
    );
  }
}
