// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc_cats/cat_bloc/cat_state.dart';
import 'package:bloc_cats/cat_bloc/model/cat.dart';
import 'package:bloc_cats/cat_bloc/repository/cat.repository.dart';

class CatsCubit extends Cubit<CatsState> {
  final CatsRepository _catsRepository;
  CatsCubit(this._catsRepository) : super(CatsInitial());

  void getCats() async {
    try {
      emit(CatsLoading());
      await Future.delayed(Duration(seconds: 3));

      await _catsRepository.getCats().then((responseValue) {
        if (responseValue != null && responseValue.isNotEmpty) {
          emit(CatsCompleted(catModelList: responseValue));
        } else {
          emit(CatsError("Hata Mesajı"));
        }
      }).onError((error, stackTrace) {
        debugPrint(error.toString());
        emit(CatsError("Bilinmeyen Hata"));
      });
    } on NetworkError catch (e) {
      emit(CatsError(e.errors.toString()));
    }
  }
}
