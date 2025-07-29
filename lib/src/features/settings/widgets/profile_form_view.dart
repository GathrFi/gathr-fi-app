import 'package:flutter/material.dart';

import '../../../shared/extensions/ext_misc.dart';
import '../../../shared/widgets/global_label_wrapper.dart';

class ProfileFormView extends StatefulWidget {
  const ProfileFormView({super.key});

  @override
  State<ProfileFormView> createState() => _ProfileFormViewState();
}

class _ProfileFormViewState extends State<ProfileFormView> {
  final _usernameController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GlobalLabelWrapper(
          label: context.l10n.iUsernameLabel,
          child: TextField(
            controller: _usernameController,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(hintText: context.l10n.iUsernameHint),
          ),
        ),
      ],
    );
  }
}
