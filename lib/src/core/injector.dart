import 'package:get_it/get_it.dart';
import 'package:qr_shared_app/src/core/services/services.dart';

final GetIt di = GetIt.instance;

void configureDependencies() {
    di.registerSingleton<TransferService>(TransferServiceImpl());
}
