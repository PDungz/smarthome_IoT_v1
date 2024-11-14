import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/colors/app_colors.dart';
import '../../domain/entities/accesskey.dart';

class AccesskeySession extends StatefulWidget {
  final String iconAccessKey;
  final AccessKey accessKey;
  const AccesskeySession({
    super.key,
    required this.iconAccessKey,
    required this.accessKey,
  });

  @override
  State<AccesskeySession> createState() => _AccesskeySessionState();
}

class _AccesskeySessionState extends State<AccesskeySession> {
  bool isAction = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.backgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  padding: const EdgeInsets.all(8),
                  decoration: const ShapeDecoration(
                    color: AppColors.circleBackground,
                    shape: OvalBorder(),
                  ),
                  child: SvgPicture.asset(
                    widget.iconAccessKey, // Use the icon passed from HomeRoutes
                    color: AppColors.iconPrimaryColor,
                  ),
                ),
                const SizedBox(width: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.accessKey.accessKey,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isAction = !isAction;
                    });
                  },
                  icon: const Icon(
                    Icons.keyboard_control,
                    color: AppColors.iconPrimaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
