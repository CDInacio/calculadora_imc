import 'package:calculadora_imc/providers/hitoric_provider.dart';
import 'package:calculadora_imc/providers/imc_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResultScreen extends ConsumerWidget {
  const ResultScreen({super.key});

  void _showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      duration: Duration(seconds: 3),
      content: Text('Adicionado ao historico'),
    ));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(imcProvider);
    final result = (state.weight) / (state.height / 100 * state.height / 100);

    String classification = 'Baixo peso';

    if (result >= 19 && result <= 24) {
      classification = 'Peso normal';
    } else if (result >= 25 && result <= 29) {
      classification = 'Sobrepeso';
    } else if (result >= 30 && result <= 34) {
      classification = 'Obesidade Grau I';
    } else if (result >= 30 && result <= 39) {
      classification = 'Obesidade Grau II';
    } else if (result >= 40) {
      classification = 'Obesidade Grau III';
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Voltar'), actions: [
        IconButton(
            icon: const Icon(Icons.home),
            tooltip: 'Página principal',
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              ref.read(imcProvider.notifier).reset();
            })
      ]),
      body: WillPopScope(
        onWillPop: () async {
          ref.read(imcProvider.notifier).reset();
          return true;
        },
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'IMC: ${result.toStringAsFixed(1)}',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontWeight: FontWeight.bold),
            ),
            Text('Classificação: $classification',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () {
                  ref
                      .read(historicProvider.notifier)
                      .addToHistoric(imc: state, result: result);
                  _showSnackBar(context);
                },
                child: const Text(
                  'Salvar resultado',
                ))
          ],
        )),
      ),
    );
  }
}
