import 'package:dart_validate/validate.dart';

import 'package:test/test.dart';

void main() {
  var v1 = Validate.Success(5);
  var v2 = Validate<String, int>.Fail(["error1"]);

  test("create success and fail", () {
    expect(v1.isSuccess(), true);
    expect(v2.isFail(), true);
  });

  test("merge validate", () {
    var v3 = v1.andThen((int input) {
      return Validate.Success(input + 10);
    });

    var v4 = v1.andThen((int input) {
      return Validate.Fail(["error2"]);
    });

    var v5 = v2.andThen((int input) {
      return Validate.Fail(["error2"]);
    });

    expect(v3.success, 15);
    expect(v4.error, ["error2"]);
    expect(v5.error, ["error1"]);
  });
}
