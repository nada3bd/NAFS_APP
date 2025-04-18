import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_app/cubit/themecubit.dart';
import 'package:grad_app/widgets/custombottomnavbar.dart';
import 'package:grad_app/widgets/editprofilebutton.dart';
import 'package:grad_app/widgets/settingstile.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const userName = "Ahmad Ali";
    const userImage = Icons.account_circle;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          title: const Padding(
            padding: EdgeInsets.only(top: 30.0),
            child: Text('Settings Profile',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ),
          centerTitle: true,
        ),
      ),
      body: Column(
        children: [
          Icon(userImage, size: 130, color: Theme.of(context).primaryColor),
          const SizedBox(height: 8),
          const Text(userName,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 16),
          const EditProfileButton(),
          const SizedBox(height: 20),
          Divider(
              thickness: 2, color: Colors.grey[200], indent: 18, endIndent: 25),
          SettingsTile(
            icon: Icons.dark_mode,
            label: "Dark Mode",
            trailing: Switch(
              activeColor: Theme.of(context).primaryColor,
              inactiveThumbColor: Colors.black,
              inactiveTrackColor: Colors.white,
              value: isDark,
              onChanged: (_) => context.read<ThemeCubit>().toggleTheme(),
            ),
          ),
          SettingsTile(
              icon: Icons.lock_outline, label: "Change Password", onTap: () {}),
          Divider(
              thickness: 2, color: Colors.grey[200], indent: 18, endIndent: 25),
          SettingsTile(
              icon: Icons.help_outline, label: "Help & Support", onTap: () {}),
          SettingsTile(icon: Icons.logout, label: "Log out", onTap: () {}),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 2),
    );
  }
}
