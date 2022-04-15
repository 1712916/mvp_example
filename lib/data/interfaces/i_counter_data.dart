abstract class ICounterData {
  Future<int> increment(int incrementNumber);
  Future<int> getCurrentNumber();
}