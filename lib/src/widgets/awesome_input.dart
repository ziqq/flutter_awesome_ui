import 'package:flutter/material.dart';

import '../awesome_ui_kit_theme.dart';

class AwesomeInput extends StatefulWidget {
  final bool debug;
  final bool enabled;
  final bool readOnly;
  final bool autofocus;
  final bool obscureText;
  final double? width;
  final double? height;
  final double padding;
  final int? maxLines;
  final int? maxLength;
  final Color? textColor;
  final Color? labelColor;
  final String? hintText;
  final String? labelText;
  final String? errorText;
  final String? helperText;
  final String? counterText;
  final String? initialValue;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final FocusNode? focusNode;
  final BorderRadius? borderRadius;
  final void Function()? onTap;
  final EdgeInsetsGeometry? margin;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final Iterable<String>? autofillHints;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final BoxConstraints? suffixIconConstraints;
  final String? Function(String?)? onFieldSubmitted;
  final TextCapitalization textCapitalization;

  const AwesomeInput({
    Key? key,
    this.debug = false,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.obscureText = false,
    this.width,
    this.height,
    this.padding = 16,
    this.borderRadius,
    this.maxLines,
    this.maxLength,
    this.textColor,
    this.labelColor,
    this.hintText,
    this.labelText,
    this.errorText,
    this.helperText,
    this.counterText,
    this.initialValue,
    this.suffixIcon,
    this.prefixIcon,
    this.focusNode,
    this.onTap,
    this.margin,
    this.keyboardType,
    this.onChanged,
    this.autofillHints,
    this.textInputAction,
    this.controller,
    this.validator,
    this.suffixIconConstraints,
    this.onFieldSubmitted,
    this.textCapitalization = TextCapitalization.none,
  })  : assert(initialValue == null || controller == null),
        super(key: key);

  @override
  _AwesomeInputState createState() => _AwesomeInputState();
}

class _AwesomeInputState extends State<AwesomeInput> {
  final _key = GlobalKey<FormFieldState<String>>();
  late TextEditingController _controller;
  late FocusNode _focusNode;
  late double _labelOffset;
  late double _height;

  double _labelOffsetEmpty = 3;
  double _labelOffsetNotEmpty = 2.2;

  @override
  void initState() {
    _height = widget.height ?? AwesomeUiKitTheme.buttonSizes.large;

    _labelOffset = _height / _labelOffsetEmpty;

    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_focusNodeHandler);

    _controller = widget.controller ?? TextEditingController();
    _controller..addListener(() => setState(() {}));

    if (widget.initialValue != null) {
      _controller.text = widget.initialValue!;

      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );
    }

    if (_controller.text.isNotEmpty) {
      print('LABEL_OFFSET_NOT_EMPTY');
      _labelOffset = _height / _labelOffsetNotEmpty;
    }
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.removeListener(_focusNodeHandler);
    _controller.dispose();
    super.dispose();
  }

  void _focusNodeHandler() {
    if (widget.enabled && !widget.readOnly) {
      print('IS_NOT_READONLY');
      if (_focusNode.hasFocus) {
        setState(() {
          _labelOffset = _height / _labelOffsetNotEmpty;
        });
      }

      if (_controller.text.isEmpty && !_focusNode.hasFocus) {
        setState(() {
          _labelOffset = _height / _labelOffsetEmpty;
        });
      }
    }

    if (widget.readOnly) {
      print('IS_READONLY');
      if (_controller.text.length > 1) {
        print('LABEL_OFFSET_NOT_EMPTY');
        setState(() {
          _labelOffset = _height / _labelOffsetNotEmpty;
        });
      } else {
        print('LABEL_OFFSET_EMPTY');
        setState(() {
          _labelOffset = _height / _labelOffsetEmpty;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      gapPadding: 0,
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
    );

    return Stack(
      key: widget.key,
      clipBehavior: Clip.none,
      children: [
        Container(
          height: _height,
          width: widget.width,
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(bottom: 20),
          padding: EdgeInsets.symmetric(horizontal: widget.padding),
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
            color: widget.debug
                ? Colors.red[300]
                : widget.enabled
                    ? Colors.transparent
                    : Theme.of(context).disabledColor,
            border: Border.all(
              width: 1,
              color: widget.debug
                  ? Colors.red[300]!
                  : widget.errorText != null
                      ? Theme.of(context).errorColor
                      : widget.enabled
                          ? Theme.of(context).dividerColor
                          : Colors.transparent,
            ),
          ),
        ),
        Container(
          height: _height,
          color: widget.debug ? Colors.blue[300] : Colors.transparent,
          child: TextFormField(
            onTap: () {
              widget.onTap?.call();

              if (!widget.readOnly) {
                FocusScope.of(context).requestFocus(_focusNode);
              }
            },
            key: _key,
            focusNode: _focusNode,
            controller: _controller,
            enabled: widget.enabled,
            readOnly: widget.readOnly,
            maxLines: widget.maxLines,
            onChanged: widget.onChanged,
            autofocus: widget.autofocus,
            maxLength: widget.maxLength,
            validator: widget.validator,
            obscureText: widget.obscureText,
            keyboardType: widget.keyboardType,
            autofillHints: widget.autofillHints,
            textInputAction: widget.textInputAction,
            onFieldSubmitted: widget.onFieldSubmitted,
            textAlignVertical: TextAlignVertical.bottom,
            textCapitalization: widget.textCapitalization,
            cursorColor: widget.textColor ??
                Theme.of(context).textTheme.bodyText1?.color,
            style: TextStyle(
              color: widget.enabled
                  ? widget.textColor ??
                      Theme.of(context).textTheme.bodyText1?.color
                  : Theme.of(context).textTheme.caption?.color,
            ),
            decoration: InputDecoration(
              isCollapsed: true,
              alignLabelWithHint: true,
              labelStyle: TextStyle(
                height: 4.4,
                fontSize: 16.0,
                backgroundColor: Colors.transparent,
                color: widget.labelColor ??
                    Theme.of(context).textTheme.caption?.color,
              ),
              contentPadding: EdgeInsets.only(
                top: _labelOffset,
                left: widget.padding,
                right: widget.padding,
              ),
              fillColor: Colors.transparent,
              border: outlineInputBorder,
              focusedBorder: outlineInputBorder,
              enabledBorder: outlineInputBorder,
              disabledBorder: outlineInputBorder,
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).errorColor),
                borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
              ),
              filled: !widget.enabled,
              hintText: widget.hintText,
              labelText: widget.labelText,
              counterText: widget.counterText,
              prefixIcon: widget.prefixIcon,
            ),
          ),
        ),
        if (widget.helperText != null)
          Positioned(
            top: _height - 2,
            child: Container(
              padding: EdgeInsets.only(
                left: widget.padding,
                right: widget.padding,
                top: widget.padding / 4,
              ),
              child: Text(
                widget.helperText!,
                style:
                    Theme.of(context).textTheme.caption!.copyWith(height: 1.3),
              ),
            ),
          ),
        if (widget.errorText != null)
          Positioned(
            top: _height - 2,
            child: Container(
              padding: EdgeInsets.only(
                left: widget.padding,
                right: widget.padding,
                top: widget.padding / 4,
              ),
              child: Text(
                widget.errorText!,
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(height: 1.3, color: Theme.of(context).errorColor),
              ),
            ),
          ),
        if (widget.suffixIcon != null)
          Positioned(
            top: _height / 3.5,
            right: widget.padding / 2,
            child: Container(child: widget.suffixIcon),
          )
      ],
    );
  }
}
