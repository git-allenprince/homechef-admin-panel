// ignore_for_file: deprecated_member_use, use_super_parameters

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/config/responsive.dart';
import '/blocs/blocs.dart';
import '/widgets/widgets.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const CustomDrawer(),
      body: CustomLayout(
        title: 'Settings',
        widgets: [
          _buildImage(context),
          Responsive.isDesktop(context) || Responsive.isWideDesktop(context)
              ? IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildBasicInformation(context),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildRestaurantDescription(context),
                      ),
                    ],
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBasicInformation(context),
                    const SizedBox(height: 10),
                    _buildRestaurantDescription(context),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        if (state is SettingsLoading) {
          return const SizedBox();
        }
        if (state is SettingsLoaded) {
          if (state.restaurant.imageUrl != null &&
              state.restaurant.imageUrl!.isNotEmpty) {
            return Container(
              height: 200,
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(state.restaurant.imageUrl!),
                  fit: BoxFit.cover,
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        } else {
          return const Text('Something went wrong.');
        }
      },
    );
  }

  Widget _buildRestaurantDescription(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        if (state is SettingsLoading) {
          return Center(
            child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary),
          );
        }
        if (state is SettingsLoaded) {
          return Container(
            padding: const EdgeInsets.all(20.0),
            color: Theme.of(context).colorScheme.background,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Homemaker Description',
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  maxLines: 5,
                  title: 'Description',
                  hasTitle: false,
                  initialValue: (state.restaurant.description != null)
                      ? state.restaurant.description!
                      : '',
                  onChanged: (value) {
                    context.read<SettingsBloc>().add(
                          UpdateSettings(
                            restaurant:
                                state.restaurant.copyWith(description: value),
                          ),
                        );
                  },
                  onFocusChanged: (hasFocus) {
                    context.read<SettingsBloc>().add(
                          UpdateSettings(
                            isUpdateComplete: true,
                            restaurant: state.restaurant,
                          ),
                        );
                  },
                ),
              ],
            ),
          );
        } else {
          return const Text('Something went wrong.');
        }
      },
    );
  }

  Widget _buildBasicInformation(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        if (state is SettingsLoading) {
          return Center(
            child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary),
          );
        }
        if (state is SettingsLoaded) {
          return Container(
            padding: const EdgeInsets.all(20.0),
            color: Theme.of(context).colorScheme.background,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Basic Information',
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  maxLines: 1,
                  title: 'Name',
                  hasTitle: true,
                  initialValue: (state.restaurant.name != null)
                      ? state.restaurant.name!
                      : '',
                  onChanged: (value) {
                    context.read<SettingsBloc>().add(
                          UpdateSettings(
                            restaurant: state.restaurant.copyWith(name: value),
                          ),
                        );
                  },
                  onFocusChanged: (hasFocus) {
                    context.read<SettingsBloc>().add(
                          UpdateSettings(
                            isUpdateComplete: true,
                            restaurant: state.restaurant,
                          ),
                        );
                  },
                ),
                CustomTextFormField(
                  maxLines: 1,
                  title: 'Image',
                  hasTitle: true,
                  initialValue: (state.restaurant.imageUrl != null)
                      ? state.restaurant.imageUrl!
                      : '',
                  onChanged: (value) {
                    context.read<SettingsBloc>().add(
                          UpdateSettings(
                            restaurant:
                                state.restaurant.copyWith(imageUrl: value),
                          ),
                        );
                  },
                  onFocusChanged: (hasFocus) {
                    context.read<SettingsBloc>().add(
                          UpdateSettings(
                            isUpdateComplete: true,
                            restaurant: state.restaurant,
                          ),
                        );
                  },
                ),
                CustomTextFormField(
                  maxLines: 1,
                  title: 'Tag',
                  hasTitle: true,
                  initialValue: (state.restaurant.tags != null)
                      ? state.restaurant.tags!.join(', ')
                      : '',
                  onChanged: (value) {
                    context.read<SettingsBloc>().add(
                          UpdateSettings(
                            restaurant: state.restaurant
                                .copyWith(tags: value.split(', ')),
                          ),
                        );
                  },
                  onFocusChanged: (hasFocus) {
                    context.read<SettingsBloc>().add(
                          UpdateSettings(
                            isUpdateComplete: true,
                            restaurant: state.restaurant,
                          ),
                        );
                  },
                ),
              ],
            ),
          );
        } else {
          return const Text('Something went wrong.');
        }
      },
    );
  }
}
