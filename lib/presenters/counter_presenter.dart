import '../data/interfaces/interfaces.dart';
import 'interfaces/interfaces.dart';

class CounterPresenter {
  final ICounterView view;
  final ICounterData data;

  CounterPresenter(this.view, this.data);

  bool _isLoading = false;

  void incrementCounter() {
    if (!_isLoading) {
      data.increment(1).then(view.updateNumber);
    }
  }

  void load({bool useLoading = false}) async {
    _isLoading = useLoading;
    await Future.delayed(const Duration(seconds: 20));
    view.intView(await data.getCurrentNumber());
    _isLoading = false;
  }
}