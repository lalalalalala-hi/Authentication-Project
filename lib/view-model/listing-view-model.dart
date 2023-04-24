import 'package:flutter/material.dart';
import 'package:facebook_auth/model/listing_api_client.dart';

class ListViewModel {
  final listingApiClient = ListingApiClient();
  List<dynamic> listing = [];

  Future<void> fetchListing(String id, String token) async {
    final listingResponse = await listingApiClient.getListing(id, token);
    print(listingResponse);
  }
}
