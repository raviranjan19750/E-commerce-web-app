import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/sign_in/sign_in_bloc.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          height: 500,
          width: 700,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.black,
                  child: Column(
                    children: [
                      Container(
                        child: Text(
                          "LOGIN",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              wordSpacing: 2),
                        ),
                        padding: EdgeInsets.all(12),
                      ),
                      LoginStepper(),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(60),
                  child: LoginWithPhoneWidget(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginWithPhoneWidget extends StatefulWidget {
  @override
  _LoginWithPhoneWidgetState createState() => _LoginWithPhoneWidgetState();
}

class _LoginWithPhoneWidgetState extends State<LoginWithPhoneWidget> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              maxLength: 10,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                // border: InputBorder,
                  labelText: 'Enter Mobile Number',
                  hintText: 'Enter Mobile Number',
                  focusColor: Colors.black),
              onChanged: (val) {
                setState(() {});
              },
            ),
            SizedBox(
              height: 20,
            ),
            OTPWidget(),
            SizedBox(
              height: 10,
            ),
            if (_controller.text.length == 10)
              BlocBuilder<SignInBloc, SignInState>(builder: (context, state) {
                if (state is SignInInitial ||
                    state is SendingOTP ||
                    state is SendingOTPFailed) {
                  return RaisedButton(
                    color: Colors.black,
                    onPressed: () {
                      BlocProvider.of<SignInBloc>(context)
                          .add(SendOTP(phoneNumber: _controller.text));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 10),
                      child: Text(
                        "Request OTP",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                }
                return Container();
              }),
            SizedBox(
              height: 20,
            ),
            LoginStatusWidget()
          ],
        ),
      ),
    );
  }
}

class LoginStatusWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(builder: (context, state) {
      if (state is VerifyingOTP) {
        return CircularProgressIndicator();
      }
      if (state is VerificationFailure) {
        return Text(
          "Unable to verify your otp",
          style: TextStyle(
            color: Colors.red,
          ),
        );
      }
      if (state is VerificationSuccess) {
        return Icon(
          Icons.check_circle_outline,
          size: 60,
          color: Colors.green,
        );
      }
      return Container();
    });
  }
}

class OTPWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(builder: (context, state) {
      if (state is SendingOTP) {
        return CircularProgressIndicator();
      } else if (state is SendingOTPFailed) {
        return Icon(
          Icons.warning,
          color: Colors.red,
        );
      } else if (state is OTPSentToUser) {
        return OTPBox();
      }
      return Container();
    });
  }
}

class OTPBox extends StatefulWidget {
  @override
  _OTPBoxState createState() => _OTPBoxState();
}

class _OTPBoxState extends State<OTPBox> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text("Enter OTP"),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: PinInputTextField(
              controller: _controller,
              pinLength: 6,
              decoration: BoxLooseDecoration(
                  strokeColorBuilder:
                  PinListenColorBuilder(Colors.grey, Colors.black)),
              onChanged: (str) {
                setState(() {});
              },
            ),
          ),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.bottomRight,
            child: Text("Resend Otp"),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: RaisedButton(
              color: Colors.black,
              onPressed: _controller.text.length == 6
                  ? () {
                BlocProvider.of<SignInBloc>(context)
                    .add(VerifyOTP(verificationCode: _controller.text));
              }
                  : null,
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                child: Text(
                  "Verify Otp",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoginStepper extends StatelessWidget {
  List<Step> _buildSteps(int stateNo) {
    return [
      Step(
          isActive: stateNo >= 0,
          title: Text(
            "Enter Mobile Number",
            style: TextStyle(color: Colors.white),
          ),
          content: SizedBox(
            height: 40,
          )),
      Step(
          isActive: stateNo >= 1,
          title: Text("Request OTP", style: TextStyle(color: Colors.white)),
          content: SizedBox(
            height: 40,
          )),
      Step(
          isActive: stateNo >= 2,
          title: Text("Verify", style: TextStyle(color: Colors.white)),
          content: SizedBox(
            height: 40,
          )),
    ];
  }

  int getStateNumber(SignInState state) {
    if (state is VerificationSuccess) {
      return 2;
    } else if (state is SendingOTP ||
        state is OTPSentToUser ||
        state is SendingOTPFailed) {
      return 1;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: BlocBuilder<SignInBloc, SignInState>(builder: (context, state) {
          int stateNo = getStateNumber(state);
          return Stepper(
            currentStep: stateNo,
            steps: _buildSteps(stateNo),
            controlsBuilder: (BuildContext context,
                {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
              return Container();
            },
          );
        }),
      ),
    );
  }
}
