import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_colors.dart';
import 'package:todo/auth/register/custom_text_form_field.dart';
import 'package:todo/auth/register/register.dart';
import 'package:todo/dialog_utils.dart';
import 'package:todo/firebase_utils.dart';
import 'package:todo/home/HomeScreen.dart';
import 'package:todo/provider/auth_user_provider.dart';
class LoginScreen extends StatelessWidget {
  static const String routeName = 'login_screen';

  TextEditingController emailController = TextEditingController(text: "mariam@gmail.com");
  TextEditingController passwordController = TextEditingController(text: "123456789");
  var FormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: AppColors.backgroundLightColor,
          child: Image.asset('assets/image/background.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text('Login',
              style: TextStyle(
                  color: AppColors.whiteCoLor
              ),),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Form(
              key: FormKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.3,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Welcome Back!' ,
                        style: Theme.of(context).textTheme.titleMedium,),
                    ),
                    CustomTextFormField(label: "Email",
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator:  (text){
                          if(text == null || text.trim().isEmpty){
                            return "Please enter your email";
                          }
                          final bool emailValid =
                          RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(text);
                          if(!emailValid){
                            return "Please enter valid email.";
                          }
                          return null;
                        }),
                    CustomTextFormField(label: 'Password',
                        controller: passwordController,
                        keyboardType: TextInputType.number,
                        obscureText: true,
                        validator:  (text){
                          if(text == null || text.trim().isEmpty){
                            return "Please enter your password";
                          }
                          if(text.length < 6){
                            return "Password should be at least 6 chars. ";
                          }
                          return null;
                        }),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(onPressed: (){
                        login(context);
                      },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                          ),
                          child: Text('Login' ,
                            style: Theme.of(context).textTheme.titleLarge,)),
                    ),
                    TextButton(onPressed: (){
                      Navigator.of(context).pushNamed(RegisterScreen.routeName);
                    },
                        child: Text("Or Create Account."))
                  ],
                ),
              )
          ),
        )
      ],
    );
  }

  void login(BuildContext context) async{
    if(FormKey.currentState?.validate() == true){
      DialogUtils.showLoading(context: context, message: "Waiting...");
      try {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text
        );

        var user = await FirebaseUtils.readUserFromFireStore(credential.user?.uid?? '');
        if (user == null){
          return;
        }

        var authProvider = Provider.of<AuthUserProvider>(context , listen: false);
        authProvider.updateUser(user);

        DialogUtils.hideLoading(context);


        DialogUtils.showMessage(context: context, content: "Login Successfully."
            ,title: "Success" , posActionName: "Ok" ,
            posAction: (){
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            });
        print("Login Successfully.");
        print(credential.user?.uid ?? '');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'Invalid Credential.') {
          DialogUtils.hideLoading(context);

          DialogUtils.showMessage(context: context, content: "The supplied auth credential is incorrect, malformed or has expired."
              ,title: "Error" , posActionName: "Ok");
          print('The supplied auth credential is incorrect, malformed or has expired.');
        }
      }catch (e) {
        DialogUtils.hideLoading(context);

        DialogUtils.showMessage(context: context,
            content: e.toString()
            ,title: "Error" , posActionName: "Ok");
        print(e);
      }
    }
  }
}