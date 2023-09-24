import 'package:calculadora_imc/models/historic.dart';
import 'package:calculadora_imc/providers/hitoric_provider.dart';
import 'package:calculadora_imc/providers/imc_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HistoricScreen extends ConsumerWidget {
  const HistoricScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(imcProvider);
    final historic = ref.watch(historicProvider);

    void removeItem(Historic item) {
      ref.read(historicProvider.notifier).removeFromHistoric(item);
    }

    Widget content = Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          'Oops...histórico vazio!!',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        SvgPicture.asset(
          'assets/images/empty.svg',
          width: 250,
          height: 250,
        )
      ]),
    );

    if (historic.isNotEmpty) {
      content = Scaffold(
        body: ListView.builder(
            itemCount: historic.length,
            itemBuilder: (BuildContext ctx, index) => Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: Dismissible(
                    background: Container(
                      color: Theme.of(context).colorScheme.error,
                    ),
                    key: ValueKey(historic[index]),
                    onDismissed: (direction) => removeItem(historic[index]),
                    child: ListTile(
                      leading: SvgPicture.asset(
                        historic[index].imc.gender == 'Feminino'
                            ? 'assets/images/female.svg'
                            : 'assets/images/male.svg',
                        width: 40,
                        height: 40,
                      ),
                      title: Text(
                        'IMC: ${historic[index].result.toStringAsFixed(1)}',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                          'Altura: ${historic[index].imc.height} cm - Peso: ${historic[index].imc.weight.toStringAsFixed(0)} kg'),
                    ),
                  ),
                )),
      );
    }

    return content;
  }
}
