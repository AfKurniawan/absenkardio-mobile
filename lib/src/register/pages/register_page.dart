import 'package:absensi_prodi/animation/fade_animation.dart';
import 'package:absensi_prodi/src/login/providers/login_provider.dart';
import 'package:absensi_prodi/src/register/provider/register_provider.dart';
import 'package:absensi_prodi/src/styles/light_color.dart';
import 'package:absensi_prodi/src/utilities/localization.dart';
import 'package:absensi_prodi/src/widgets/button_widget.dart';
import 'package:absensi_prodi/src/widgets/form_widget.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {

  final FocusNode emailNode = FocusNode();
  final FocusNode passwordNode = FocusNode();

  final FocusNode repeatPasswordNode = FocusNode();

  final FocusNode namaLengkapNode = FocusNode();
  final FocusNode nimNode = FocusNode();
  final FocusNode periodeNode = FocusNode();

  final FocusNode alamatNode = FocusNode();
  final FocusNode nomorHpNode = FocusNode();

  RequiredValidator requiredValidator;
  final _formKey = GlobalKey<FormState>();
  TextEditingController controllerEmail = new TextEditingController();
  TextEditingController controllerNim = new TextEditingController();
  TextEditingController controllerFullName = new TextEditingController();
  TextEditingController controllerPassword = new TextEditingController();
  TextEditingController controllerPeriode = new TextEditingController();
  TextEditingController controllerHP = new TextEditingController();
  TextEditingController controllerAddress = new TextEditingController();
  TextEditingController controllerRepeatPassword = new TextEditingController();

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
        margin: EdgeInsets.only(top: 100),
        //height: MediaQuery.of(context).size.height,
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
                              "Aplikasi kehadiran\nPPDS Jantung & Pembuluh Darah\nFakultas Kedokteran\nUniversitas Sebelas Maret",
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
                        namaLengkapForm(context),
                        SizedBox(height: 20),
                        nimForm(context),
                        SizedBox(height: 20),
                        emailForm(context),
                        SizedBox(height: 20),
                        passwordForm(context),
                        SizedBox(height: 20),
                        repeatPasswordForm(context)
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
                              Navigator.pushReplacementNamed(context, "login_page");
                            },
                            child: Text(
                              AppLocalizations.of(context).translate("login_flat_button"),
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

  Widget namaLengkapForm(BuildContext context) {
    var local = AppLocalizations.of(context);
    final provider = Provider.of<LoginProvider>(context);
    final validator = RequiredValidator(errorText: local.translate("error_form_entry"));
    return FadeAnimation(
      1.8,
      FormWidget(
        hint: local.translate('form_nama_lengkap_hint'),
        obscure: false,
        color: Colors.white,
        textEditingController: controllerFullName,
        keyboardType: TextInputType.text,
        focusNode: namaLengkapNode,
        validator: validator,
        textInputAction: TextInputAction.next,
        icon: provider.iconuser,
        onsubmit: (term) {
          _fieldFocusChange(context, emailNode, passwordNode);
        },
      ),
    );
  }


  Widget emailForm(BuildContext context) {
    var local = AppLocalizations.of(context);
    final provider = Provider.of<LoginProvider>(context);
    final validator = RequiredValidator(errorText: local.translate("error_form_entry"));
    return FadeAnimation(
      1.8,
      FormWidget(
        hint: local.translate('form_email_hint'),
        obscure: false,
        color: Colors.white,
        textEditingController: controllerEmail,
        keyboardType: TextInputType.emailAddress,
        focusNode: emailNode,
        validator: validator,
        textInputAction: TextInputAction.next,
        icon: provider.iconEmail,
        onsubmit: (term) {
          _fieldFocusChange(context, emailNode, passwordNode);
        },
      ),
    );
  }

  Widget nimForm(BuildContext context) {
    var local = AppLocalizations.of(context);
    final provider = Provider.of<LoginProvider>(context);
    final validator = RequiredValidator(errorText: local.translate("error_form_entry"));
    return FadeAnimation(
      1.8,
      FormWidget(
        hint: local.translate('form_nim_hint'),
        obscure: false,
        textEditingController: controllerNim,
        keyboardType: TextInputType.text,
        focusNode: nimNode,
        color: Colors.white,
        validator: validator,
        textInputAction: TextInputAction.next,
        icon: provider.iconuser,
        onsubmit: (term) {
          _fieldFocusChange(context, emailNode, passwordNode);
        },
      ),
    );
  }

  Widget periodeForm(BuildContext context) {
    var local = AppLocalizations.of(context);
    final provider = Provider.of<LoginProvider>(context);
    final validator = RequiredValidator(errorText: local.translate("error_form_entry"));
    return FadeAnimation(
      1.8,
      FormWidget(
        hint: local.translate('form_periode_hint'),
        obscure: false,
        color: Colors.white,
        textEditingController: controllerPeriode,
        keyboardType: TextInputType.text,
        focusNode: periodeNode,
        validator: validator,
        textInputAction: TextInputAction.next,
        icon: provider.iconuser,
        onsubmit: (term) {
          _fieldFocusChange(context, emailNode, passwordNode);
        },
      ),
    );
  }

  Widget alamatForm(BuildContext context) {
    var local = AppLocalizations.of(context);
    final provider = Provider.of<LoginProvider>(context);
    final validator = RequiredValidator(errorText: local.translate("error_form_entry"));
    return FadeAnimation(
      1.8,
      FormWidget(
        hint: local.translate('form_alamat_hint'),
        obscure: false,
        color: Colors.white,
        textEditingController: controllerAddress,
        keyboardType: TextInputType.text,
        focusNode: alamatNode,
        validator: validator,
        textInputAction: TextInputAction.next,
        icon: provider.iconuser,
        onsubmit: (term) {
          _fieldFocusChange(context, emailNode, passwordNode);
        },
      ),
    );
  }

  Widget nomorHpForm(BuildContext context) {
    var local = AppLocalizations.of(context);
    final provider = Provider.of<LoginProvider>(context);
    final validator = RequiredValidator(errorText: local.translate("error_form_entry"));
    return FadeAnimation(
      1.8,
      FormWidget(
        hint: local.translate('form_hp_hint'),
        obscure: false,
        color: Colors.white,
        textEditingController: controllerHP,
        keyboardType: TextInputType.phone,
        focusNode: nomorHpNode,
        validator: validator,
        textInputAction: TextInputAction.next,
        icon: provider.iconuser,
        onsubmit: (term) {
          _fieldFocusChange(context, emailNode, passwordNode);
        },
      ),
    );
  }

  Widget passwordForm(BuildContext context) {
    var local = AppLocalizations.of(context);
    final provider = Provider.of<LoginProvider>(context);
    final validator = RequiredValidator(errorText: local.translate("error_form_entry"));
    return FadeAnimation(
        2.0,
        FormWidget(
          hint: local.translate('form_password_hint'),
          obscure: true,
          textEditingController: controllerPassword,
          keyboardType: TextInputType.text,
          focusNode: passwordNode,
          color: Colors.white,
          maxline: 1,
          textInputAction: TextInputAction.done,
          validator: validator,
          icon: IconButton(
            icon: provider.iconpass,
            color: provider.iconColor,
            onPressed: () {
              provider.showPass();
            },
          ),
        ));
  }

  Widget repeatPasswordForm(BuildContext context) {
    var local = AppLocalizations.of(context);
    final provider = Provider.of<LoginProvider>(context);
    final validator = RequiredValidator(errorText: local.translate("error_form_entry"));
    return FadeAnimation(
        2.0,
        FormWidget(
          hint: local.translate('form_repeat_password_hint'),
          obscure: true,
          textEditingController: controllerRepeatPassword,
          keyboardType: TextInputType.text,
          focusNode: repeatPasswordNode,
          color: Colors.white,
          maxline: 1,
          textInputAction: TextInputAction.done,
          validator: (val){
            if(val.isEmpty)
              return 'Empty';
            if(val != controllerPassword.text)
              return 'Not Match';
            return null;
          },
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
    final provider = Provider.of<RegisterProvider>(context, listen: false);
    return FadeAnimation(
      2.2,
      ButtonWidget(
        btnText: local.translate('register_button'),
        btnAction: () async {
          if (_formKey.currentState.validate()) {
            print("Validator Valid");
            final String email = controllerEmail.text.trim();
            final String password = controllerPassword.text.trim();
            final String phone = controllerEmail.text.trim();
            final String nim = controllerNim.text.trim();
            final String periode = controllerPeriode.text.trim();
            final String address = controllerAddress.text.trim();
            final String fullname = controllerFullName.text.trim();
            provider.register(context, fullname, nim, email, password);
          }

        },
      ),
    );
  }
}
