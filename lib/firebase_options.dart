import 'dart:io';

import 'package:firebase_core/firebase_core.dart';

FirebaseOptions firebaseOptions = Platform.isAndroid
    ? const FirebaseOptions(
        apiKey: "AIzaSyDhR3NeUzipvZQRf5uTcBfJRVv0QAFnz_0",
        appId: "1:597088027164:android:6353d24d6df140eac295d9",
        messagingSenderId: "597088027164",
        projectId: "flutterdemo-eb011")
    : const FirebaseOptions(
        apiKey: "AIzaSyDhR3NeUzipvZQRf5uTcBfJRVv0QAFnz_0",
        appId: "1:597088027164:android:2d3c37c4ea58e108c295d9",
        messagingSenderId: "597088027164",
        projectId: "flutterdemo-eb011");
