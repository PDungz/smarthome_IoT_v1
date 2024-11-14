import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthome_iot/core/enums/status_state.dart';
import 'package:smarthome_iot/features/profile/data/datasources/account_firestore_datasource.dart';
import 'package:smarthome_iot/features/profile/data/repositories/account_repository_impl.dart';
import 'package:smarthome_iot/features/profile/presentation/logic_holder/bloc/account_info_bloc.dart';

import '../../../core/constants/colors/app_colors.dart';
import 'views/avatar_section.dart';
import 'views/text_field_form_session.dart';

class ProfileRoutes extends StatefulWidget {
  final String userId;
  const ProfileRoutes({
    super.key,
    required this.userId,
  });

  @override
  State<ProfileRoutes> createState() => _ProfileRoutesState();
}

class _ProfileRoutesState extends State<ProfileRoutes> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AccountInfoBloc>(
      create: (context) => AccountInfoBloc(AccountRepositoryImpl(
          accountFirestoreDatasource: AccountFirestoreDatasourceImpl()))
        ..add(FetchAccountInfo(userId: widget.userId)),
      child: BlocBuilder<AccountInfoBloc, AccountInfoState>(
        builder: (context, state) {
          if (state.status == StatusState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            appBar: AppBar(
              title: const Padding(
                padding: EdgeInsets.only(right: 56),
                child: Center(child: Text('Profile account')),
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(12),
                      child: Center(child: AvatarSection()),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8, top: 12, bottom: 16),
                            child: Text(
                              "Information",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge
                                  ?.copyWith(
                                      color: AppColors.textSecondarColor),
                            ),
                          ),
                          TextFieldFormSession(
                            userId: widget.userId,
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
