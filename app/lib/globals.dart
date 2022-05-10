import 'dart:collection';

import 'models/user_model.dart';

UserModel? user;
bool loading = true;
bool selectedAddressLoading = false;
bool zoomGesturesEnabled = true;
bool scrollGesturesEnabled = true;
var requests = [];
var acceptedRequests = [];
Map<String, dynamic> sentRequests = HashMap();
