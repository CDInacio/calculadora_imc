import 'package:calculadora_imc/models/historic.dart';
import 'package:calculadora_imc/models/imc.dart';
import 'package:riverpod/riverpod.dart';

class HistoricProvider extends StateNotifier<List<Historic>> {
  HistoricProvider() : super([]);

  void addToHistoric({required Imc imc, required double result}) {
    final historicItem = Historic(imc: imc, result: result);

    final itemExists = state.any((element) => element.imc == imc);

    if (!itemExists) {
      state = [...state, historicItem];
    }
  }

  void removeFromHistoric(Historic item) {
    state = state.where((element) => element != item).toList();
  }
}

final historicProvider =
    StateNotifierProvider<HistoricProvider, List<Historic>>(
        (ref) => HistoricProvider());
