import 'package:example/arculus_onboarding_set.dart';
import 'package:example/arculus_onboarding_set_controller_impl.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Healthy Burger',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFFFD553),
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ArculusOnboardingSet(
        googleButtonLabel: 'Continue with Google',
        appleButtonLabel: 'Continue with Apple',
        emailButtonLabel: 'Continue with Email',
        isGoogleButtonVisible: true,
        isAppleButtonVisible: true,
        isEmailButtonVisible: true,
        controller: ArculusOnboardingSetControllerImpl(),
        branding: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 300,
                child: Image.asset('assets/brand_logo.jpg'),
              ),
              Text(
                'The Healthy Burger Inc.',
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 4),
              Text(
                'By catalyststuff of freepik.com',
                style: Theme.of(context).textTheme.caption,
              )
            ],
          ),
        ),
        padding: const EdgeInsets.all(16),
      ),
    );
  }
}
