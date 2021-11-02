import 'package:flutter/material.dart';

///Widget that draw a beautiful checkbox rounded. Provided with animation if wanted
class AwesomeCheckBoxRounded extends StatefulWidget {
  const AwesomeCheckBoxRounded({
    Key? key,
    this.size,
    this.isChecked,
    this.borderColor,
    this.checkedColor,
    this.uncheckedColor,
    this.checkedWidget,
    this.uncheckedWidget,
    this.animationDuration,
    required this.onTap,
  }) : super(key: key);

  ///Define the size of the checkbox
  final double? size;

  ///Define wether the checkbox is marked or not
  final bool? isChecked;

  ///Define the border of the widget
  final Color? borderColor;

  ///Define the color that is shown when Widgets is checked
  final Color? checkedColor;

  ///Define the color that is shown when Widgets is unchecked
  final Color? uncheckedColor;

  ///Define the widget that is shown when Widgets is checked
  final Widget? checkedWidget;

  ///Define the widget that is shown when Widgets is unchecked
  final Widget? uncheckedWidget;

  ///Define Function that os executed when user tap on checkbox
  final Function(bool?) onTap;

  ///Define the duration of the animation. If any
  final Duration? animationDuration;

  @override
  _AwesomeCheckBoxStateRounded createState() => _AwesomeCheckBoxStateRounded();
}

class _AwesomeCheckBoxStateRounded extends State<AwesomeCheckBoxRounded> {
  late Duration animationDuration;
  late Widget uncheckedWidget;
  late Widget checkedWidget;
  late Color uncheckedColor;
  late Color checkedColor;
  late Color borderColor;
  late bool isChecked;
  late double size;

  @override
  void initState() {
    super.initState();
    size = widget.size ?? 24.0;
    isChecked = widget.isChecked ?? false;
    borderColor = widget.borderColor ?? Colors.grey;
    checkedColor = widget.checkedColor ?? Colors.blue;
    uncheckedColor = widget.uncheckedColor ?? Colors.transparent;
    animationDuration = widget.animationDuration ?? Duration(milliseconds: 100);
    uncheckedWidget = widget.uncheckedWidget != null
        ? SizedBox(child: widget.uncheckedWidget)
        : const SizedBox.shrink();
    checkedWidget = widget.checkedWidget ??
        Icon(Icons.check_rounded, color: Colors.white, size: size / 1.2);
  }

  @override
  void didChangeDependencies() {
    borderColor = widget.borderColor ?? Theme.of(context).dividerColor;
    checkedColor = widget.checkedColor ?? Theme.of(context).accentColor;
    uncheckedColor =
        widget.uncheckedColor ?? Theme.of(context).scaffoldBackgroundColor;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() => isChecked = !isChecked);
        widget.onTap(isChecked);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size / 2),
        child: AnimatedContainer(
          width: size,
          height: size,
          duration: animationDuration,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size / 2),
            color: isChecked ? checkedColor : uncheckedColor,
            border: Border.all(
              color: isChecked
                  ? checkedColor
                  : widget.uncheckedColor != null
                      ? uncheckedColor
                      : borderColor,
            ),
          ),
          child: isChecked ? checkedWidget : uncheckedWidget,
        ),
      ),
    );
  }
}
