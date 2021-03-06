import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/activitymodel.dart';
import '../../provider/activity_provider.dart';
import '../../provider/user_provider.dart';
import '../../screens/pickers/image_picker.dart';

import '../../theme/theme.dart';
import '../../theme/extention.dart';
import '../../theme/text_styles.dart';
import '../../components/FormInput.dart';
import '../../components/AppBars/appBar.dart';
import '../../components/RoundedButton.dart';
import '../../routes.dart';

class EditActivity extends StatefulWidget {
  final Activity activity;
  EditActivity([this.activity]);
  @override
  _EditActivityState createState() => _EditActivityState();
}

class _EditActivityState extends State<EditActivity> {
  final activityTitleController = TextEditingController();
  final activityDescriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  String imageUrl;
  File _activityImage;

  void _pickedImage(File image) {
    _activityImage = image;
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    //New Record
    if (widget.activity == null) {
      titleController.text = "";
      descriptionController.text = "";
      new Future.delayed(Duration.zero, () {
        final productProvider =
            Provider.of<ActivityProvider>(context, listen: false);

        productProvider.loadValues(Activity());
      });
    } else {
      //Controller Update
      titleController.text = widget.activity.title;
      descriptionController.text = widget.activity.description;
      imageUrl = widget.activity.image;
      // State Update
      new Future.delayed(Duration.zero, () {
        final productProvider =
            Provider.of<ActivityProvider>(context, listen: false);
        productProvider.loadValues(widget.activity);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final activityProvider = Provider.of<ActivityProvider>(context);
    final user = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: GlobalAppBar(),
      backgroundColor: Color(0XFFfefefe),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Publish Your Activity',
                    style: TextStyles.title.bold,
                  ),
                  SizedBox(height: AppTheme.fullHeight(context) * 0.02),
                  FormInput(
                    controller: titleController,
                    hintText: "Activity Title",
                    key: ValueKey('activity_title'),
                    maxlines: 1,
                    maxlength: 50,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Title cannot be empty';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      activityProvider.changeTitle(value);
                    },
                  ),
                  ImageFilePicker(
                    _pickedImage,
                    imageType: ImageType.activity,
                    existingImage: imageUrl,
                  ),
                  FormInput(
                    controller: descriptionController,
                    hintText: "Describe your Activity",
                    key: ValueKey('activity_description'),
                    maxlength: 1000,
                    maxlines: 18,
                    enableSuggesstion: false,
                    keyboardType: TextInputType.multiline,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Description cannot be empty';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      activityProvider.changeDescription(value);
                    },
                  ),
                  activityProvider.saveState == SaveState.Saving
                      ? CircularProgressIndicator()
                      : RoundButton(
                          text: 'Submit Activity',
                          onPress: () async {
                            bool validated = _formKey.currentState.validate();
                            FocusScope.of(context).unfocus();
                            // _formKey.currentState.save();

                            if (validated) {
                              if (widget.activity == null)
                                await activityProvider.saveActivity(
                                    user.id, user.name);
                              else
                                await activityProvider
                                    .updateActivity(widget.activity.activityID);
                              Navigator.pushReplacementNamed(
                                  context, Routes.activities_list);
                            }
                          },
                        ).alignBottomCenter,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
