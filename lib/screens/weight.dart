import 'package:calculadora_imc/providers/imc_provider.dart';
import 'package:calculadora_imc/screens/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WeightScreen extends ConsumerWidget {
  const WeightScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(imcProvider);

    var imgLink = state.gender == 'Feminino'
        ? 'assets/images/woman_weight.svg'
        : 'assets/images/man_weight.svg';

    return Scaffold(
      appBar: AppBar(title: Text('Voltar')),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Peso',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground)),
          const SizedBox(
            height: 40,
          ),
          SvgPicture.asset(
            imgLink,
            width: 150,
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            '${state.weight.toStringAsFixed(0)} kg',
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Theme.of(context).colorScheme.onSurface),
          ),
          Container(
              width: 320,
              child: Slider(
                  min: 30,
                  max: 200,
                  divisions: 100,
                  value: state.weight,
                  label: '${state.weight.toStringAsFixed(0)} kg',
                  onChanged: (double value) =>
                      ref.watch(imcProvider.notifier).setValue(weight: value))),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => ResultScreen()));
            },
            child: Text('Calcular IMC'),
          )
        ],
      )),
    );
  }
}
