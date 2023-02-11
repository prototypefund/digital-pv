import 'package:flutter/material.dart';
import 'package:pd_app/general/themes/paddings.dart';
import 'package:pd_app/general/view_components/personal_details_form/personal_details_form_view_model.dart';
import 'package:provider/provider.dart';

class PersonalDetailsForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PersonalDetailsFormViewModel _viewModel = context.watch();

    return Column(
      children: [
        Padding(
          padding: Paddings.textFieldPadding,
          child: TextFormField(
              controller: _viewModel.surnameTextFieldController,
              style: Theme.of(context).textTheme.labelLarge,
              decoration: InputDecoration(label: Text(_viewModel.surnameLabel)),
              validator: _viewModel.surnameValidator),
        ),
        Padding(
          padding: Paddings.textFieldPadding,
          child: TextFormField(
              controller: _viewModel.nameTextFieldController,
              style: Theme.of(context).textTheme.labelLarge,
              decoration: InputDecoration(label: Text(_viewModel.nameLabel)),
              validator: _viewModel.nameValidator),
        ),
        Padding(
          padding: Paddings.textFieldPadding,
          child: TextFormField(
            controller: _viewModel.dateOfBirthTextFieldController,
            style: Theme.of(context).textTheme.labelLarge,
            decoration: InputDecoration(label: Text(_viewModel.dateOfBirthLabel)),
            validator: _viewModel.dateOfBirthValidator,
          ),
        ),
        Padding(
          padding: Paddings.textFieldPadding,
          child: TextField(
            controller: _viewModel.addressTextFieldController,
            style: Theme.of(context).textTheme.labelLarge,
            decoration: InputDecoration(label: Text(_viewModel.addressLabel)),
          ),
        ),
        Padding(
          padding: Paddings.textFieldPadding,
          child: TextField(
            controller: _viewModel.zipCodeTextFieldController,
            style: Theme.of(context).textTheme.labelLarge,
            decoration: InputDecoration(label: Text(_viewModel.zipCodeLabel)),
          ),
        ),
        Padding(
          padding: Paddings.textFieldPadding,
          child: TextField(
            controller: _viewModel.cityTextFieldController,
            style: Theme.of(context).textTheme.labelLarge,
            decoration: InputDecoration(label: Text(_viewModel.cityLabel)),
          ),
        ),
        Padding(
          padding: Paddings.textFieldPadding,
          child: TextField(
            controller: _viewModel.countryTextFieldController,
            style: Theme.of(context).textTheme.labelLarge,
            decoration: InputDecoration(label: Text(_viewModel.countryLabel)),
          ),
        ),
        Padding(
          padding: Paddings.textFieldPadding,
          child: TextFormField(
            controller: _viewModel.emailTextFieldController,
            style: Theme.of(context).textTheme.labelLarge,
            decoration: InputDecoration(label: Text(_viewModel.emailLabel)),
          ),
        ),
        Padding(
          padding: Paddings.textFieldPadding,
          child: TextFormField(
            controller: _viewModel.phoneTextFieldController,
            style: Theme.of(context).textTheme.labelLarge,
            decoration: InputDecoration(label: Text(_viewModel.phoneLabel)),
            validator: _viewModel.phoneNumberValidator,
          ),
        ),
      ],
    );
  }
}
