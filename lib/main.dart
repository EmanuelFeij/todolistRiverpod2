import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      themeMode: ThemeMode.dark,
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("Building chit");
    return Scaffold(
        appBar: AppBar(
          title: Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              final count = ref.watch(counterProvider);
              final text =
                  count == null ? "Press The button" : count.toString();
              return Text(text);
            },
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextButton(
                onPressed: ref.read(counterProvider.notifier).increment,
                child: const Text("Press Me"))
          ],
        ));
  }
}

// StateNotifierProvider
final counterProvider =
    StateNotifierProvider<Counter, int?>((ref) => Counter());

// StateNotifier
class Counter extends StateNotifier<int?> {
  Counter() : super(null);
  void increment() => state = state == null ? 1 : state + 1;
}

// extension to sum two optionals num's
// operator +
// null + 1 = null
// 1 + null = 1
extension SomeExtension<T extends num> on T? {
  T? operator +(T? other) {
    final shadow = this;
    if (shadow != null) {
      return shadow + (other ?? 0) as T;
    }
    return null;
  }
}
