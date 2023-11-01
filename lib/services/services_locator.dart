import 'package:get_it/get_it.dart';
import 'package:shopappbloc/features/internet_bloc/internet_bloc.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    // to bloc
    sl.registerFactory(() => InternetBloc());
    // sl.registerFactory(() => GalleryBloc(sl()));
    // use case
  }
}
