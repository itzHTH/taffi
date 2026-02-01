import 'package:flutter/material.dart';

class AuthButtonWidget extends StatefulWidget {
  const AuthButtonWidget({
    super.key,
    required this.onPressed,
    required this.text,
    this.isLoading = false,
  });

  final Future<void> Function() onPressed;
  final String text;
  final bool isLoading;

  @override
  State<AuthButtonWidget> createState() => _AuthButtonWidgetState();
}

class _AuthButtonWidgetState extends State<AuthButtonWidget> {
  bool isLoadingLocal = false;

  @override
  Widget build(BuildContext context) {
    final isLoading = isLoadingLocal || widget.isLoading;

    return AbsorbPointer(
      absorbing: isLoading,
      child: ElevatedButton(
        onPressed: !isLoading
            ? () async {
                setState(() {
                  isLoadingLocal = true;
                });
                await widget.onPressed();
                if (mounted) {
                  setState(() {
                    isLoadingLocal = false;
                  });
                }
              }
            : null,
        style: ElevatedButton.styleFrom(fixedSize: Size(MediaQuery.widthOf(context), 60)),
        child: isLoading
            ? const CircularProgressIndicator()
            : Text(widget.text, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
