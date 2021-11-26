import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_awesome_ui/flutter_awesome_ui.dart';

import 'package:example/data/data.dart';
import 'package:example/models/models.dart';
import 'package:example/ui/widgets/widgets.dart';
import 'package:example/ui/search/search_view.dart';

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class FirstDisabledFocusNode extends FocusNode {
  @override
  bool consumeKeyboardToken() => false;
}

class PlatformsView extends StatefulWidget {
  @override
  _PlatformsViewState createState() => _PlatformsViewState();
}

class _PlatformsViewState extends State<PlatformsView> {
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        showAwesomeSearch(
          context: context,
          delegate: SearchView(search),
        );
      }
      _focusNode.unfocus();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  List<PlatformItem> search(String text) {
    return platforms
        .where((e) => e.name.toLowerCase().contains(text.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: CupertinoPageScaffold(
        child: CupertinoScrollbar(
          child: CustomScrollView(
            slivers: [
              CupertinoSliverNavigationBar(
                // stretch: true,
                largeTitle: Text('Поиск'),
                backgroundColor: Colors.white,
                transitionBetweenRoutes: true,
                border: Border.all(width: 0, color: Colors.transparent),
              ),
              CupertinoSliverRefreshControl(
                refreshIndicatorExtent: 40,
                refreshTriggerPullDistance: 50,
                builder: (
                  context,
                  refreshState,
                  pulledExtent,
                  refreshTriggerPullDistance,
                  refreshIndicatorExtent,
                ) {
                  return Container(
                    height: 40,
                    child: CupertinoActivityIndicator(radius: 10),
                  );
                },
                onRefresh: () {
                  return Future<void>.delayed(Duration(seconds: 3))
                    ..then((_) => print('REFRESH'));
                },
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: CupertinoSearchTextField(
                    onTap: () {
                      showAwesomeSearch(
                        context: context,
                        delegate: SearchView(search),
                      );
                    },
                    prefixInsets: EdgeInsetsDirectional.fromSTEB(6, 5, 0, 5),
                    prefixIcon: Icon(Icons.search_rounded),
                    focusNode: AlwaysDisabledFocusNode(),
                    placeholder: 'Поиск',
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => PlatformListItem(platforms[index]),
                  childCount: platforms.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
