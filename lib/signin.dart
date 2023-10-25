import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {

  final _emailController = TextEditingController();
  final _passController = TextEditingController();
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passController.dispose();

  }

void SignIntoFirebase()async{

    try {
  // ignore: unused_local_variable
  final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: _emailController.text.trim(),
    password: _passController.text.trim()
  );

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text("Sign In to success")));
    setState(() {});

} on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    print('No user found for that email.');
  } else if (e.code == 'wrong-password') {
    print('Wrong password provided for that user.');
  }
}
  }


  @override
  Widget build(BuildContext context) {

  final User = FirebaseAuth.instance.currentUser;

   return Scaffold(
      appBar: AppBar(

        title: Text("Sign In"),
      ),
      body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: 100,),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: "write email",
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20,),
                TextField(
                  controller: _passController,
                  decoration: InputDecoration(
                    hintText: "write password",
                    labelText: "Passwor",
                    border: OutlineInputBorder(),
                  ),
                ),
                if(User == null)

                ElevatedButton(onPressed: (){
                  SignIntoFirebase();
                }, child: Text("Sign In")),
                if(User !=null)

                ElevatedButton(onPressed: ()async{
                  await FirebaseAuth.instance.signOut();
                  setState(() {});
                }, child: Text("Sign Out")),
                if(User != null) Text("Signed in" +User.email.toString())
              ],
            ),
          ),
        
      ),
    );
  }
}