import 'package:flutter/material.dart';

import '../../../../../l10n/generated/app_localizations.dart';

class ForgotPasswordSection extends StatelessWidget {
  const ForgotPasswordSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Text(
            '${AppLocalizations.of(context)!.forgot_password}?',
          ),
        ),
      ),
    );
  }
}
