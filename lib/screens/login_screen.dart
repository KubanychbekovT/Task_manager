import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:Column(
        children: <Widget>[
          Container(
            child: Form(
              //key: _userLoginFormKey,
              child: Padding(
                padding: const EdgeInsets.only(top:5.0,bottom:15,left: 10,right: 10),
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text("Login",style:TextStyle(fontWeight: FontWeight.w800,fontSize: 25),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:15.0,right: 14,left: 14,bottom: 8),
                        child: TextFormField(
                          style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold,fontSize: 15),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius
                                  .all(
                                  Radius.circular(15)),
                            ),
                            hintText: "Email",
                            hintStyle: TextStyle(fontSize: 15) ,
                            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          ),
                          cursorColor:Colors.black,
                          keyboardType: TextInputType.emailAddress,
                          // inputFormatters: [
                          //   BlacklistingTextInputFormatter
                          //       .singleLineFormatter,
                          // ],
                        ),),
                      Padding(
                        padding: const EdgeInsets.only(top:5.0,right: 14,left: 14,bottom: 8),
                        child: TextFormField(
                          // controller: model.passwordController,
                          // obscureText: !model.passwordVisible,
                          style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold,fontSize: 15),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius
                                  .all(
                                  Radius.circular(15)),
                            ),
                            hintText: "Password",
                            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintStyle: TextStyle(fontSize: 15) ,
                            // suffixIcon: IconButton(
                            //     icon: Icon(model
                            //         .passwordVisible
                            //         ? Icons.visibility
                            //         : Icons.visibility_off,color: Color(0xFFE6E6E6),),
                            //     onPressed: () {
                            //       model.passwordVisible =
                            //       !model
                            //           .passwordVisible;
                            //     })
                            ),
                          cursorColor:Colors.black,
                          // inputFormatters: [
                          //   BlacklistingTextInputFormatter
                          //       .singleLineFormatter,
                          // ],
                        ),),
                      SizedBox(height: 16,),
                      InkWell(
                        child: Container(
                            width: 400
                                ,
                            height: 100,
                            margin: EdgeInsets.only(top: 25),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color:Colors.black
                            ),
                            child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[

                                    Text('Sign in with Google',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white
                                      ),
                                    ),
                                  ],
                                )
                            )
                        ),
                        onTap: ()
                        async{
                          GoogleSignIn _googleSignIn=new GoogleSignIn();
                          GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
                          GoogleSignInAuthentication? googleSignInAuthentication =
                          await googleSignInAccount?.authentication;
                          print(googleSignInAuthentication?.accessToken);
                          //   signInWithGoogle(model)
                          //     .then((FirebaseUser user){
                          //   model.clearAllModels();
                          //   Navigator.of(context).pushNamedAndRemoveUntil
                          //     (RouteName.Home, (Route<dynamic> route) => false
                          //   );}
                          // ).catchError((e) => print(e));
                        },
                      ),
                      SizedBox(height: 16,),
                    ],),
                ),),
            ),),
        ],),
    );

  }

}

