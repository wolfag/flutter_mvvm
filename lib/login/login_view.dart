import 'package:flutter/material.dart';
import 'package:flutter_mvvm/login/login_viewmodel.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MVVM'),
      ),
      body: BodyWidget(),
    );
  }
}

class BodyWidget extends StatefulWidget {
  BodyWidget({Key key}) : super(key: key);

  @override
  _BodyWidgetState createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  final emailContoller = TextEditingController();
  final passwordContoller = TextEditingController();

  final loginViewModal = LoginViewModel();

  @override
  initState() {
    super.initState();

    emailContoller.addListener(() {
      loginViewModal.emailSink.add(emailContoller.text);
    });

    passwordContoller.addListener(() {
      loginViewModal.passwordSink.add(passwordContoller.text);
    });
  }

  @override
  void dispose() {
    super.dispose();

    loginViewModal.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          StreamBuilder<String>(
            stream: loginViewModal.emailStream,
            builder: (context, snapshot) {
              return TextFormField(
                controller: emailContoller,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.email,
                  ),
                  hintText: "example@gmail.com",
                  labelText: "Email *",
                  errorText: snapshot.data,
                ),
              );
            },
          ),
          StreamBuilder<String>(
            stream: loginViewModal.passwordStream,
            builder: (context, snapshot) {
              return TextFormField(
                controller: passwordContoller,
                obscureText: true,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.lock,
                  ),
                  hintText: "*****",
                  labelText: "Password *",
                  errorText: snapshot.data,
                ),
              );
            },
          ),
          StreamBuilder<bool>(
            stream: loginViewModal.btnStream,
            builder: (context, snapshot) {
              return ElevatedButton(
                onPressed:
                    snapshot.data == null || !snapshot.data ? null : () {},
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
                child: Text('Login'),
              );
            },
          ),
        ],
      ),
    );
  }
}
