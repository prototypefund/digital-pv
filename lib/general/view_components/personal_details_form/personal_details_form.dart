import 'package:flutter/material.dart';
import 'package:pd_app/general/themes/colors.dart';
import 'package:pd_app/general/themes/paddings.dart';
import 'package:pd_app/general/view_components/personal_details_form/personal_details_form_view_model.dart';
import 'package:provider/provider.dart';

class PersonalDetailsForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PersonalDetailsFormViewModel viewModel = context.watch();

    return Column(
      children: [
        Padding(
          padding: Paddings.textFieldPadding,
          child: TextFormField(
              controller: viewModel.surnameTextFieldController,
              style: Theme.of(context).textTheme.labelLarge,
              decoration: InputDecoration(label: Text(viewModel.surnameLabel)),
              validator: viewModel.surnameValidator),
        ),
        Padding(
          padding: Paddings.textFieldPadding,
          child: TextFormField(
              controller: viewModel.nameTextFieldController,
              style: Theme.of(context).textTheme.labelLarge,
              decoration: InputDecoration(label: Text(viewModel.nameLabel)),
              validator: viewModel.nameValidator),
        ),
        Padding(
          padding: Paddings.textFieldPadding,
          child: TextFormField(
            controller: viewModel.dateOfBirthTextFieldController,
            style: Theme.of(context).textTheme.labelLarge,
            decoration: InputDecoration(label: Text(viewModel.dateOfBirthLabel)),
            validator: viewModel.dateOfBirthValidator,
          ),
        ),
        Padding(
          padding: Paddings.textFieldPadding,
          child: TextField(
            controller: viewModel.addressTextFieldController,
            style: Theme.of(context).textTheme.labelLarge,
            decoration: InputDecoration(label: Text(viewModel.addressLabel)),
          ),
        ),
        Padding(
          padding: Paddings.textFieldPadding,
          child: TextField(
            controller: viewModel.zipCodeTextFieldController,
            style: Theme.of(context).textTheme.labelLarge,
            decoration: InputDecoration(label: Text(viewModel.zipCodeLabel)),
          ),
        ),
        Padding(
          padding: Paddings.textFieldPadding,
          child: TextField(
            controller: viewModel.cityTextFieldController,
            style: Theme.of(context).textTheme.labelLarge,
            decoration: InputDecoration(label: Text(viewModel.cityLabel)),
          ),
        ),
        Padding(
          padding: Paddings.textFieldPadding,
          child: TextField(
            controller: viewModel.countryTextFieldController,
            style: Theme.of(context).textTheme.labelLarge,
            decoration: InputDecoration(label: Text(viewModel.countryLabel)),
          ),
        ),
        Padding(
          padding: Paddings.textFieldPadding,
          child: TextFormField(
            controller: viewModel.emailTextFieldController,
            style: Theme.of(context).textTheme.labelLarge,
            decoration: InputDecoration(label: Text(viewModel.emailLabel)),
          ),
        ),
        Padding(
          padding: Paddings.textFieldPadding,
          child: TextFormField(
            controller: viewModel.phoneTextFieldController,
            style: Theme.of(context).textTheme.labelLarge,
            decoration: InputDecoration(label: Text(viewModel.phoneLabel)),
            validator: viewModel.phoneNumberValidator,
          ),
        ),
      ],
    );
  }
}

class PersonalDetailsForm2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PersonalDetailsFormViewModel viewModel = context.watch();

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 64),
          child: _getPersonalDetailsForm(viewModel),
        ),
      ],
    );
  }

  Widget _getPersonalDetailsForm(PersonalDetailsFormViewModel viewModel) {
    switch (viewModel.navigationStep) {
      case NavigationSubStep.name:
        return _getNameEditForm(viewModel);
      case NavigationSubStep.address:
        return _getAddressEditForm(viewModel);
      case NavigationSubStep.contact:
        return _getContactEditForm(viewModel);
    }
  }

  Widget _getNameEditForm(PersonalDetailsFormViewModel viewModel) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 250,
              child: CustomTextField(
                controller: viewModel.surnameTextFieldController,
                labelText: viewModel.surnameLabel,
              ),
            ),
            const SizedBox(width: 50),
            SizedBox(
              width: 250,
              child: CustomTextField(
                controller: viewModel.nameTextFieldController,
                labelText: viewModel.nameLabel,
              ),
            ),
          ],
        ),
        const SizedBox(height: 50),
        SizedBox(
          width: 550,
          child: CustomTextField(
            controller: viewModel.dateOfBirthTextFieldController,
            labelText: viewModel.dateOfBirthLabel,
          ),
        ),
      ],
    );
  }

  Column _getAddressEditForm(PersonalDetailsFormViewModel viewModel) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 350,
              child: CustomTextField(
                controller: viewModel.addressTextFieldController,
                labelText: viewModel.addressLabel,
              ),
            ),
            const SizedBox(width: 50),
            SizedBox(
              width: 150,
              child: CustomTextField(
                controller: viewModel.zipCodeTextFieldController,
                labelText: viewModel.zipCodeLabel,
              ),
            ),
          ],
        ),
        const SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 250,
              child: CustomTextField(
                controller: viewModel.cityTextFieldController,
                labelText: viewModel.cityLabel,
              ),
            ),
            const SizedBox(width: 50),
            SizedBox(
              width: 250,
              child: CustomTextField(
                controller: viewModel.countryTextFieldController,
                labelText: viewModel.countryLabel,
              ),
            ),
          ],
        )
      ],
    );
  }

  Column _getContactEditForm(PersonalDetailsFormViewModel viewModel) {
    return Column(
      children: [
        SizedBox(
          width: 550,
          child: CustomTextField(
            controller: viewModel.emailTextFieldController,
            labelText: viewModel.emailLabel,
          ),
        ),
        const SizedBox(height: 50),
        SizedBox(
          width: 550,
          child: CustomTextField(
            controller: viewModel.phoneTextFieldController,
            labelText: viewModel.phoneLabel,
          ),
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
