import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'social_profile_event.dart';
import 'social_profile_bloc.dart';
import 'social_profile_state.dart';
import 'social_user_model.dart';

class UserProfileView extends StatelessWidget {
  final User user = User(
      username: "Hai",
      password: "Hai@865525",
      email: "htranminhhai20@gmail.com",
      description: "something about me");
  final bool isCurrentUser = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProfileBloc(user: user, isCurrentUser: isCurrentUser),
      child: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state.imageSourceActionSheetIsVisible) {
            _showImageSourceActionSheet(context);
          }
        },
        child: Scaffold(
          appBar: _appBar(),
          body: _profilePage(),
        ),
      ),
    );
  }

  Widget _appBar() {
    final appBarHeight = AppBar().preferredSize.height;
    return PreferredSize(
        child:
            BlocBuilder<ProfileBloc, ProfileState>(builder: (context, statte) {
          return AppBar(
            title: Text("Profile"),
            actions: [
              if (statte.isCurrentUser)
                IconButton(onPressed: () {}, icon: Icon(Icons.logout))
            ],
          );
        }),
        preferredSize: Size.fromHeight(appBarHeight));
  }

  Widget _profilePage() {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      return SafeArea(
          child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            _avatar(),
            if (state.isCurrentUser) _changeAvatarButton(),
            SizedBox(
              height: 30,
            ),
            _usernameTile(),
            _emailTile(),
            _descriptionTile(),
            if (state.isCurrentUser) _saveProfileChangesButton()
          ],
        ),
      ));
    });
  }

  Widget _avatar() {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      return CircleAvatar(
        radius: 50,
        child: Icon(Icons.person),
        // backgroundImage: FileImage(File(state.avatarPath)),
      );
    });
  }

  Widget _changeAvatarButton() {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      return TextButton(
        onPressed: () {
          context.read<ProfileBloc>().add(ChangeAvatarRequest());
        },
        child: Text("Change Avatar"),
      );
    });
  }

  Widget _usernameTile() {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      return ListTile(
        tileColor: Colors.white,
        leading: Icon(Icons.person),
        title: Text(state.username),
      );
    });
  }

  Widget _emailTile() {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      return ListTile(
        tileColor: Colors.white,
        leading: Icon(Icons.mail),
        title: Text(state.email),
      );
    });
  }

  Widget _descriptionTile() {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      return ListTile(
        tileColor: Colors.white,
        leading: Icon(Icons.edit),
        title: TextField(
          decoration: InputDecoration.collapsed(
              hintText: state.isCurrentUser
                  ? "Say something about yourself"
                  : "This user hasn\'t updated their profile"),
          maxLines: null,
          readOnly: !state.isCurrentUser,
          toolbarOptions: ToolbarOptions(
              copy: state.isCurrentUser,
              cut: state.isCurrentUser,
              paste: state.isCurrentUser,
              selectAll: state.isCurrentUser),
          onChanged: (value) => context
              .read<ProfileBloc>()
              .add(ProfileDescriptionChanged(description: value)),
        ),
      );
    });
  }

  Widget _saveProfileChangesButton() {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      return ElevatedButton(
        onPressed: () {},
        child: Text("Save Changes"),
      );
    });
  }

  void _showImageSourceActionSheet(BuildContext context) {
    Function(ImageSource) selectedImageSource = (imageSource) {
      context
          .read<ProfileBloc>()
          .add(OpenImagePicker(imageSource: imageSource));
    };

    if (Platform.isIOS) {
      showCupertinoModalPopup(
          context: context,
          builder: (context) => CupertinoActionSheet(
                actions: [
                  CupertinoActionSheetAction(
                      onPressed: () {
                        Navigator.pop(context);
                        selectedImageSource(ImageSource.camera);
                      },
                      child: Text('Camera')),
                  CupertinoActionSheetAction(
                      onPressed: () {
                        Navigator.pop(context);
                        selectedImageSource(ImageSource.gallery);
                      },
                      child: Text("Gallery"))
                ],
              ));
    } else {
      showModalBottomSheet(
          context: context,
          builder: (context) => Wrap(
                children: [
                  ListTile(
                    leading: Icon(Icons.camera_alt),
                    title: Text("Camera"),
                    onTap: () {
                      Navigator.pop(context);
                      selectedImageSource(ImageSource.camera);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.photo_album),
                    title: Text("Gallery"),
                    onTap: () {
                      Navigator.pop(context);
                      selectedImageSource(ImageSource.gallery);
                    },
                  )
                ],
              ));
    }
  }
}
