import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthome_iot/core/constants/icons/app_icons.dart';
import 'package:smarthome_iot/core/services/injection_container.dart';
import 'package:smarthome_iot/features/accesskey/data/repositories/accesskey_repository_impl.dart';
import 'package:smarthome_iot/features/accesskey/presentation/logic_holder/bloc/accesskey_bloc.dart';

import 'views/accesskey_session.dart';
import 'views/accesskey_session_loading.dart';

class ViewAccesskeyRoutes extends StatefulWidget {
  const ViewAccesskeyRoutes({super.key});

  @override
  State<ViewAccesskeyRoutes> createState() => _ViewAccesskeyRoutesState();
}

class _ViewAccesskeyRoutesState extends State<ViewAccesskeyRoutes> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AccessKeyBloc>(
      create: (context) =>
          AccessKeyBloc(AccessKeyRepositoryImpl(remoteDatasource: getIt()))
            ..add(LoadAccessKey()),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: BlocConsumer<AccessKeyBloc, AccessKeyState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is AccessKeyLoading) {
                return ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  scrollDirection: Axis.vertical,
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    return const ListTile(
                      title: AccesskeySessionLoading(),
                    );
                  },
                );
              } else if (state is AccessKeyLoaded) {
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: state.accesskey.length + 1,
                  itemBuilder: (context, index) {
                    if (index < state.accesskey.length) {
                      return ListTile(
                        title: AccesskeySession(
                          iconAccessKey: AppIcons.DOOR,
                          accessKey: state.accesskey[index],
                        ),
                      );
                    } else {
                      return const ListTile(title: SizedBox(height: 96));
                    }
                  },
                );
              }
              return Center(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  scrollDirection: Axis.vertical,
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    return const ListTile(
                      title: AccesskeySessionLoading(),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
