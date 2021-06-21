import 'dart:async';

import 'package:clean_architecture/core/usecase/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class UseCase<Output, Input> {
  FutureOr<Either<Failure, Output>> call(Input params);
}

class NoParams extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];

}