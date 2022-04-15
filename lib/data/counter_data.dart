import 'interfaces/interfaces.dart';

class CounterData extends ICounterData {
  int _number = 0;

  @override
  Future<int> increment(int? incrementNumber) async {
    incrementNumber ??= 0;
    _number += incrementNumber;
    return _number;
  }

  @override
  Future<int> getCurrentNumber() async {
    return _number;
  }
}
