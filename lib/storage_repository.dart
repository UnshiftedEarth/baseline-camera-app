/*
  Created By: Nathan Millwater
  Description: Hold the logic for interacting with the cloud storage repository
 */

import 'dart:io';

import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:camera_app/camera_view_build.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';


class StorageRepository {

  String storedDate;

  /// Takes in a username, userId, File and extension and stores this information
  /// Parameters: The user's username, the File object being uploaded and the file extension
  /// Returns: A future string with the upload file result
  Future<String> uploadFile(String username, File file, String extension,
      String userId, LocationData loc, ChunkVideoData chunk) async {
    if (username == null) {
      username = "null";
    }
    // name of uploaded file
    String fileName;
    username = username.trim();
    // create folders to separate videos and photos
    String type;
    if (extension == ".jpg")
      type = "photos";
    else
      type = "videos";

    if (chunk.videoCount == 1)
      storedDate = DateTime.now().toIso8601String();
    if (chunk.videoCount == 0) {
      // fileName = '$username/$type/${username}_' + DateTime.now().toIso8601String();
      fileName = '$userId/$type/${userId}_' + DateTime.now().toIso8601String();
      fileName = fileName.replaceAll('T', '_');
    } else {
      fileName = '$userId/$type/${userId}_' + storedDate;
      // trim time off of fileName
      fileName += ("/" + DateTime.now().toIso8601String() + "--"
          + chunk.videoCount.toString());
      fileName = fileName.replaceAll('T', '_');
    }

    // Stores file metadata in the file upload options
    final options = fileMetadata(username, extension, userId, loc);
    // Amplify upload function
    final result = await Amplify.Storage.uploadFile(
      local: file,
      key: fileName + extension, // The file name
      options: options, // File upload options
    );
    return result.key;
  }

  /// Create the metadata map to upload with the file
  /// Parameters: The user's username, userID, file extension, and location data
  /// Returns: metadata for the file to store on AWS
  S3UploadFileOptions fileMetadata(String username, String extension,
      String userId, LocationData loc) {

    Map<String, String> metadata = Map<String, String>();
    //metadata["username"] = username;
    // metadata["user_id"] = userId;
    metadata["device_id"] = userId;
    metadata["date_created"] = DateTime.now().toIso8601String();
    metadata["type"] = extension;
    metadata["latitude"] = loc.latitude.toString();
    metadata["longitude"] = loc.longitude.toString();
    final options = S3UploadFileOptions(
      metadata: metadata,
      accessLevel: StorageAccessLevel.guest, // the access level of the data
    );
    return options;
  }
}