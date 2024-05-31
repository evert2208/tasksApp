import 'package:formz/formz.dart';

enum DateError { invalid }

class Date extends FormzInput<DateTime?, DateError> {
  const Date.pure([DateTime? value]) : super.pure(value);
  const Date.dirty([DateTime? value]) : super.dirty(value);

   String? get errorMessage {
    if ( isValid || isPure ) return null;

    if ( displayError == DateError.invalid ) return 'La fecha debe ser futura';

    return null;
  }

  @override
  DateError? validator(DateTime? value) {
    return value != null && value.isBefore(DateTime.now()) ? DateError.invalid : null;
  }
}
