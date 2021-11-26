import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../awesome_ui_kit_theme.dart';
import 'awesome_input.dart';

class AwesomeSelect extends StatefulWidget {
  final bool debug;
  final bool enabled;
  final double? width;
  final int? initialValue;
  final String? title;
  final String? labelText;
  final String? errorText;
  final Function(int?)? onChanged;
  final List<AwesomeSelectItem?> items;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const AwesomeSelect({
    Key? key,
    this.debug = false,
    this.enabled = true,
    this.width,
    this.initialValue,
    this.title,
    this.labelText,
    this.errorText,
    required this.items,
    this.onChanged,
    this.validator,
    this.controller,
  })  : assert(initialValue == null || controller == null),
        super(key: key);

  @override
  _AwesomeSelectState createState() => _AwesomeSelectState();
}

class _AwesomeSelectState extends State<AwesomeSelect> {
  int? _tempValue;
  AwesomeSelectItem? _currentItem;
  late TextEditingController _controller;
  late FixedExtentScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    if (widget.controller != null) {
      _currentItem = _getCurrentItem(widget.controller!.text);
    }

    if (widget.initialValue != null) {
      _currentItem = _getCurrentItem(widget.initialValue);
    }

    _controller = widget.controller ?? TextEditingController();
    _controller.text = _currentItem?.text ?? '';
    _controller..addListener(() => setState(() {}));

    _scrollController = _setTheScrollController();
  }

  AwesomeSelectItem? _getCurrentItem(dynamic initialVal) {
    final _stub = AwesomeSelectItem(text: '', value: -1);

    if (initialVal is int) {
      return widget.items.firstWhere(
        (e) => e!.value.toInt() == initialVal,
        orElse: () => _stub,
      );
    }

    if (initialVal is String) {
      return widget.items.firstWhere(
        (e) => e!.text == initialVal,
        orElse: () => _stub,
      );
    }
  }

  FixedExtentScrollController _setTheScrollController() {
    return FixedExtentScrollController(
      initialItem: widget.items.indexOf(_currentItem),
    );
  }

  @override
  void dispose() {
    // _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AwesomeInput(
      onTap: () {
        setState(() {
          _currentItem = _getCurrentItem(_currentItem?.value);
          _scrollController = _setTheScrollController();
        });

        _showDialog(context);
      },
      readOnly: true,
      debug: widget.debug,
      controller: _controller,
      enabled: widget.enabled,
      labelText: widget.labelText,
      validator: widget.validator,
      errorText: widget.errorText,
      suffixIcon: Icon(
        Icons.arrow_drop_down_rounded,
        color: Theme.of(context).dividerColor,
      ),
    );
  }

  Future<bool?> _showDialog(BuildContext context) async {
    final complete = await showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      builder: (BuildContext context) {
        return Wrap(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 44,
                  color: widget.debug ? Colors.red[300] : null,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        child: Text(
                          'Отмена',
                          style:
                              AwesomeUiKitTheme.textTheme.bodyText2!.copyWith(
                            height: 1.2,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        onPressed: () => Navigator.pop(context, true),
                      ),
                      if (widget.title != null)
                        Text(
                          widget.title!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  height: 1.2, fontWeight: FontWeight.w500),
                        ),
                      TextButton(
                        child: Text(
                          'Готово',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                                  height: 1.2,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                        ),
                        onPressed: () {
                          final bool? isValid = widget.onChanged
                              ?.call(widget.items[_tempValue!]!.value);

                          if (isValid != null && isValid == false) return;

                          setState(() {
                            _controller.text = widget
                                .items[_scrollController.selectedItem]!.text;
                            _currentItem =
                                widget.items[_scrollController.selectedItem];
                            _scrollController = _setTheScrollController();
                          });

                          Navigator.pop(context, true);
                        },
                      )
                    ],
                  ),
                ),
                Container(
                  color: widget.debug ? Colors.yellow[300] : null,
                  height: MediaQuery.of(context).size.height * 0.27,
                  child: CupertinoPicker(
                    squeeze: 1.15,
                    itemExtent: 40,
                    diameterRatio: 1.5,
                    scrollController: _scrollController,
                    onSelectedItemChanged: (int value) {
                      setState(() => _tempValue = value);
                    },
                    children: [
                      ...widget.items.map((e) => Text(
                            e!.text,
                            style: TextStyle(fontSize: 24, height: 1.5),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
    if (complete == null) FocusManager.instance.primaryFocus!.unfocus();
  }
}

class AwesomeSelectItem {
  final String text;
  final int value;
  AwesomeSelectItem({
    required this.text,
    required this.value,
  });

  AwesomeSelectItem copyWith({
    String? text,
    int? value,
  }) {
    return AwesomeSelectItem(
      text: text ?? this.text,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'value': value,
    };
  }

  factory AwesomeSelectItem.fromMap(Map<String, dynamic> map) {
    return AwesomeSelectItem(
      text: map['text'] != null ? map['text'] : '',
      value: map['value'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AwesomeSelectItem.fromJson(String source) =>
      AwesomeSelectItem.fromMap(json.decode(source));

  @override
  String toString() => 'AwesomeSelectItem(text: $text, value: $value)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AwesomeSelectItem &&
        other.text == text &&
        other.value == value;
  }

  @override
  int get hashCode => text.hashCode ^ value.hashCode;
}
