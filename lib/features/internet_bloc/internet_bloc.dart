import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';
import 'package:shopappbloc/constants/enums.dart';

part 'internet_event.dart';
part 'internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  StreamSubscription<ConnectivityResult>? connectivitySubscription;

  InternetBloc() : super(InternetLoading()) {
    connectivitySubscription =
        Connectivity().onConnectivityChanged.listen(_handleConnectivityChange);
  }

  void _handleConnectivityChange(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.wifi) {
      emit(InternetConnected(connectionType: ConnectionType.Wifi));
    } else if (connectivityResult == ConnectivityResult.mobile) {
      emit(InternetConnected(connectionType: ConnectionType.Mobile));
    } else if (connectivityResult == ConnectivityResult.none) {
      emit(InternetDisconnected());
    }
  }

  @override
  Future<void> close() {
    connectivitySubscription?.cancel();
    return super.close();
  }
}
