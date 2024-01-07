// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/blocs/blocs.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        if (state is SettingsLoading) {
          return AppBar(
            title: Text(
              'Your HomeMaker Name',
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(color: Colors.white),
            ),
            centerTitle: false,
          );
        }
        if (state is SettingsLoaded) {
          return AppBar(
            title: Text(
              (state.restaurant.name == null)
                  ? 'Set a Name for Your Homemaker'
                  : state.restaurant.name!,
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(color: Colors.white),
            ),
            centerTitle: false,
          );
        } else {
          return const Text('Something went wrong.');
        }
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
