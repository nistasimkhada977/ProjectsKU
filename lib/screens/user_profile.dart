import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/auth_provider.dart';
import '../provider/user_provider.dart';
import '../screens/dashboard/header.dart';
import '../theme/text_styles.dart';
import '../theme/extention.dart';
import '../components/RoundedButton.dart';
import '../routes.dart';
class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text(user.name, style: TextStyles.h1Style),
                SizedBox(height: 15,),
                Header(),
              ]),
            ),
            Column(children: [
              NavigatingButton(
                text: 'My Donations',
                onPress: () {
                  print('My Donations');
                },
                icon: Icons.account_balance_wallet,
              ),
              NavigatingButton(
                text: 'Edit Profile',
                onPress: () {
                  Navigator.pushNamed(context, Routes.editData);
                },
                icon: Icons.edit,
              ),
              NavigatingButton(
                  text: 'Help and Support',
                  onPress: () {
                    print('Help and Suppoort');
                  },
                  icon: Icons.help),
              NavigatingButton(
                  text: 'Terms and Services',
                  onPress: () {
                    print('Terms and Services');
                  },
                  icon: Icons.assignment),
              NavigatingButton(
                text: 'Logout',
                onPress: () {
                  Provider.of<AuthProvider>(context,listen: false).signOut(context);
                },
                icon: Icons.exit_to_app,
                hasNavigation: false,
              ),
            ])
          ],
        ),
      ).p16,
    );
  }
}