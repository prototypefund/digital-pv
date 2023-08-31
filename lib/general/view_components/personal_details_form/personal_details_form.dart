import 'package:flutter/material.dart';
import 'package:pd_app/general/themes/colors.dart';
import 'package:pd_app/general/view_components/personal_details_form/personal_details_form_view_model.dart';
import 'package:pd_app/use_cases/personal_details/personal_details_view_model.dart';
import 'package:provider/provider.dart';

class PersonalDetailsForm extends StatelessWidget {
  const PersonalDetailsForm({super.key, required this.navigationStep});

  // TODO: find a better way to control navigation
  final NavigationSubStep navigationStep;

  @override
  Widget build(BuildContext context) {
    final PersonalDetailsFormViewModel viewModel = context.watch();

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 64),
          width: 700,
          child: _getPersonalDetailsForm(viewModel),
        ),
      ],
    );
  }

  Widget _getPersonalDetailsForm(PersonalDetailsFormViewModel viewModel) {
    switch (navigationStep) {
      case NavigationSubStep.name:
        return _getNameEditForm(viewModel);
      case NavigationSubStep.birthday:
        return _getBirthdayEditForm(viewModel);
      case NavigationSubStep.address:
        return _getAddressEditForm(viewModel);
      case NavigationSubStep.contact:
        return _getContactEditForm(viewModel);
    }
  }

  Column _getNameEditForm(PersonalDetailsFormViewModel viewModel) {
    return Column(
      children: [
        CustomTextField(
          controller: viewModel.surnameTextFieldController,
          labelText: viewModel.surnameLabel,
        ),
        const SizedBox(height: 64),
        CustomTextField(
          controller: viewModel.nameTextFieldController,
          labelText: viewModel.nameLabel,
        ),
      ],
    );
  }

  Column _getBirthdayEditForm(PersonalDetailsFormViewModel viewModel) {
    return Column(
      children: [
        CustomTextField(
          controller: viewModel.dateOfBirthTextFieldController,
          labelText: viewModel.dateOfBirthLabel,
        ),
      ],
    );
  }

  Column _getAddressEditForm(PersonalDetailsFormViewModel viewModel) {
    return Column(
      children: [
        CustomTextField(
          controller: viewModel.addressTextFieldController,
          labelText: viewModel.addressLabel,
        ),
        const SizedBox(height: 32),
        CustomTextField(
          controller: viewModel.zipCodeTextFieldController,
          labelText: viewModel.zipCodeLabel,
        ),
        const SizedBox(height: 32),
        CustomTextField(
          controller: viewModel.cityTextFieldController,
          labelText: viewModel.cityLabel,
        ),
        const SizedBox(height: 32),
        CustomTextField(
          controller: viewModel.countryTextFieldController,
          labelText: viewModel.countryLabel,
        ),
      ],
    );
  }

  Column _getContactEditForm(PersonalDetailsFormViewModel viewModel) {
    return Column(
      children: [
        CustomTextField(
          controller: viewModel.emailTextFieldController,
          labelText: viewModel.emailLabel,
        ),
        const SizedBox(height: 64),
        CustomTextField(
          controller: viewModel.phoneTextFieldController,
          labelText: viewModel.phoneLabel,
        ),
      ],
    );
  }
}

// TODO: move to separate file
class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.controller, required this.labelText});

  final TextEditingController controller;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 25),
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(width: 2, color: DefaultThemeColors.magenta), // change color here
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(width: 2, color: DefaultThemeColors.veryDarkMagenta), // change color here
        ),
        filled: true,
        fillColor: Colors.transparent,
      ),
    );
  }
}
