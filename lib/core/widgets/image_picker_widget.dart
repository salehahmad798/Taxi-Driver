import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerButton extends StatelessWidget {
  final Color iconColor;
  final void Function(XFile? pickedImage)? onImagePicked;

  const ImagePickerButton({
    Key? key,
    this.iconColor = const Color(0xff1488CC),
    this.onImagePicked,
  }) : super(key: key);

  void _showPicker(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();

    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () async {
                Navigator.of(context).pop();
                final image = await _picker.pickImage(source: ImageSource.gallery);
                if (onImagePicked != null) onImagePicked!(image);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text('Camera'),
              onTap: () async {
                Navigator.of(context).pop();
                final image = await _picker.pickImage(source: ImageSource.camera);
                if (onImagePicked != null) onImagePicked!(image);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.image, color: iconColor),
      onPressed: () => _showPicker(context),
    );
  }
}
