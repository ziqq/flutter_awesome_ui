import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

class AwesomeUiCupertinoLayout extends StatefulWidget {
  final String title;
  final Widget? leading;
  final Widget? trailing;
  final List<Widget> body;
  final String? backButtonTitle;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsDirectional? appBarPadding;

  AwesomeUiCupertinoLayout({
    Key? key,
    required this.body,
    required this.title,
    this.contentPadding,
    this.backButtonTitle,
    this.leading,
    this.trailing,
    this.appBarPadding,
  }) : super(key: key);

  @override
  _AwesomeUiCupertinoLayoutState createState() =>
      _AwesomeUiCupertinoLayoutState();
}

class _AwesomeUiCupertinoLayoutState extends State<AwesomeUiCupertinoLayout> {
  bool _showAppbar = false;
  GlobalKey _appBarKey = GlobalKey();
  late ScrollController _scrollController;

  final Duration _animatedFadeDuration = Duration(milliseconds: 150);

  @override
  void initState() {
    _scrollController = ScrollController()..addListener(_appBarScrollHandler);
    super.initState();
  }

  void _appBarScrollHandler() async {
    final keyContext = _appBarKey.currentContext;

    if (keyContext != null) {
      final box = keyContext.findRenderObject() as RenderBox;
      final height = box.size.height;

      if (_scrollController.offset.round() > height) {
        setState(() => _showAppbar = true);
      } else {
        setState(() => _showAppbar = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: CupertinoScrollbar(
        controller: _scrollController,
        child: CustomScrollView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: <Widget>[
            // SliverPersistentHeader(
            //   pinned: true,
            //   delegate: SliverAppBarDelegate(
            //       // child: CupertinoSearchTextField(),
            //       ),
            // ),
            _buildAppBar(context),
            // SliverToBoxAdapter(
            //   child: Container(
            //     height: 40,
            //     color: Colors.green[300],
            //   ),
            // ),
            // SliverHidedHeader(
            //   child: Container(
            //     height: 40,
            //     padding: const EdgeInsets.symmetric(horizontal: 16.0),
            //     child: CupertinoSearchTextField(),
            //   ),
            // ),
            CupertinoSliverRefreshControl(
              onRefresh: () {
                return Future<void>.delayed(Duration(seconds: 1))
                  ..then((_) => print('REFRESH'));
              },
            ),
            SliverSafeArea(
              top: false, // Top safe area is consumed by the navigation bar.
              sliver: SliverToBoxAdapter(
                child: Container(
                  padding: widget.contentPadding,
                  child: Column(children: widget.body),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return CupertinoSliverNavigationBar(
      stretch: true,
      largeTitle: Text(widget.title, key: _appBarKey),
      padding: widget.appBarPadding ??
          const EdgeInsetsDirectional.only(start: 16, end: 12),
      middle: AnimatedOpacity(
        child: Text(widget.title),
        opacity: _showAppbar ? 1 : 0,
        duration: _animatedFadeDuration,
      ),
      leading: widget.leading,
      trailing: widget.trailing,
      previousPageTitle: widget.backButtonTitle,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      border: Border.all(color: Theme.of(context).scaffoldBackgroundColor),
    );
  }
}

class SliverAppBarDelegate implements SliverPersistentHeaderDelegate {
  // final Widget child;

  // SliverAppBarDelegate({required this.child});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Colors.red[300],
      // child: child,
    );
  }

  @override
  double get maxExtent => 40;

  @override
  double get minExtent => 40;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate _) => true;

  @override
  PersistentHeaderShowOnScreenConfiguration? get showOnScreenConfiguration =>
      PersistentHeaderShowOnScreenConfiguration();

  @override
  FloatingHeaderSnapConfiguration? get snapConfiguration =>
      FloatingHeaderSnapConfiguration();

  @override
  OverScrollHeaderStretchConfiguration? get stretchConfiguration =>
      OverScrollHeaderStretchConfiguration();

  @override
  TickerProvider? get vsync => throw UnimplementedError();
}

// Navigator.push(
//   context,
//   PageRouteBuilder<CupertinoFullscreenDialogTransition>(
//     pageBuilder: (BuildContext context,
//             Animation<double> anim1,
//             Animation<double> anim2) =>
//         SettingsView(),
//     transitionsBuilder: (BuildContext context,
//         Animation<double> animation,
//         Animation<double> secondaryAnimation,
//         Widget child) =>
//     CupertinoFullscreenDialogTransition(
//       primaryRouteAnimation: animation,
//       secondaryRouteAnimation: animation,
//       linearTransition: false,
//       child: child,
//     )));

class NetworkingPageHeader implements SliverPersistentHeaderDelegate {
  NetworkingPageHeader({
    required this.minExtent,
    required this.maxExtent,
  });
  final double minExtent;
  final double maxExtent;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/ronnie-mayo-361348-unsplash.jpg',
          fit: BoxFit.cover,
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.transparent, Colors.black54],
              stops: [0.5, 1.0],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              tileMode: TileMode.repeated,
            ),
          ),
        ),
        Positioned(
          left: 16.0,
          right: 16.0,
          bottom: 16.0,
          child: Text(
            'Lorem ipsum',
            style: TextStyle(
              fontSize: 32.0,
              color: Colors.white.withOpacity(titleOpacity(shrinkOffset)),
            ),
          ),
        ),
      ],
    );
  }

  double titleOpacity(double shrinkOffset) {
    // simple formula: fade out text as soon as shrinkOffset > 0
    return 1.0 - max(0.0, shrinkOffset) / maxExtent;
    // more complex formula: starts fading out text when shrinkOffset > minExtent
    //return 1.0 - max(0.0, (shrinkOffset - minExtent)) / (maxExtent - minExtent);
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  FloatingHeaderSnapConfiguration? get snapConfiguration => null;

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
