import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:penny_smart_wallet/views/view_login/login_view.dart';

class ExitIconWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LoginPageView(),
          ),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              backgroundColor: Colors.red.shade100,
              radius: 25,
              child: Icon(
                Ionicons.exit,
                color: Colors.red,
              ),
            ),
          ),
          SizedBox(width: 20),
          Text(
            "Logout",
            style: TextStyle(color: Colors.red, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
