import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: UserProfileView(),);
  }
}

class UserProfileView extends StatelessWidget {

  final User user = User(username: "Hai", email: "htranminhhai20@gmail.com", description: "something");
  final bool isCurrentUser = false; 

  // Todo take user and isCurrentUser from session state

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => ProfileBloc(user: user, isCurrentUser: isCurrentUser), child: Scaffold(
      backgroundColor: Color(0xFFF2F2F7),
      appBar: _appBar(),
      body: _profilePage(),
    ),);
  }

  Widget _appBar(){
    final appBarHeight = AppBar().preferredSize.height;
    return PreferredSize(preferredSize: Size.fromHeight(appBarHeight), child: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state){
      return AppBar(
      centerTitle: true,
      title: Text("Profile"),
      actions: [
       if (state.isCurrentUser) IconButton(icon: Icon(Icons.logout), onPressed: (){})
      ],
    );
    }),);
  }

  Widget _profilePage(){
    return SafeArea(child: Center(
      child: Column(
        children: [
          SizedBox(height: 30,),
          _avatar(),
          _changeAvatarButton(),
          SizedBox(height: 30,),
          _usernameTile(),
          _emailTile(),
          _descriptionTile(),
          _saveProfileChangeButton(),
        ],
      ),
    ));
  }

  Widget _avatar() {
    return CircleAvatar(
      radius: 50,
      child: Icon(Icons.person),
    );
  }

  Widget _changeAvatarButton(){
    return TextButton(onPressed: (){}, child: Text("Change Avatar"));
  }

  Widget _usernameTile(){
    return ListTile(
      tileColor: Colors.white,
      leading: Icon(Icons.person),
      title: Text("My username"), 
    );
  }

  Widget _emailTile(){
    return ListTile(
      tileColor: Colors.white,
      leading: Icon(Icons.email),
      title: Text("My Email"),
    );
  }

  Widget _descriptionTile(){
    return ListTile(
      tileColor: Colors.white,
      leading: Icon(Icons.edit),
      title: TextFormField(
        decoration: InputDecoration.collapsed(hintText: 'Say something about yourself'),
        maxLines: null,
      ),
    );
  }

  Widget _saveProfileChangeButton(){
    return ElevatedButton(onPressed: (){}, child: Text("Save Changes"));
  }

}


// Profile event and session event 
abstract class ProfileEvent {}

class ChangeAvatarRequest extends ProfileEvent {}

class OpenImagePicker extends ProfileEvent {}

class ProvideImagePath extends ProfileEvent {
  final String avatarPath;

  ProvideImagePath({this.avatarPath});
}

class ProfileDescriptionChanged extends ProfileEvent {
  final String description;

  ProfileDescriptionChanged({this.description});
}

class SaveProfileChanges extends ProfileEvent {}

// User 

class User {
  final String username;
  final String email;
  final String description;
  User({this.username, this.email, this.description});
}

// Form Status 
abstract class FormSubmissionStatus {
  const FormSubmissionStatus();
}

class InitialFormStatus extends FormSubmissionStatus {
  const InitialFormStatus();
}


// Profile State 
class ProfileState {
  final User user;
  final bool isCurrentUser;
  final String avatarPath;
  final String userDescription;

  // Get properties and now allowing to change User profile 
  String get username => user.username;
  String get email => user.email; 

  final FormSubmissionStatus formStatus;


  // Constructor default properties can be from required properties 
  ProfileState({
    @required User user, 
    @required bool isCurrentUser, 
    String avatarPath, 
    String userDescription,
    this.formStatus = const InitialFormStatus()
  }) : this.user = user, this.isCurrentUser = isCurrentUser, this.avatarPath = avatarPath, this.userDescription = userDescription ?? user.description;

  ProfileState copyWith ({
    User user, 
    String avatarPath, 
    String userDescription, 
    FormSubmissionStatus formStatus, 
  }) {
    return ProfileState(
      user: user ?? this.user,
      isCurrentUser: this.isCurrentUser,
      avatarPath: avatarPath ?? this.avatarPath,
      userDescription: userDescription ?? this.userDescription,
      formStatus: formStatus ?? this.formStatus
      );
  }
}

// Bloc map event to state 
class ProfileBloc extends Bloc<ProfileEvent, ProfileState>{

  ProfileBloc({@required User user, @required bool isCurrentUser}) : super(ProfileState(user: user, isCurrentUser: isCurrentUser));

  @override 
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is ChangeAvatarRequest){
      // show action sheet 


    } else if (event is OpenImagePicker) {
      // open image picker 

    } else if (event is ProvideImagePath) {

      // provide image path 
      yield state.copyWith(userDescription: event.avatarPath);

    } else if (event is ProfileDescriptionChanged) {

      yield state.copyWith(userDescription: event.description);

    } else if (event is SaveProfileChanges) {
      // handle save changes 

    };
  }


}


// Repository 