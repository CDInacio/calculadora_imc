import 'package:calculadora_imc/providers/imc_provider.dart';
import 'package:calculadora_imc/screens/weight.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HeightScreen extends ConsumerWidget {
  const HeightScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(imcProvider);
    var imgLink = state.gender == 'Feminino'
        ? 'assets/images/woman_height.svg'
        : 'assets/images/man_height.svg';

    return Scaffold(
      appBar: AppBar(title: Text('Voltar')),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Altura',
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
            '${state.height.toStringAsFixed(0)} cm',
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Theme.of(context).colorScheme.onSurface),
          ),
          Container(
            width: 320,
            child: Slider(
                min: 120,
                max: 220,
                divisions: 100,
                value: state.height,
                label: '${state.height.toStringAsFixed(0)} cm',
                onChanged: (double value) =>
                    ref.watch(imcProvider.notifier).setValue(height: value)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => WeightScreen()));
            },
            child: Text(
              'Próximo',
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
          )
        ],
      )),
    );
  }
}
