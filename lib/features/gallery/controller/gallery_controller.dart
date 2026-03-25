import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:void_vault/features/gallery/model/cloudinary_account.dart';
import 'package:void_vault/features/gallery/repo/gallery_repo.dart';

final galleryRepoProvider = Provider((ref) => GalleryRepo());

final galleryControllerProvider =
    NotifierProvider<GalleryController, AsyncValue<void>>(
      GalleryController.new,
    );

final galleryStreamProvider = StreamProvider((ref) {
  return ref.read(galleryRepoProvider).getImages();
});

final accountStreamProvider = StreamProvider<List<CloudinaryAccount>>((ref){
  return ref.read(galleryRepoProvider).getAccounts();
});

class GalleryController extends Notifier<AsyncValue<void>> {
  final picker = ImagePicker();

  @override
  AsyncValue<void> build() {
    return const AsyncData(null); // initial state
  }

  Future<void> pickAndUploadImage() async {
    try {
      state = const AsyncLoading();

      final file = await picker.pickImage(source: ImageSource.gallery);

      if (file == null) {
        state = const AsyncData(null);
        return;
      }

      final imageFile = File(file.path);
      
      print('--- Debugging Upload ---');
      final accountsAsync = ref.read(accountStreamProvider);
      print('Accounts AsyncValue State: $accountsAsync');
      
      // Wait for the future to resolve in case it's still loading
      final accounts = await ref.read(accountStreamProvider.future);
      print('Fetched accounts: $accounts');

      if(accounts == null || accounts.isEmpty){
        print('Error: Accounts list is null or empty');
        state = AsyncError('No Accounts available', StackTrace.current);
        return;
      }

      print('Accounts count before sort: ${accounts.length}');
      // sorting the accounts based on available storage
      accounts.sort((a,b) => a.usedStorage.compareTo(b.usedStorage));
      print('Sorted accounts successfully');

      String? imgUrl;
      String? usedAccountId;

      for(final account in accounts){
        // Remove any accidental quotes that might have been saved in Firestore
        final cleanCloudName = account.cloudName.replaceAll('"', '').trim();
        final cleanPreset = account.uploadPreset.replaceAll('"', '').trim();
        
        print('Trying account: ${account.id}, CloudName: $cleanCloudName, Preset: $cleanPreset');
        try{
          final url = await ref.read(galleryRepoProvider).uploadToCloudinary(imageFile, cleanCloudName, cleanPreset);

          imgUrl = url;
          usedAccountId = account.id;
          print('✅ Success! Uploaded to account ${account.id}. URL: $url');
          break;
        }catch(e, stack){
          if (e is DioException) {
            print('❌ Failed on account ${account.id}: DioException [${e.response?.statusCode}]');
            print('Cloudinary Response Body: ${e.response?.data}');
          } else {
            print('❌ Failed on account ${account.id}: $e');
            print('Stack trace: $stack');
          }
          continue;
        }
      }
      if(imgUrl == null) {
        print('All uploads failed loop finished with null imgUrl');
        throw Exception('All uploads failed');
      }

      
    // saving img
      await ref.read(galleryRepoProvider).saveImage(imgUrl, usedAccountId!);
    
    // update the storage
    await ref.read(galleryRepoProvider).incrementStorage(usedAccountId);
      state = const AsyncData(null);
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
    }
  }
}
