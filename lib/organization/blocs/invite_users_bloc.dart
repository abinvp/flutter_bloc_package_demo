import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_package_demo/organization/blocs/invite_users_event.dart';
import 'package:flutter_bloc_package_demo/organization/blocs/invite_users_state.dart';
import 'package:validators/validators.dart';

class InviteUsersBloc
    extends Bloc<InviteUsersEvent, InviteUsersState> {

  @override
  InviteUsersState get initialState => InviteUserInit();

  @override
  Stream<InviteUsersState> mapEventToState(
    InviteUsersState currentState,
    InviteUsersEvent event,
  ) async* {
    if (event is ScreenInitialized) {
      final List<String> _emails = [];
      yield EmailsListUpdated(emails: _emails);
    }

    if (event is EmailSubmitted && currentState is EmailsListUpdated) {
      if (!isEmail(event.email)) {
        yield currentState.copyWith(error: 'Please enter a valid email');
      } else if (currentState.emails.contains(event.email)) {
        yield currentState.copyWith(
            error: '${event.email} is already added to the list!');
      } else {
        yield EmailsListUpdated(emails: currentState.emails + [event.email]);
      }
    }

    /// If event is EmailDeleted, remove the passed email from the List
    /// and update the state.
    if (event is EmailDeleted && currentState is EmailsListUpdated) {
      yield EmailsListUpdated(emails: currentState.emails..remove(event.email));
    }
  }
}
