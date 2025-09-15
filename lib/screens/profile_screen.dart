import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_app/components/custom_elevetedbutton.dart';
import 'package:training_app/models/user_model.dart';
import 'package:training_app/provider/user_provider.dart';
import 'package:training_app/services/firebase_service.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = '/profilescreen';
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.currentUser;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
      ),
      body: user == null
          ? _buildNoUserWidget(context)
          : _buildUserProfile(context, user),
    );
  }

  Widget _buildNoUserWidget(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person_off_outlined,
            size: 64,
            color: Theme.of(context).colorScheme.secondary,
          ),
          const SizedBox(height: 16),
          Text(
            "No User Available",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Please log in to view your profile",
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserProfile(BuildContext context, UserModel user) {
    final theme = Theme.of(context);
    final formattedPhone = user.phone.startsWith('+2')
        ? user.phone.substring(2)
        : user.phone;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Profile Avatar
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.colorScheme.primaryContainer,
              border: Border.all(color: theme.colorScheme.primary, width: 3),
            ),
            child: Icon(
              Icons.person,
              size: 60,
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(height: 24),

          // User Name
          Text(
            user.name,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),

          // Email Card
          _buildInfoCard(
            context,
            icon: Icons.email_outlined,
            value: user.email,
          ),
          // Phone Card
          _buildInfoCard(
            context,
            icon: Icons.phone_outlined,
            value: formattedPhone,
          ),
          const SizedBox(height: 32),

          // Additional Actions
          CustomElevetedButton(text: "Edit Profile", onPressed: () {}),
          // _buildActionButton(
          //   context,
          //   icon: Icons.edit_outlined,
          //   onPressed: () {},
          // ),
          const SizedBox(height: 12),
          _buildActionButton(
            context,
            icon: Icons.logout_outlined,
            text: "Sign Out",
            onPressed: FirebaseService.signOut,
            isSecondary: true,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required IconData icon,
    required String value,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String text,
    required VoidCallback onPressed,
    bool isSecondary = false,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(text),
        style: ElevatedButton.styleFrom(
          backgroundColor: isSecondary
              ? Theme.of(context).colorScheme.secondaryContainer
              : Theme.of(context).colorScheme.primary,
          foregroundColor: isSecondary
              ? Theme.of(context).colorScheme.onSecondaryContainer
              : Theme.of(context).colorScheme.onPrimary,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
      ),
    );
  }
}
