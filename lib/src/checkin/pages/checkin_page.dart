import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:absensi_prodi/src/checkin/models/checkin_model.dart';
import 'package:absensi_prodi/src/checkin/pages/widgets/map_widget.dart';
import 'package:absensi_prodi/src/checkin/widgets/dialog_error.dart';
import 'package:absensi_prodi/src/checkin/widgets/loading_widgets.dart';
import 'package:absensi_prodi/src/checkin/widgets/timer_widget.dart';
import 'package:absensi_prodi/src/configs/constants.dart';
import 'package:absensi_prodi/src/checkout/pages/checkout_page.dart';
import 'package:absensi_prodi/src/styles/light_color.dart';
import 'package:absensi_prodi/src/styles/text_styles.dart';
import 'package:absensi_prodi/src/utilities/localization.dart';
import 'package:absensi_prodi/src/widgets/button_widget.dart';
import 'package:absensi_prodi/src/widgets/dialog_error_widget.dart';
import 'package:absensi_prodi/src/widgets/form_widget.dart';
import 'package:achievement_view/achievement_view.dart';
import 'package:achievement_view/achievement_widget.dart';
import 'package:cupertino_radio_choice/cupertino_radio_choice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;

class CheckinPage extends StatefulWidget {
  @override
  _CheckinPageState createState() => _CheckinPageState();
}

class _CheckinPageState extends State<CheckinPage> {
  Future<Position> _future;
  Set<Marker> _markers = {};
  final Geolocator geolocator = Geolocator();
  List<Placemark> placemarks;

  LatLng _userLocation;

  Position position;
  String _currentAddress;
  GoogleMapController _mapController;
  Widget _child;
  Placemark place;

  void getCurrentLocation() async {
    Position res = await Geolocator.getCurrentPosition();
    setState(() {
      position = res;
      _child = mapWidget();
      getAddress(position.latitude, position.longitude);
    });
  }

  getAddress(double lat, double long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    setState(() {
      place = placemarks[0];
      _currentAddress =
          "${place.subLocality}, ${place.subAdministrativeArea}, ${place.administrativeArea}";
      print("$_currentAddress");
    });
  }

  Widget mapWidget() {
    return GoogleMap(
      markers: _createMarker(),
      myLocationEnabled: true,
      initialCameraPosition: CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 16.0,
      ),
      onMapCreated: (GoogleMapController controller) {
        _mapController = controller;
      },
    );
  }

  Set<Marker> _createMarker() {
    return <Marker>[
      Marker(
          markerId: MarkerId("mylocation"),
          position: LatLng(position.latitude, position.longitude),
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(title: "My Location"))
    ].toSet();
  }

  String _timeString = "";
  String _dateString = "";
  String _fileString = "";
  String _dateStringSend = "";
  TextEditingController controllerIzin = new TextEditingController();

  @override
  void initState() {
    _dateString = _formatDate(DateTime.now());
    _timeString = _formatTime(DateTime.now());
    _dateStringSend = _formatDateSend(DateTime.now());
    getUserId();
    getCheckinState();
    getCurrentLocation();
    _child = SpinKitDoubleBounce(color: LightColor.unsBlue);
    super.initState();
  }

  String uid = "";
  getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = prefs.getString('uid');
    });
    print("USERID $uid");
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDate = _formatDate(now);
    final String formmattedTime = _formatTime(now);
    final String formattedFilename = _dateFilename(now);
    final String formattedDateSend = _formatDateSend(now);
    if (mounted) {
      setState(() {
        _dateString = formattedDate;
        _timeString = formmattedTime;
        _fileString = formattedFilename;
        _dateStringSend = formattedDateSend;

      });
    }
  }

  String _formatDate(DateTime dateTime) {
    return DateFormat('dd MMMM yyyy', "id_ID").format(dateTime.toLocal());
  }

  String _formatDateSend(DateTime formatKirim) {
    return DateFormat('yyy-MM-dd').format(formatKirim);
  }

  String _dateFilename(DateTime namaFile){
    return DateFormat('ddMMyyhhmmss').format(namaFile.toLocal());
  }

  String _formatTime(DateTime dateTime) {
    return DateFormat('HH:mm:ss', "id_ID").format(dateTime.toLocal());
  }

  static final Map<String, String> status = {
    'Hadir': 'Hadir',
    'Sakit': 'Sakit',
    'Izin': 'Izin'
  };

  String seletedStatus = status.keys.first;

  File _image;
  final picker = ImagePicker();
  String fileName = "";

  Future getImage2() async {
    var picture = await picker.pickImage(
      maxWidth: 500,
      imageQuality: 50,
      source: ImageSource.camera,
      maxHeight: 500,
    );
    print('Original path: ${picture.path}');
    String dir = path.dirname(picture.path);
    String newPath = path.join(dir, '$uid$_fileString.jpg');
    File(picture.path).renameSync(newPath);
    print('NewPath: $newPath');
    setState(() {
      if(picture != null){
        fileName = '$uid$_fileString.jpg';
        _image = File(newPath);
      }

    });

  }

  Future getImage() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.camera,
        imageQuality: 5,
        maxHeight: 500,
    );
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        fileName = _image.path.split("/").last;
      } else {
        print('No image selected.');
      }
    });
  }

  bool isUploading = false;

  void _upload(BuildContext context) {
    isUploading = true;
    if (_image == null) return;
    String base64Image = base64Encode(_image.readAsBytesSync());
    final String url = Constants.UPLOAD_IMAGE;
    print("Filename on upload $fileName");
    http.post(Uri.parse(url), body: {
      "image": base64Image,
      "name": fileName,
    }).then((res) {
      if (res.statusCode == 200) {
        isUploading = false;
        print("Success");
        showSuccess(context);
      } else {
        print("gagal");
      }
    }).catchError((err) {
      print(err);
    });
  }

  void showSuccess(BuildContext context) {
    AchievementView(
      context,
      title: "Berhasil",
      subTitle: "Absensi sudah berhasil di simpan   ",
      isCircle: true,
      alignment: Alignment.bottomCenter,
      duration: Duration(milliseconds: 2000),
      icon: Icon(Icons.assignment_turned_in, color: Colors.white),
      listener: (status) {
        //if(status == ach)
        print(status);
        if (status == AchievementState.open) {
          _image = null;
          setCheckinState(true);
          Navigator.of(context).pushReplacementNamed("main_page", arguments: 0);
        }
      },
    )..show();
  }

  Future<void> showDialogError(BuildContext context) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) => ErrorDialog(
              title: "Anda belum melakukan foto selfie",
              description:
                  "Silahkan melakukan foto selfie terlebih dahulu sebelum absen...",
              filledButtonText: "Oke",
              filledButtonaction: () {
                Navigator.of(context).pop();
              },
            ));
  }

  // Future<CheckinModel> checkinAction() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var url = Constants.CHECKIN_URL;
  //   Map<String, String> header = {
  //     "Accept": "application/json",
  //   };
  //
  //   var body = {
  //         'idno': prefs.getString('nim'),
  //         'date': "$_dateStringSend",
  //         'employee': "${prefs.getString('fullName')}",
  //         'timein': "$_timeString",
  //         'location': _currentAddress,
  //         'statusin': seletedStatus,
  //         'reason': controllerIzin.text,
  //         'selfie': fileName,
  //   };
  //   final response = await http.post(Uri.parse(url), headers: header, body: body);
  //   var responseJson = json.decode(response.body);
  //   //print("RESPONSE BODY $body");
  //   print("RESPONSE BODY $responseJson");
  //
  // }


  void checkin(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    checkinAction(Constants.CHECKIN_URL, json.encode({

      'idno': prefs.getString('nim'),
      'date': "$_dateStringSend",
      'employee': "${prefs.getString('fullName')}",
      'timein': "$_timeString",
      'location': _currentAddress,
      'statusin': seletedStatus,
      'reason': controllerIzin.text,
      'selfie': fileName,

    })).then((response) {
      if (response.error == false && _image != null) {
        _upload(context);
        print("Filename on data input $fileName");
      } else if((seletedStatus == 'Izin' && _image == null) && controllerIzin.text.isNotEmpty){
        isUploading = false;
        print("Success");
        showSuccess(context);
      } else if(seletedStatus == "Izin" && controllerIzin.text.isEmpty){
        failedDialogIzinEmpty(context);
      } else {
        failedDialog(context);
      }
    });
  }



  Future<CheckinModel> checkinAction(String url, var body) async {
    print(body);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await http.post(Uri.parse(url),
        body: body,
        headers: {"Accept": "application/json", 'Content-type': 'application/json'}).then((http.Response response) {
      print("BODY RESPONSE ${response.body}");
      final int statusCode = response.statusCode;
      var users = CheckinModel.fromJson(json.decode(response.body));

      prefs.setString('chekinTime', users.checkin.timein);
      prefs.setString('location', users.checkin.location);
      prefs.setString('dateIn', users.checkin.date);
      prefs.setString('reason', users.checkin.reason);
      prefs.setString('statusIn', users.checkin.statusTimein);
      prefs.setString('selfie', users.checkin.selfie);

      print("DATE TO CHECKIN ===> $_dateStringSend");

      print("STATUS CODE${response.statusCode}");

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return users;
    });
  }

  bool isCheckin = false;
  setCheckinState(bool checkin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isCheckin', checkin);
  }


  bool isLoading = true ;
  String nim = "" ;
  getCheckinState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoading = false ;
      isCheckin = prefs.getBool('isCheckin');
      nim = prefs.getString('nim');
    });
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
  }

  failedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialogError(
        title: AppLocalizations.of(context)
            .translate("title_register_dialog_error"),
        description: AppLocalizations.of(context)
            .translate("description_register_dialog_error"),
        buttonText: AppLocalizations.of(context)
            .translate("button_register_dialog_error"),
      ),
    );
  }

  failedDialogLokasi(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialogError(
        title: "Lokasi Tidak Valid",
        description: "Lokasi anda tidak dapat divalidasi",
        buttonText: AppLocalizations.of(context)
            .translate("button_register_dialog_error"),
      ),
    );
  }

  failedDialogIzinEmpty(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialogError(
        title: "Keterangan izin belum diisi",
        description: "Silahkan isi keterangan izin",
        buttonText: AppLocalizations.of(context)
            .translate("button_register_dialog_error"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    final genderSelectionTile = new Material(
      color: Colors.transparent,
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(bottom: 5.0),
          ),
          CupertinoRadioChoice(
              choices: status,
              onChange: onStatusChange,
              selectedColor: LightColor.unsBlue,
              initialKeyValue: seletedStatus),
        ],
      ),
    );
    return Scaffold(
        appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Checkin",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 1,
        backgroundColor: Theme.of(context).backgroundColor,
        // leading: IconButton(
        //     icon: Icon(
        //       Icons.short_text,
        //       size: 30,
        //       color: Colors.black,
        //     ),
        //     onPressed: () {
        //       _scaffoldKey.currentState.openDrawer();
        //     }
        // ),
        actions: <Widget>[
          // FadeAnimation(
          //   2,
          //   ClipRRect(
          //     borderRadius: BorderRadius.all(Radius.circular(13)),
          //     child: Container(
          //       // height: 40,
          //       // width: 40,
          //       decoration: BoxDecoration(
          //         color: Theme.of(context).backgroundColor,
          //       ),
          //       child: Image.asset("assets/icons/user.png", fit: BoxFit.fill),
          //     ),
          //   ).p(8),
          // ),
        ],
      ),
      body: isLoading == true ?
      Center(
        child: Container(
            child: SpinKitDoubleBounce(color: LightColor.unsBlue)),
            )
          : SingleChildScrollView(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      TimerWidget(dateString: _dateString, timeString: _timeString),
                      SizedBox(height: 20),
                      Text("Status",
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.w300)),
                      SizedBox(height: 10),
                      genderSelectionTile,
                      SizedBox(height: 30),
                      seletedStatus == 'Izin'
                          ? Text("Keterangan Izin",
                              style: TextStyle(
                                  fontSize: 28, fontWeight: FontWeight.w300))
                          : seletedStatus == 'Sakit'
                              ? Text("Foto surat keterangan sakit",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300))
                              : Text("Foto Selfie",
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w300)),
                      SizedBox(height: 10),
                      seletedStatus == 'Izin'
                          ? FormWidget(
                              maxline: 3,
                              hint: local.translate('form_izin'),
                              obscure: false,
                              textEditingController: controllerIzin,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              icon: IconButton(icon: Icon(Icons.text_fields)),
                            )
                          : _image == null
                              ? Container()
                              : ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                  ),
                                  child: Image.file(_image, width: 150)),
                      SizedBox(height: 30),
                      seletedStatus == 'Izin' ? Container()
                      : InkWell(
                        onTap: () {
                          getImage2();
                        },
                        splashColor: Color.fromRGBO(143, 148, 251, 1),
                        child: Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width - 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(colors: [
                                LightColor.unsBlue,
                                Color.fromRGBO(143, 148, 251, .6),
                              ])),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Icon(Icons.camera_alt_outlined,
                                      size: 40, color: Colors.white)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      viewMaps(),
                      SizedBox(height: 30),
                      isUploading == true
                          ? InkWell(
                              onTap: () {},
                              splashColor: Color.fromRGBO(143, 148, 251, 1),
                              child: Container(
                                height: 60,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(colors: [
                                      LightColor.unsBlue,
                                      Color.fromRGBO(143, 148, 251, .6),
                                    ])),
                                child: Center(
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SpinKitDoubleBounce(
                                          color: Colors.white)),
                                ),
                              ),
                            )
                          : isCheckin == true ? Container()
                          : InkWell(
                              onTap: () {
                                if (_image == null && seletedStatus != "Izin") {
                                  showDialogError(context);
                                } else if(seletedStatus == 'Izin' && _image == null){
                                  checkin(context);
                                } else if(seletedStatus != 'Izin' && _image != null){
                                  checkin(context);
                                } else if(position.latitude == null || position.longitude == null ){
                                  failedDialogLokasi(context);
                                } else {
                                  showDialogError(context);
                                }
                              },
                              splashColor: Color.fromRGBO(143, 148, 251, 1),
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(colors: [
                                      LightColor.unsBlue,
                                      Color.fromRGBO(143, 148, 251, .6),
                                    ])),
                                child: Center(
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Check-In",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 18),
                                      )),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget viewMaps() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.blueAccent, width: 4),
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3,
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
          ),
          child: _child,
        ),
      ),
    );
  }

  void onStatusChange(String key) {
    setState(() {
      seletedStatus = key;
    });
  }
}

