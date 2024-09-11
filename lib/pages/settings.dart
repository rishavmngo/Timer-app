import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timer_app/auth/auth_service.dart';
import 'package:timer_app/main.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final TextEditingController displayNameController = TextEditingController(
      text: Supabase.instance.client.auth.currentUser
              ?.userMetadata?['display_name'] ??
          "");
  bool _isButtonDisabled = true;
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    displayNameController.addListener(_onTextChanged);
    fToast = FToast();
    fToast.init(navigatorKey.currentContext!);
  }

  @override
  void dispose() {
    displayNameController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _isButtonDisabled = displayNameController.text.isEmpty;
    });
  }

  void updateDisplayName(String displayName) async {
    fToast.showToast(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(100)),
          child: const Row(
            children: [
              Icon(Icons.check_circle),
              SizedBox(
                width: 10,
              ),
              Text(
                "Updated Successfully",
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
              )
            ],
          ),
        ),
        toastDuration: const Duration(seconds: 2),
        gravity: ToastGravity.BOTTOM);
    var authService = AuthService();
    try {
      await authService.updateDisplayName(displayName);
      setState(() {
        _isButtonDisabled = true;
      });
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).primaryColor, // Color of you choice
        statusBarIconBrightness: Brightness.light,
      ),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            centerTitle: true,
            title: Text(
              "Settings",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 27),
            ),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          body: Padding(
            padding:
                const EdgeInsets.only(left: 12, top: 40, right: 12, bottom: 12),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                "General",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 20),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: displayNameController,
                      textAlignVertical: TextAlignVertical.top,
                      style:
                          const TextStyle(fontSize: 15, color: Colors.white70),
                      decoration: const InputDecoration(
                        labelText: 'Display Name',
                        labelStyle: TextStyle(color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white54)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: _isButtonDisabled
                          ? null
                          : () {
                              FocusScope.of(context).unfocus();

                              updateDisplayName(displayNameController.text);
                            },
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text("Save Changes"),
                      ),
                      style:
                          TextButton.styleFrom(backgroundColor: Colors.white),
                    )
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
