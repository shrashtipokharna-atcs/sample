import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/bloc/register_bloc.dart';
import 'package:test_app/screens/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<RegisterBloc>(context, listen: false);
    return Scaffold(
        body: Form(
      key: _formKey,
      child: Container(
        color: Color(0xffc2e0f9),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 400),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Register",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              StreamBuilder<Object>(
                stream: bloc.name,
                builder: (context, AsyncSnapshot snapshot) {
                  return TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "Enter Name",
                      labelText: "Name",
                      errorText: snapshot.hasError? snapshot.error.toString() : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onChanged: bloc.changeName,
                  );
                }
              ),
              SizedBox(height: 30),
              StreamBuilder<Object>(
                stream: bloc.email,
                builder: (context, AsyncSnapshot snapshot) {
                  return TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Enter Email",
                      labelText: "Email",
                      errorText: snapshot.hasError? snapshot.error.toString() : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onChanged: bloc.changeEmail,
                  );
                }
              ),
              SizedBox(height: 30),
              StreamBuilder<Object>(
                stream: bloc.phoneNumber,
                builder: (context,AsyncSnapshot snapshot) {
                  return TextField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: "Enter Phone Number",
                      labelText: "phone number",
                      errorText: snapshot.hasError? snapshot.error.toString() : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onChanged: bloc.changePhoneNumber,
                  );
                }
              ),
              SizedBox(height: 30),
              StreamBuilder<Object>(
                stream: bloc.password,
                builder: (context,AsyncSnapshot snapshot) {
                  return TextField(
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Enter Password",
                      labelText: "Password",
                      errorText: snapshot.hasError? snapshot.error.toString() : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onChanged: bloc.changePassword,
                  );
                }
              ),
              SizedBox(height: 30),
              StreamBuilder<Object>(
                stream: bloc.confirmPassword,
                builder: (context, snapshot) {
                  return TextField(
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: isVisible,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: isVisible ?
                        Icon(Icons.visibility_off):
                        Icon(Icons.visibility),
                        onPressed: () {
                          setState(() {
                            isVisible = !isVisible;
                          });


                        } ,),
                      hintText: "Confirm Password",
                      labelText: " Confirm Password",
                      errorText: snapshot.hasError? snapshot.error.toString() : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onChanged: bloc.changeConfirmPassword,
                  );
                }
              ),
              SizedBox(height: 30),
              _buildButton(),
              SizedBox(height: 30),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "Alreday have an account?",
                    style: TextStyle(color: Colors.black)),
                TextSpan(
                  text: "Login here",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                  recognizer: TapGestureRecognizer() ..onTap =() {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                      builder: (context) => LoginScreen(), )
                    );
                  }
                  )
                
              ]))
            ],
          ),
        ),
      ),
    ));
  }

 Widget _buildButton() {
   final bloc = Provider.of<RegisterBloc>(context, listen: false);
   return StreamBuilder<Object>(
     stream: bloc.isValid,
     builder: (context, snapshot) {
       return GestureDetector(
        onTap: snapshot.hasError || !snapshot.hasData
                ? null
                : () {
                    bloc.submit();
                  },
         child: Container(
           height: 40,
           width: 120,
           alignment: Alignment.center,
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(20),
             color: snapshot.hasError || !snapshot.hasData
                    ? Colors.grey
                    : Color(0xffff69b4),

           ),
           child: Text("Login",
           style: TextStyle(
             color: Colors.white,
             fontSize: 23,
           ),),
         ),
       );
     }
   );
 }
}