import 'package:penny_smart_wallet/views/view_edit_account/edit_account_view.dart';
import 'package:penny_smart_wallet/widgets/bottomnavigationbar.dart';
import 'package:penny_smart_wallet/widgets/settings_widget/forward_button.dart';
import 'package:penny_smart_wallet/widgets/settings_widget/logout_button.dart';
import 'package:penny_smart_wallet/widgets/settings_widget/setting_item.dart';
import 'package:penny_smart_wallet/widgets/settings_widget/setting_switch.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool isDarkMode = true;
  bool isNotification = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _customAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Settings",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                "Account",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    ClipOval(
                      child: Image.asset("images/avatar.png",
                          width: 60, height: 60),
                    ),
                    const SizedBox(width: 20),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Batuhan Satilmis",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "afrousse1998@gmail.com",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                    const Spacer(),
                    ForwardButton(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditAccountView(),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                "Settings",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              const SizedBox(height: 10),
              SettingItem(
                title: "Language",
                icon: Ionicons.earth,
                bgColor: Colors.orange.shade100,
                iconColor: Colors.orange,
                value: "English",
                onTap: () {},
              ),
              const SizedBox(height: 10),
              SettingSwitch(
                title: "Notifications",
                icon: Ionicons.notifications,
                bgColor: Colors.blue.shade100,
                iconColor: Colors.blue,
                value: isNotification,
                onTap: (value) {
                  setState(() {
                    isNotification = value;
                  });
                },
                titleStyle: (TextField.materialMisspelledTextStyle),
              ),
              const SizedBox(height: 10),
              SettingSwitch(
                title: "Dark Mode",
                icon: Ionicons.earth,
                bgColor: Colors.purple.shade100,
                iconColor: Colors.purple,
                value: isDarkMode,
                onTap: (value) {
                  setState(() {
                    isDarkMode = value;
                  });
                },
                titleStyle: (TextField.materialMisspelledTextStyle),
              ),
              const SizedBox(height: 10),
              SettingItem(
                title: "Help",
                icon: Ionicons.nuclear,
                bgColor: Colors.green.shade100,
                iconColor: Colors.green,
                onTap: () {},
              ),
              const SizedBox(height: 10),
              ExitIconWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

AppBar _customAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.black,
    elevation: 0,
    title: Align(
      alignment: Alignment.centerLeft,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: Colors.grey.shade50,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => Bottom(),
                ),
              );
            },
          ),
          Text(
            'Back',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade50,
            ),
          ),
        ],
      ),
    ),
  );
}