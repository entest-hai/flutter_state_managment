import 'package:flutter/material.dart';
import 'social_user_model.dart';
import 'social_profile_event.dart';
import 'social_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({@required User user, @required bool isCurrentUser}) : super(ProfileState(user: user, isCurrentUser: isCurrentUser));

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is ChangeAvatarRequest) {
      // show action sheet 
    } else if (event is OpenImagePicker) {
      // open image picker 
    } else if (event is ProvideImagePath) {
      yield state.copyWith(avatarPath: event.avatarPath); 
    } else if (event is ProfileDescriptionChanged) {
      yield state.copyWith(userDescription: event.description);
    } else if (event is SaveProfileChanges) {
      // handle save changes 
    }
  }
}