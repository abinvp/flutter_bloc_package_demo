import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class InviteUsersEvent extends Equatable {
  InviteUsersEvent([List props = const []]) : super(props);
}

class ScreenInitialized extends InviteUsersEvent {}

class EmailSubmitted extends InviteUsersEvent {
  final String email;
  EmailSubmitted({@required this.email}) : super([email]);
}

class EmailDeleted extends InviteUsersEvent {
  final String email;
  EmailDeleted({@required this.email}) : super([email]);
}

