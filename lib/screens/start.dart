import 'package:calculadora_imc/providers/imc_provider.dart';
import 'package:calculadora_imc/screens/height.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StartScreen extends ConsumerWidget {
  StartScreen({super.key});

  var genders = ['Masculino', 'Feminino'];
  String? selectedGender;

  void _goToNextStep(BuildContext context, Widget) {}

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(imcProvider);
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Gênero',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground)),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => ref
                        .watch(imcProvider.notifier)
                        .setValue(gender: 'Feminino'),
                    child: Opacity(
                      opacity: state.gender == 'Feminino' ? 1 : 0.5,
                      child: SvgPicture.asset(
                        'assets/images/female.svg',
                        width: 130,
                        height: 130,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () => ref
                        .watch(imcProvider.notifier)
                        .setValue(gender: 'Masculino'),
                    child: Opacity(
                      opacity: state.gender == 'Masculino' ? 1 : 0.5,
                      child: SvgPicture.asset(
                        'assets/images/male.svg',
                        width: 130,
                        height: 130,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (state.gender.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Selecione um gênero'),
                      duration: Duration(seconds: 2),
                    ));
                    return;
                  }
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => const HeightScreen()));
                },
                child: Text(
                  'Próximo',
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
              )
            ]),
      ),
    ));
  }
}
