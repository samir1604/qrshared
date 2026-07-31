import 'dart:async';

import 'package:fpdart/fpdart.dart';
import 'package:qr_shared_app/src/core/domain/entities/failure.dart';

abstract interface class UseCase<SuccessType, Params> {
  FutureOr<Either<Failure, SuccessType>> call(Params params);
}

class NoParams {
  const NoParams();
}
