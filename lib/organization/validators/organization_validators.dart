import 'dart:async';

class OrganizationValidators {
  static final validateOrganizationName =
      StreamTransformer<String, String>.fromHandlers(handleData: (organizationName, sink) {
    organizationName.isNotEmpty ? sink.add(organizationName) : sink.addError('Please enter a valid name.');
  });
}
