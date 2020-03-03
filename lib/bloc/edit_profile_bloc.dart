import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extra/bloc/generic_bloc.dart';
import 'package:extra/entity/extra_job.dart';
import 'package:extra/entity/profile.dart';
import 'package:extra/service/firebase_service.dart';
import 'package:extra/utils/consts.dart';
import 'package:extra/utils/event_bus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:path/path.dart' as Path;

class EditProfileBloc extends GenericBloc<List<Profile>> {
  setProfile(Profile profile) {
    print("call set profike");
    Future<void> ref =
        Firestore.instance.collection('profiles').document().setData({
      'name': profile.name,
      'email': profile.email,
      'phone': profile.phone,
      'city': profile.city,
      'state': profile.state,
      'urlPhoto': profile.urlPhoto,
      'mainFunction': profile.mainFunction,
      'talks': profile.talks,
      'extras': profile.extras,
      'discription': profile.description
    });
    ref.catchError((onError) {
      print(onError);
    });
  }

  Future<bool> uploadFile(image) async {
    try {
      Profile p = await Profile.get();
      if (p != null && p.oldUrlPhoto != null && p.oldUrlPhoto.isNotEmpty)
        removeOldProfile(p);
      StorageReference storageReference = FirebaseStorage.instance
          .ref()
          .child('profile/${p.id}/${Path.basename(image.path)}');
      StorageUploadTask uploadTask = storageReference.putFile(image);
      await uploadTask.onComplete;
      storageReference.getDownloadURL().then((fileURL) {
        p.urlPhoto = fileURL;
        p.oldUrlPhoto = Path.basename(image.path);
        p.save();
      });
      print("isComplete");
      return uploadTask.isComplete;
    } catch (e) {
      return false;
    }
  }

  removeOldProfile(Profile p) {
    FirebaseStorage.instance
        .ref()
        .child('profile/${p.id}/${p.oldUrlPhoto}')
        .delete()
        .then((_) => print(
            'Successfully deleted profile/${p.id}/${p.oldUrlPhoto} storage item'));
  }

  _compressImage(File file) async {
    ImageProperties properties =
        await FlutterNativeImage.getImageProperties(file.path);
    return await FlutterNativeImage.compressImage(file.path,
        quality: 80,
        targetWidth: 180,
        targetHeight: (properties.height * 180 / properties.width).round());
  }

  saveInFirestore(Profile p) {
    Firestore.instance.collection('profiles').document().setData({
      'id': p.id,
      'name': p.name,
      'email': p.email,
      'phone': p.phone,
      'city': p.city,
      'state': p.state,
      'urlPhoto': p.urlPhoto,
      'mainFunction': p.mainFunction,
      'description': p.description,
      'month': p.month,
    });
  }
}
