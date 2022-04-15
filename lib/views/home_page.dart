import 'package:flutter/material.dart';

import '../data/data.dart';
import '../presenters/presenters.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> implements ICounterView {
   _MyHomePageState() {
    _counterPresenter = CounterPresenter(this, CounterData());
  }

  late ValueNotifier<int> _counterNotification;
  final ValueNotifier<bool> _loadingNotification = ValueNotifier(true);

  late CounterPresenter _counterPresenter;

  @override
  void intView(int number) {
    _counterNotification = ValueNotifier(number);
    _loadingNotification.value = false;
  }

  @override
  void updateNumber(int number) {
    if (!_loadingNotification.value) {
      _counterNotification.value = number;
    }
  }

  @override
  void initState() {
    _counterPresenter.load(useLoading: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ValueListenableBuilder<bool>(
          valueListenable: _loadingNotification,
          builder: (context, loading, _) {
            if (loading) {
              return const CircularProgressIndicator();
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'You have pushed the button this many times:',
                ),
                ValueListenableBuilder(
                  valueListenable: _counterNotification,
                  builder: (context, number, _) {
                    return Text(
                      '${number ?? ''}',
                      style: Theme.of(context).textTheme.headline4,
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _counterPresenter.incrementCounter(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
