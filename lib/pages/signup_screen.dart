import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/pages/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State <SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  String _email = "";
  String _password = "";
  void _handleSignUp() async {
    try {
      UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
          email: _email, password: _password);
      print("User Registered: $userCredential.user!.email");
    }catch (e) {
      print("Error During Regristration: $e");
    }
  }
  @override
  Widget build (BuildContext context) {
    return Scaffold(// AppBar
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage('assets/bgyellow.png'), // Ganti dengan path gambar Anda
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column (
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Image.asset(
                      'assets/logo.png',
                      width: 160),
                  SizedBox(height: 50),
                  TextFormField (
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Email",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter Your Email";
                      }
                      return null;
                    },
                    onChanged: (value){
                      setState(() {
                        _email = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField (
                    controller: _passController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Password",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter Your Password";
                      }
                      return null;
                    },
                    onChanged: (value){
                      setState(() {
                        _password = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(400, 40),
                        foregroundColor: Colors.black,
                        backgroundColor: Color(0xFFE1B34A),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()){
                          _handleSignUp();
                        }
                      }, child: Text("Sign Up")
                  ),
                  WidgetLogin()
                ]
            ),
          ),
        ),
      ),
    );
  }
}

class WidgetLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Sudah memiliki akun?"),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Color(0xFFE1B34A),
            foregroundBuilder:
                (BuildContext context, Set<WidgetState> states, Widget? child) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  border: states.contains(WidgetState.hovered)
                      ? Border(bottom: BorderSide(color: Colors.yellow))
                      : const Border(), // essentially "no border"
                ),
                child: child,
              );
            },
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ));
          },
          child: const Text('Masuk'),
        ),
      ],
    );
  }

}