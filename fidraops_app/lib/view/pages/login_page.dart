import 'package:fidraops_app/data/models/user.dart';
import 'package:fidraops_app/providers/app_state.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 80.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'FidraOps',
                style: Theme.of(context).textTheme.headlineLarge
              ),
              Text(
                "Your field operations manager tool",
                style: Theme.of(context).textTheme.bodyLarge
              ),
              const SizedBox(height: 60),
              TextField(
                controller: username,
                decoration: InputDecoration(
                  label: Row(
                    children: [
                      Icon(LucideIcons.userRound, color: Theme.of(context).colorScheme.primary),
                      const SizedBox(width: 10),
                      Text('Username'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: password,
                obscureText: true,
                decoration: InputDecoration(
                  label: Row(
                    children: [
                      Icon(LucideIcons.rectangleEllipsis, color: Theme.of(context).colorScheme.primary),
                      const SizedBox(width: 10),
                      Text('Password'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () => context.read<AppState>().setAuthenticated(
                  User(
                    id: 1,
                    name: 'admin',
                    password: 'adminpass',
                    email: 'admin@example.com',
                    createdAt: DateTime.now(),
                    organizationId: 1,
                    isAdmin: true,
                  )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(LucideIcons.rectangleEllipsis, color: Theme.of(context).colorScheme.surface, size: 24),
                    const SizedBox(width: 10),
                    Text(
                      'Login',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.surface,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
