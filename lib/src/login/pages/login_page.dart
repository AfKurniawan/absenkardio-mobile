import 'package:absensi_prodi/animation/fade_animation.dart';
import 'package:absensi_prodi/src/login/providers/login_provider.dart';
import 'package:absensi_prodi/src/styles/light_color.dart';
import 'package:absensi_prodi/src/utilities/localization.dart';
import 'package:absensi_prodi/src/widgets/button_widget.dart';
import 'package:absensi_prodi/src/widgets/form_widget.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  final FocusNode emailnode = FocusNode();
  final FocusNode passwordnode = FocusNode();

  RequiredValidator requiredValidator;
  final _formKey = GlobalKey<FormState>();
  TextEditingController controllerEmail = new TextEditingController();
  TextEditingController controllerPassword = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black38, body: body(context));
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }


  Widget body(BuildContext context) {
    var local = AppLocalizations.of(context);
    // final provider = Provider.of<LoginProvider>(context);
    // final prefsprovider = Provider.of<PrefsProvider>(context);
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: 30),
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FadeAnimation(
              1.0,
              Container(
                height: 100,
                child: Image.asset('assets/icons/logo.png'),
              ),
            ),
            Stack(
              children: <Widget>[
                Positioned(
                  child: FadeAnimation(
                      1.2,
                      Container(
                        padding: EdgeInsets.all(40),
                        child: Column(
                          children: <Widget>[
                            Text(
                              local.translate("welcome_text"),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: LightColor.unsBlue,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      )),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        formEmail(context),
                        SizedBox(height: 20),
                        formPassword(context),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  buttonLogin(context),
                  SizedBox(
                    height: 50,
                  ),
                  FadeAnimation(
                      2.4,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, 'register_page');
                            },
                            child: Text(
                              AppLocalizations.of(context).translate("daftar_flat_button"),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(143, 148, 251, 1)),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget formEmail(BuildContext context) {
    var local = AppLocalizations.of(context);
    final provider = Provider.of<LoginProvider>(context);
    final emailValidator =
    RequiredValidator(errorText: local.translate("error_form_entry"));
    return FadeAnimation(
      1.8,
      FormWidget(
        hint: local.translate('form_email_hint'),
        obscure: false,
        color: Colors.white,
        textEditingController: controllerEmail,
        keyboardType: TextInputType.text,
        focusNode: emailnode,
        maxline: 1,
        validator: emailValidator,
        textInputAction: TextInputAction.next,
        icon: provider.iconuser,
        onsubmit: (term) {
          _fieldFocusChange(context, emailnode, passwordnode);
        },
      ),
    );
  }

  Widget formPassword(BuildContext context) {
    var local = AppLocalizations.of(context);
    final provider = Provider.of<LoginProvider>(context);
    final passwordValidator =
    RequiredValidator(errorText: local.translate("error_form_entry"));
    return FadeAnimation(
        2.0,
        FormWidget(
          hint: local.translate('form_password_hint'),
          obscure: true,
          color: Colors.white,
          textEditingController: controllerPassword,
          keyboardType: TextInputType.text,
          focusNode: passwordnode,
          maxline: 1,
          textInputAction: TextInputAction.done,
          validator: passwordValidator,
          icon: IconButton(
            icon: provider.iconpass,
            color: provider.iconColor,
            onPressed: () {
              provider.showPass();
            },
          ),
        ));
  }

  Widget buttonLogin(BuildContext context) {
    var local = AppLocalizations.of(context);
    return Consumer<LoginProvider>(builder: (context, provider, child) {
      return FadeAnimation(
        2.2,
        ButtonWidget(
          btnText: local.translate('login_button'),
          btnAction: () async {
            if (_formKey.currentState.validate()) {
              print("Validator Valid");
              final String email = controllerEmail.text.trim();
              final String password = controllerPassword.text.trim();
              final String phone = controllerEmail.text.trim();
              provider.login(context, email, password);
            }

          },
        ),
      );
    });
  }

}