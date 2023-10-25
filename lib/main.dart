import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_email_login/signin.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final _emailController = TextEditingController();
  final _passController = TextEditingController();
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
  }

  void SignUptoFirebase()async{

    try {
  // ignore: unused_local_variable
  final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: _emailController.text.trim(),
    password: _passController.text.trim(),
  );

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text("Sign Up to success")));
} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    print('The password provided is too weak.');
  } else if (e.code == 'email-already-in-use') {
    print('The account already exists for that email.');
  }
} catch (e) {
  print(e);
}
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text("Firebase Email SignIn"),
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
                ElevatedButton(onPressed: (){
                  SignUptoFirebase();
                }, child: Text("Sign Up")),
                ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SigninPage()));
                }, child: Text("Sign In")),
              ],
            ),
          ),
        
      ),
    );
  }
}
