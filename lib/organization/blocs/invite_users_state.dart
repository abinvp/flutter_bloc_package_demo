import 'package:equatable/equatable.dart';

abstract class InviteUsersState extends Equatable {
  InviteUsersState([List props = const []]) : super(props);
}

class InviteUserInit extends InviteUsersState {
  @override
  String toString() => 'InviteOrganizationUserInit';
}

class EmailsListUpdated extends InviteUsersState {

  final List<String> emails;
  final String error;
  final bool hasError;

  EmailsListUpdated({
    this.emails,
    this.error,
    hasError
  }) : hasError = error != null ? true : false, super([emails, error, hasError]);

  EmailsListUpdated copyWith({
    List<String> emails,
    String error,
    bool hasError
  }) {
    return EmailsListUpdated(
      emails: emails ?? this.emails,
      error: error ?? this.error,
      hasError: hasError ?? this.error,
    );
  }
}
