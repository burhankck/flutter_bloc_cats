import 'package:bloc_cats/cat_bloc/model/cat.dart';

abstract class CatsState {
  const CatsState();
}

class CatsInitial extends CatsState {
  const CatsInitial();
}

class CatsLoading extends CatsState {
  const CatsLoading();
}

class CatsCompleted extends CatsState {
  final List<Cat?> catModelList;

  CatsCompleted({required this.catModelList});
}

class CatsError extends CatsState {
  final String message;

  CatsError(this.message);
}
