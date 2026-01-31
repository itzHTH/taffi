import 'package:flutter/material.dart';

class AsyncButton extends StatefulWidget {
  final Future<void> Function()? onPressedAsync;
  final VoidCallback? onPressed;
  final Widget child;
  final ButtonStyle? style;
  final bool fullWidth;

  const AsyncButton({
    super.key,
    this.onPressedAsync,
    this.onPressed,
    required this.child,
    this.style,
    this.fullWidth = false,
  });

  @override
  State<AsyncButton> createState() => _AsyncButtonState();
}

class _AsyncButtonState extends State<AsyncButton> {
  bool _isLoading = false;

  Future<void> _handlePress() async {
    if (_isLoading) return;

    if (widget.onPressedAsync != null) {
      setState(() => _isLoading = true);
      try {
        await widget.onPressedAsync!();
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    } else if (widget.onPressed != null) {
      widget.onPressed!();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget button = ElevatedButton(
      onPressed: _isLoading ? null : _handlePress,
      style: widget.style,
      child: _isLoading
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white.withValues(alpha: 0.7)),
                  ),
                ),
                SizedBox(width: 8),
                widget.child,
              ],
            )
          : widget.child,
    );

    if (widget.fullWidth) {
      return SizedBox(width: double.infinity, child: button);
    }

    return button;
  }
}
