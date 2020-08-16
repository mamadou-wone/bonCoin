import 'package:bonCoinSN/Pages/Account.dart';
import 'package:bonCoinSN/modals/user.dart';
import 'package:bonCoinSN/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool lockInBackground = true;
  bool notificationsEnabled = true;
  final AuthService _auth = AuthService();
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
              SettingsTile(
                title: 'Email',
                leading: Icon(Icons.email),
                subtitle: user != null ? user.email : null,
              ),
              SettingsTile(
                title: 'Déconnexion',
                leading: Icon(Icons.exit_to_app),
                onTap: () async {
                  await _auth.signOut();
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
