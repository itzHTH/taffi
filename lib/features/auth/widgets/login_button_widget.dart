import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taffi/core/enums/status_enum.dart';
import 'package:taffi/features/auth/providers/login_provider.dart';
import 'package:taffi/features/auth/providers/register_provider.dart';

class AuthButtonWidget extends StatefulWidget {
  const AuthButtonWidget({
    super.key,
    required this.onPressed,
    this.isEnabled = true,
    required this.text,
  });

  final Future<void> Function() onPressed;
  final bool isEnabled;
  final String text;

  @override
  State<AuthButtonWidget> createState() => _AuthButtonWidgetState();
}

class _AuthButtonWidgetState extends State<AuthButtonWidget> {
  bool isLoadingLocal = false;

  @override
  Widget build(BuildContext context) {
    final loginProvider = context.watch<LoginProvider?>();
    final registerProvider = context.watch<RegisterProvider?>();
    bool isLoadingStatus =
        (loginProvider?.status == Status.loading) || (registerProvider?.status == Status.loading);

    return AbsorbPointer(
      absorbing: !widget.isEnabled || isLoadingLocal || isLoadingStatus,
      child: ElevatedButton(
        onPressed: widget.isEnabled && !isLoadingLocal && !isLoadingStatus
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
        child: isLoadingLocal || isLoadingStatus
            ? const CircularProgressIndicator()
            : Text(widget.text, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
