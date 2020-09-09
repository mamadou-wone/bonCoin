// import 'dart:html';

import 'package:bonCoin/Pages/Account.dart';
import 'package:bonCoin/modals/user.dart';
import 'package:bonCoin/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool lockInBackground = true;
  bool notificationsEnabled = true;
  final AuthService _auth = AuthService();
  void logOut() {
    var alertStyle = AlertStyle(
      animationType: AnimationType.fromBottom,
      isCloseButton: false,
      isOverlayTapDismiss: true,
      descStyle: TextStyle(fontWeight: FontWeight.bold),
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: TextStyle(
        color: Colors.red,
      ),
    );
    Alert(
      context: context,
      type: AlertType.warning,
      style: alertStyle,
      title: "bonCoin",
      desc: "Voulez vous vous déconnecter ?",
      buttons: [
        DialogButton(
          child: Text(
            "Déconnexion",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            await _auth.signOut();
          },
          color: Colors.red,
        ),
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      body: SettingsList(
        sections: [
          SettingsSection(
            title: 'Common',
            tiles: [
              SettingsTile(
                title: 'Langue',
                subtitle: 'Français',
                leading: Icon(Icons.language),
                onTap: () {},
              ),
            ],
          ),
          SettingsSection(
            title: 'Compte',
            tiles: [
              SettingsTile(
                title: 'Profil',
                leading: Icon(Icons.person),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Account(),
                    ),
                  );
                },
              ),
              user.email != null
                  ? SettingsTile(
                      title: user.email != null ? 'Email' : 'Phone Number',
                      leading: user.email != null
                          ? Icon(Icons.email)
                          : Icon(LineIcons.phone),
                      subtitle: user.email != null ? user.email : user.phone,
                    )
                  : null,
              SettingsTile(
                title: 'Déconnexion',
                leading: Icon(Icons.exit_to_app),
                onTap: () {
                  logOut();
                  // await _auth.signOut();
                },
              ),
            ],
          ),
          SettingsSection(
            title: 'Divers',
            tiles: [
              SettingsTile(
                  title: 'Conditions d\'utilisation',
                  leading: Icon(Icons.description)),
              SettingsTile(
                  title: 'Contact', leading: Icon(Icons.settings_phone)),
            ],
          )
        ],
      ),
    );
  }
}
