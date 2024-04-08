import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactUsFormTemplate extends StatelessWidget {
  final TextEditingController queryTitleController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController queryDetailsController;
  final String userRole;
  final Future<dynamic> sendQuery;
  const ContactUsFormTemplate({
    super.key,
    required this.queryTitleController,
    required this.emailController,
    required this.phoneController,
    required this.queryDetailsController,
    required this.userRole,
    required this.sendQuery,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: Column(
        children: [
          Text(
            "Role : $userRole",
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: queryTitleController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a title';
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: 'Title',
              prefixIcon: Icon(
                Icons.label,
                color: Theme.of(context).shadowColor,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter an email';
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(
                CupertinoIcons.mail,
                color: Theme.of(context).shadowColor,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: phoneController,
            keyboardType: TextInputType.number,
            maxLength: 10,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter an phone number';
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: 'Phone',
              prefixIcon: Icon(
                CupertinoIcons.phone,
                color: Theme.of(context).shadowColor,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: queryDetailsController,
            keyboardType: TextInputType.text,
            maxLines: 5,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter an query';
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: 'Your query',
              prefixIcon: Icon(
                Icons.abc_rounded,
                color: Theme.of(context).shadowColor,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 48,
            width: MediaQuery.of(context).size.width,
            child: CupertinoButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  await sendQuery;
                }
              },
              color: const Color(0xffFFE501),
              child: const Text(
                "Submit Query",
                style: TextStyle(
                  color: Color(0xFF3C096C),
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
