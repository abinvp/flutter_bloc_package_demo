import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_package_demo/organization/blocs/invite_users_bloc.dart';
import 'package:flutter_bloc_package_demo/organization/blocs/invite_users_event.dart';
import 'package:flutter_bloc_package_demo/organization/blocs/invite_users_state.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

class InviteUsersScreen extends StatefulWidget {
  _InviteUsersScreenState createState() =>
      _InviteUsersScreenState();
}

class _InviteUsersScreenState
    extends State<InviteUsersScreen> {
  InviteUsersBloc _inviteOrganizationUsersBloc;
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _inviteOrganizationUsersBloc = InviteUsersBloc();

    _inviteOrganizationUsersBloc.dispatch(ScreenInitialized());
  }

  @override
  void dispose() {
    _inviteOrganizationUsersBloc.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InviteUsersEvent,
        InviteUsersState>(
      bloc: _inviteOrganizationUsersBloc,
      builder: (
        BuildContext context,
        InviteUsersState state,
      ) {

        return Scaffold(
          appBar: AppBar(
            title: Text('Invite Users'),
            elevation: 1.0,
            centerTitle: true,
          ),
          body: Column(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0, top: 20.0, right: 10.0),
                  child: state is EmailsListUpdated && state.emails.isNotEmpty
                      ? _addedEmailsList(state.emails)
                      : _screenMessage(),
                ),
              ),
              Container(
                child: state is EmailsListUpdated && state.hasError
                    ? _showError(state.error)
                    : null,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(color: Colors.blueGrey.shade100)),
                    ),
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Theme(
                            data: ThemeData(),
                            child: Padding(
                              padding: EdgeInsets.only(right: 10.0),
                              child: TextField(
                                keyboardType: TextInputType.emailAddress,
                                controller: _emailController,
                                onChanged: (_) {},
                                onEditingComplete: () {},
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(12.0),
                                  border: InputBorder.none,
                                  hintText: 'User Email',
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      Icons.cancel,
                                      color: Colors.grey,
                                    ),
                                    onPressed: () => _emailController.text = '',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox.fromSize(
                          size: Size.fromRadius(20.0),
                          child: CircularGradientButton(
                            callback: () =>
                                _inviteOrganizationUsersBloc.dispatch(
                                  EmailSubmitted(
                                    email: _emailController.text,
                                  ),
                                ),
                            gradient: Gradients.blush,
                            child: Icon(Icons.add),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20.0),
                          width: 1.0,
                          height: 30.0,
                          color: Colors.blueGrey,
                        ),
                        FlatButton(
                          child: Text('INVITE'),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  _showError(String error) {
    return Container(
      padding: EdgeInsets.all(4.0),
      width: double.infinity,
      color: Colors.red.shade100.withOpacity(0.3),
      child: Center(
        child: Text(
          '$error',
          style: Theme.of(context).inputDecorationTheme.errorStyle,
        ),
      ),
    );
  }

  Widget _screenMessage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.people,
            size: 80.0,
            color: Colors.blueGrey.shade300,
          ),
          Center(
            child: Text(
              'Invite users by email. Those who don\'t have an account will receive an invitation link to join.',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _addedEmailsList(List<String> emails) {
    return SingleChildScrollView(
      reverse: true,
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Wrap(
          spacing: 10.0,
          children: _emailChips(emails).toList(),
        ),
      ),
    );
  }

  Iterable<Widget> _emailChips(List<String> emails) sync* {
    for (String email in emails) {
      yield InputChip(
        label: Text('$email'),
        onPressed: () {
          _emailController.text = email;
          _inviteOrganizationUsersBloc.dispatch(
            EmailDeleted(
              email: email,
            ),
          );
        },
        deleteIconColor: Colors.green,
        deleteIcon: Icon(
          Icons.cancel,
          color: Colors.blueGrey,
        ),
        onDeleted: () {
          _inviteOrganizationUsersBloc.dispatch(
            EmailDeleted(
              email: email,
            ),
          );
        },
      );
    }
  }
}
