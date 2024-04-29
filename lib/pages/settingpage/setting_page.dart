import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:magical_food/util/theme_provider.dart';
import 'package:provider/provider.dart';

import 'language_page/language_page.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(tr("setting")),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Consumer<ThemeProvider>(builder: (context, ThemeProvider tp, child) {
            return ListTile(
              title: Text(tr("night_mode")),
              leading: Icon(Icons.dark_mode),
              trailing: Consumer<ThemeProvider>(
                  builder: (context, ThemeProvider tp, child) {
                return Switch(
                    activeColor: Theme.of(context).primaryColor,
                    value: tp.tm == ThemeMode.dark,
                    onChanged: (value) {
                      if (value) {
                        tp.changeToDark();
                      } else {
                        tp.changeToLight();
                      }
                    });
              }),
            );
          }),
          ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return LanguagePage();
              })).then((value) {
                setState(() {});
              });
            },
            title: Text(tr("lang")),
            leading: Icon(Icons.language),
          )
        ],
      ),
    );
  }
}
