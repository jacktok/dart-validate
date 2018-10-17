import 'ListTool.dart';

class Validate<E, T> {
  List<E> error;
  T success;

  bool isSuccess() => success != null;

  bool isFail() => !error.isEmpty;

  String toString() =>
      isSuccess() ? "success => $success" : "fail => [${error.join(", ")}]";

  Validate(this.error, this.success) {
    this.error ??= [];
    assert(isSuccess() != isFail(),
        "valite cannot success and fail at the same time.");
  }

  Validate<E, T2> andThen<T2>(Validate<E, T2> Function(T) block) {
    if (isSuccess()) {
      var result = block(success);
      return result.isSuccess() ? result : Validate.Fail(ListTool.Flatten([error, result.error]));
    } else {
      return Validate.Fail(error);
    }
  }

  Validate.Fail(List<E> e) : this(e, null);

  Validate.Success(T s) : this(null, s);

  static Validate<E2, List<T2>> Apply<E2, T2>(
      List<Validate<E2, T2>> validateList) {
    if (ListTool.ForAll(validateList, (Validate v) => v.isSuccess())) {
      return Validate.Success(
          validateList.map((Validate<E2, T2> v) => v.success).toList());
    } else {
      return Validate.Fail(ListTool.FlatMap(
          ListTool.Filter(validateList, (Validate v) => v.isFail()),
          (Validate<E2, T2> v) => v.error));
    }
  }
}
