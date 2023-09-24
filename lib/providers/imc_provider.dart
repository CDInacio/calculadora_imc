import 'package:calculadora_imc/models/imc.dart';
import 'package:riverpod/riverpod.dart';

final initialValue = Imc(gender: '', height: 120, weight: 30);

class ImcNotifier extends StateNotifier<Imc> {
  ImcNotifier() : super(initialValue);

  void setValue({String? gender, double? height, double? weight}) {
    final updatedImc = Imc(
        gender: gender ?? state.gender,
        height: height ?? state.height,
        weight: weight ?? state.weight);

    state = updatedImc;
  }

  void reset() {
    state = initialValue;
  }
}

final imcProvider =
    StateNotifierProvider<ImcNotifier, Imc>((ref) => ImcNotifier());
