import 'package:design/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({Key key}) : super(key: key);

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     routes: <String, WidgetBuilder>{
  //       'signup': (BuildContext context) => new SignUpPage(),
  //     },
  //     home: LoginPage(),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
        initialData: null,
        value: AuthController.userStream,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Wrapper(),
        ));
  }
}

class LoginPage extends StatelessWidget {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              child: Stack(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                child: Text(
                  'Hai',
                  style: TextStyle(
                    fontSize: 80.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(15.0, 175.0, 0.0, 0.0),
                child: Text(
                  'Kamu',
                  style: TextStyle(
                    fontSize: 80.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(220.0, 175.0, 0.0, 0.0),
                child: Text(
                  '.',
                  style: TextStyle(
                    fontSize: 80.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          )),
          Container(
            padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
            child: Column(
              children: [
                TextField(
                  controller: emailCtrl,
                  decoration: InputDecoration(
                      labelText: 'EMAIL',
                      labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.green,
                      ))),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: passCtrl,
                  decoration: InputDecoration(
                      labelText: 'PASSWORD',
                      labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.green,
                      ))),
                  obscureText: true,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  alignment: Alignment(1.0, 0.0),
                  padding: EdgeInsets.only(top: 15.0, left: 20.0),
                  child: InkWell(
                    child: Text(
                      'Forgot Password',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                Container(
                  height: 40.0,
                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    shadowColor: Colors.greenAccent,
                    color: Colors.green,
                    elevation: 7.0,
                    child: GestureDetector(
                      onTap: () async {
                        try {
                          await AuthController.login(
                              emailCtrl.text.toString().trim(), passCtrl.text);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())));
                        }
                      },
                      child: Center(
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // SizedBox(height: 20.0),
              ],
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'New to Badak ?',
                style: TextStyle(fontFamily: 'Montserrat'),
              ),
              SizedBox(
                width: 5.0,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpPage()));
                },
                child: Text(
                  'Daftar',
                  style: TextStyle(
                    color: Colors.green,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final User user;
  const HomePage(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home - UAS"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(user.uid),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 50, width: 250,
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(20)),
              // ignore: deprecated_member_use
              child: FlatButton(
                onPressed: () async {
                  try {
                    await AuthController.logout();
                  } catch (e) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(e.toString())));
                  }
                },
                child: Text(
                  'Logout',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class _HomePageState extends State<LoginPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Container(
//               child: Stack(
//             children: [
//               Container(
//                 padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
//                 child: Text(
//                   'Hai',
//                   style: TextStyle(
//                     fontSize: 80.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.fromLTRB(15.0, 175.0, 0.0, 0.0),
//                 child: Text(
//                   'Kamu',
//                   style: TextStyle(
//                     fontSize: 80.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.fromLTRB(220.0, 175.0, 0.0, 0.0),
//                 child: Text(
//                   '.',
//                   style: TextStyle(
//                     fontSize: 80.0,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.green,
//                   ),
//                 ),
//               ),
//             ],
//           )),
//           Container(
//             padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
//             child: Column(
//               children: [
//                 TextField(
//                   decoration: InputDecoration(
//                       labelText: 'EMAIL',
//                       labelStyle: TextStyle(
//                         fontFamily: 'Montserrat',
//                         fontWeight: FontWeight.bold,
//                         color: Colors.grey,
//                       ),
//                       focusedBorder: UnderlineInputBorder(
//                           borderSide: BorderSide(
//                         color: Colors.green,
//                       ))),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 TextField(
//                   decoration: InputDecoration(
//                       labelText: 'PASSWORD',
//                       labelStyle: TextStyle(
//                         fontFamily: 'Montserrat',
//                         fontWeight: FontWeight.bold,
//                         color: Colors.grey,
//                       ),
//                       focusedBorder: UnderlineInputBorder(
//                           borderSide: BorderSide(
//                         color: Colors.green,
//                       ))),
//                   obscureText: true,
//                 ),
//                 SizedBox(
//                   height: 5.0,
//                 ),
//                 Container(
//                   alignment: Alignment(1.0, 0.0),
//                   padding: EdgeInsets.only(top: 15.0, left: 20.0),
//                   child: InkWell(
//                     child: Text(
//                       'Forgot Password',
//                       style: TextStyle(
//                         color: Colors.green,
//                         fontWeight: FontWeight.bold,
//                         fontFamily: 'Montserrat',
//                         decoration: TextDecoration.underline,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 40.0,
//                 ),
//                 Container(
//                   height: 40.0,
//                   child: Material(
//                     borderRadius: BorderRadius.circular(20.0),
//                     shadowColor: Colors.greenAccent,
//                     color: Colors.green,
//                     elevation: 7.0,
//                     child: GestureDetector(
//                       onTap: () {},
//                       child: Center(
//                         child: Text(
//                           'LOGIN',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontFamily: 'Montserrat',
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 // SizedBox(height: 20.0),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 15.0,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'New to Badak ?',
//                 style: TextStyle(fontFamily: 'Montserrat'),
//               ),
//               SizedBox(
//                 width: 5.0,
//               ),
//               InkWell(
//                 onTap: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => SignUpPage()));
//                 },
//                 child: Text(
//                   'Daftar',
//                   style: TextStyle(
//                     color: Colors.green,
//                     fontFamily: 'Montserrat',
//                     fontWeight: FontWeight.bold,
//                     decoration: TextDecoration.underline,
//                   ),
//                 ),
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return (user != null) ? HomePage(user) : LoginPage();
  }
}
