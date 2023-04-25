import 'package:facebook_auth/model/listing_api_client.dart';

import 'package:facebook_auth/view-model/logout-view-model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ListPage extends StatefulWidget {
  final String id;
  final String token;
  const ListPage({super.key, required this.id, required this.token});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final _logoutViewModel = LogoutViewModel();
  final _listingApiClient = ListingApiClient();
  Map<String, dynamic> listings = {};
  bool isloading = true;
  bool _mounted = true;

  @override
  void initState() {
    _loadListing();
    super.initState();
  }

  @override
  void didUpdateWidget(ListPage oldWidget) {
    if (oldWidget.id != widget.id || oldWidget.token != widget.token) {
      _loadListing();
    }
    super.didUpdateWidget(oldWidget);
  }

  void _loadListing() async {
    setState(() {
      isloading = true;
    });
    final listing = await _listingApiClient.getListing(widget.id, widget.token);
    if (_mounted) {
      setState(() {
        listings = listing;
        isloading = false;
      });
    }
  }

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listing'),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => _showMenu(context),
            color: Colors.black,
          ),
        ],
      ),
      body: isloading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: listings['listing'].length,
              itemBuilder: (context, index) {
                final item = listings['listing'][index];
                int number = index + 1;
                return ListTile(
                  leading: Text('$number'),
                  title: Text(item['list_name']),
                  onTap: () {
                    Fluttertoast.showToast(
                      msg: item['list_name'] + ',' + item['distance'],
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  },
                );
              },
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
                _mounted = false;
                await _logoutViewModel.logout(context);
              },
            ),
          ],
        );
      },
    );
  }
}
