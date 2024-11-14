import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic_holder/bloc/account_info_bloc.dart';

class AvatarSection extends StatelessWidget {
  const AvatarSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            BlocBuilder<AccountInfoBloc, AccountInfoState>(
              builder: (context, state) {
                final avatarUrl = state.accountDataFromFirestore?.avatarUrl;
                final localImageFile = state.updatedLocalImageFile;
                return Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.amber),
                  clipBehavior: Clip.hardEdge,
                  child: () {
                    if (localImageFile != null) {
                      return Image.file(
                        localImageFile,
                        fit: BoxFit.cover,
                      );
                    } else if (avatarUrl != null) {
                      return Image.network(
                        avatarUrl,
                        fit: BoxFit.cover,
                      );
                    } else {
                      return const FlutterLogo();
                    }
                  }(),
                );
              },
            ),
            Positioned(
              bottom: -5,
              right: 0,
              child: InkWell(
                onTap: () {
                  context.read<AccountInfoBloc>().add(PickImage());
                },
                child: const Icon(
                  Icons.camera_alt_rounded,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
