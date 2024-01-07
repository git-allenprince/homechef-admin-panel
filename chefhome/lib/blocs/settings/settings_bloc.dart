// ignore_for_file: avoid_print, depend_on_referenced_packages, unnecessary_null_comparison

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:chefhome/models/models.dart';

import '../../repositories/repositories.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final RestaurantRepository _restaurantRepository;
  StreamSubscription? _restaurantSubscription;

  SettingsBloc({
    required RestaurantRepository restaurantRepository,
  })  : _restaurantRepository = restaurantRepository,
        super(SettingsLoading()) {
    on<LoadSettings>(_onLoadSettings);
    on<UpdateSettings>(_onUpdateSettings);

    _restaurantSubscription =
        _restaurantRepository.getRestaurant().listen((restaurant) {
      print(restaurant);

      add(
        LoadSettings(restaurant: restaurant),
      );
    });
  }

  void _onLoadSettings(
    LoadSettings event,
    Emitter<SettingsState> emit,
  ) {
    // Remove the unnecessary delay
    emit(SettingsLoaded(event.restaurant));
  }

  void _onUpdateSettings(
    UpdateSettings event,
    Emitter<SettingsState> emit,
  ) {
    if (event.isUpdateComplete) {
      _restaurantRepository.editRestaurantSettings(event.restaurant);
    }
    emit(SettingsLoaded(event.restaurant));
  }

  @override
  Future<void> close() async {
    _restaurantSubscription?.cancel();
    super.close();
  }
}
