import 'package:flutter/material.dart';
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
