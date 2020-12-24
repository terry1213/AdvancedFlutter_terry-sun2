import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../counter.dart';

/// {@template counter_view}
/// A [StatelessWidget] which reacts to the provided
/// [CounterCubit] state and notifies it in response to user input.
/// {@endtemplate}
class CounterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Counter&Factorial')),
      body: Center(
        child: BlocBuilder<CounterCubit, int>(
          builder: (context, state) {
            return Text('$state', style: textTheme.headline2);
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            key: const Key('counterView_increment_floatingActionButton'),
            child: const Icon(Icons.add),
            onPressed: () => context.read<CounterCubit>().increment(),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            key: const Key('counterView_decrement_floatingActionButton'),
            child: const Icon(Icons.remove),
            onPressed: () => context.read<CounterCubit>().decrement(),
          ),
          const SizedBox(height: 8),
          BlocBuilder<CounterCubit, int>(
            builder: (context, state) {
              return FloatingActionButton(
                child: const Icon(Icons.calculate),
                onPressed: () {
                  if (state > 0 )
                    factorial(state);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

void factorial(int num) {

  const seed = IndexedPair(0, 1, 0);

  Rx
      .range(1, num)
      .scan((IndexedPair seq, _, __) => IndexedPair.next(seq), seed)
      .listen(print, onDone: () => print('factorial calculation finish!'));
}

class IndexedPair {
  final int n1, n2, index;

  const IndexedPair(this.n1, this.n2, this.index);

  factory IndexedPair.next(IndexedPair prev) => IndexedPair(
      prev.n1 + 1, (prev.n1 + 1) * prev.n2, prev.index + 1);

  @override
  String toString() => '$index: $n2';
}