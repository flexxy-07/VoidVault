import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:void_vault/features/gallery/repo/gallery_repo.dart';

final galleryRepoProvider = Provider((ref) => GalleryRepo());

final galleryControllerProvider =
    NotifierProvider<GalleryController, AsyncValue<void>>(
      GalleryController.new,
    );

final galleryStreamProvider = StreamProvider((ref) {
  return ref.read(galleryRepoProvider).getImages();
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
      final url = await ref
          .read(galleryRepoProvider)
          .uploadToCloudinary(imageFile);

      await ref.read(galleryRepoProvider).saveImage(url);

      state = const AsyncData(null);
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
    }
  }
}
