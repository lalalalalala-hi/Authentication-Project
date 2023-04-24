import 'package:facebook_auth/view-model/FBloginout-vew-model.dart';
import 'package:flutter/material.dart';

class FBUserInfo extends StatefulWidget {
  final Map<String, dynamic> userData;

  const FBUserInfo({super.key, required this.userData});

  @override
  State<FBUserInfo> createState() => _FBUserInfoState();
}

class _FBUserInfoState extends State<FBUserInfo> {
  final FBLoginViewModel _fbloginViewModel = FBLoginViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => _showMenu(context),
            color: Colors.black,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            CircleAvatar(
              radius: 100.0,
              backgroundImage:
                  NetworkImage('${widget.userData['picture']['data']['url']}'),
            ),
            const SizedBox(height: 15),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      "${widget.userData['name']}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${widget.userData['email']}",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FloatingActionButton.extended(
                          onPressed: () {},
                          heroTag: 'follow',
                          elevation: 0,
                          label: const Text("Follow"),
                          icon: const Icon(Icons.person_add_alt_1),
                        ),
                        const SizedBox(width: 16.0),
                        FloatingActionButton.extended(
                          onPressed: () {},
                          heroTag: 'mesage',
                          elevation: 0,
                          backgroundColor: Colors.red,
                          label: const Text("Message"),
                          icon: const Icon(Icons.message_rounded),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMenu(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () async {
                await _fbloginViewModel.logout(context);
              },
            ),
          ],
        );
      },
    );
  }
}
