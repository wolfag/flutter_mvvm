import 'dart:async';
import 'dart:math';

import 'package:flutter_mvvm/helper/validation.dart';
import 'package:rxdart/rxdart.dart';

class LoginViewModel {
  final _emailSubject = BehaviorSubject<String>();
  final _passwordSubject = BehaviorSubject<String>();
  final _btnSubject = BehaviorSubject<bool>();

  var emailValidation = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      sink.add(Validation.validateEmail(email));
    },
  );
  var passValidation = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      sink.add(Validation.validatePassword(password));
    },
  );

  Stream<String> get emailStream =>
      _emailSubject.stream.transform(emailValidation);
  Sink<String> get emailSink => _emailSubject.sink;

  Stream<String> get passwordStream =>
      _passwordSubject.stream.transform(passValidation);
  Sink<String> get passwordSink => _passwordSubject.sink;

  Stream<bool> get btnStream => _btnSubject.stream;
  Sink<bool> get btnSink => _btnSubject.sink;

  LoginViewModel() {
    Rx.combineLatest2(_emailSubject, _passwordSubject, (email, password) {
      return Validation.validateEmail(email) == null &&
          Validation.validatePassword(password) == null;
    }).listen((event) {
      print(event);
      btnSink.add(event);
    });
  }

  dispose() {
    _emailSubject.close();
    _passwordSubject.close();
    _btnSubject.close();
  }
}
