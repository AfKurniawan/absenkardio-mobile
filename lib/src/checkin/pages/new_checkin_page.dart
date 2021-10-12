import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:absensi_prodi/src/checkin/models/checkin_model.dart';
import 'package:absensi_prodi/src/checkin/widgets/dialog_error.dart';
import 'package:absensi_prodi/src/checkin/widgets/global.dart';
import 'package:absensi_prodi/src/checkin/widgets/locationrow.dart';
import 'package:absensi_prodi/src/checkin/widgets/mymap.dart';
import 'package:absensi_prodi/src/checkin/widgets/timer_widget.dart';
import 'package:absensi_prodi/src/configs/constants.dart';
import 'package:absensi_prodi/src/styles/light_color.dart';
import 'package:absensi_prodi/src/widgets/dialog_error_widget.dart';
import 'package:absensi_prodi/src/widgets/form_widget.dart';
import 'package:achievement_view/achievement_view.dart';
import 'package:achievement_view/achievement_widget.dart';
import 'package:cupertino_radio_choice/cupertino_radio_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_analog_clock/flutter_analog_clock.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttericon/linearicons_free_icons.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

class NewCheckinPage extends StatefulWidget {
  @override
  _NewCheckinPageState createState() => _NewCheckinPageState();
}

class _NewCheckinPageState extends State<NewCheckinPage> {
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
    if (mounted) {
      setState(() {
        position = res;
        _child = mapWidget();
        getAddress(position.latitude, position.longitude);
      });
    }
  }

  getAddress(double lat, double long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    if (mounted) {
      setState(() {
        place = placemarks[0];
        _currentAddress =
            "${place.subLocality}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.postalCode}";
        print("$_currentAddress");
      });
    }
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
  String _tahun = "" ;
  String _bulan = "" ;
  String _tanggal = "" ;
  TextEditingController controllerIzin = new TextEditingController();

  @override
  void initState() {
    _dateString = _formatDate(DateTime.now());
    _timeString = _formatTime(DateTime.now());
    _dateStringSend = _formatDateSend(DateTime.now());
    _tahun = _formatTahun(DateTime.now());
    _bulan = _formatBulan(DateTime.now());
    _tanggal = _formatHari(DateTime.now());
    getUserId();
    getCheckinState();
    getCurrentLocation();
    _child = Center(child: SpinKitDoubleBounce(color: LightColor.unsBlue));
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
    final String formattedTahun = _formatTahun(now);
    final String formattedTanggal = _formatHari(now);
    final String formattedBulan = _formatBulan(now);
    if (mounted) {
      setState(() {
        _dateString = formattedDate;
        _timeString = formmattedTime;
        _fileString = formattedFilename;
        _dateStringSend = formattedDateSend;
        _tahun = formattedTahun;
        _bulan = formattedBulan;
        _tanggal = formattedTanggal;
      });
    }
  }

  String _formatDate(DateTime dateTime) {
    return DateFormat('dd MMMM yyyy', "id_ID").format(dateTime.toLocal());
  }

  String _formatDateSend(DateTime formatKirim) {
    return DateFormat('yyy-MM-dd').format(formatKirim);
  }

  String _dateFilename(DateTime namaFile) {
    return DateFormat('ddMMyyhhmmss').format(namaFile.toLocal());
  }

  String _formatTime(DateTime dateTime) {
    return DateFormat('HH:mm:ss', "id_ID").format(dateTime.toLocal());
  }
  String _formatHari(DateTime dateTime) {
    return DateFormat('dd', "id_ID").format(dateTime.toLocal());
  }
  String _formatBulan(DateTime dateTime) {
    return DateFormat('MMMM', "id_ID").format(dateTime.toLocal());
  }
  String _formatTahun(DateTime dateTime) {
    return DateFormat('yyyy', "id_ID").format(dateTime.toLocal());
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
      if (picture != null) {
        fileName = '$uid$_fileString.jpg';
        _image = File(newPath);
      }
    });
  }

  Future getImage() async {
    final pickedFile = await picker.pickImage(
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
      subTitle: "Absensi sudah berhasil di simpan, Selamat beraktifitas   ",
      isCircle: true,
      alignment: Alignment.bottomCenter,
      duration: Duration(milliseconds: 4000),
      icon: Icon(Icons.assignment_turned_in, color: Colors.white),
      listener: (status) {
        //if(status == ach)
        print(status);
        if (status == AchievementState.open) {
          _image = null;
          setCheckinState(true);
        }
      },
    )..show();
  }

  Future<void> showDialogError(BuildContext context, String title, String deskripsi) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) => ErrorDialog(
              title: "$title",
              description:
                  "$deskripsi",
              filledButtonText: "Oke",
              filledButtonaction: () {
                Navigator.of(context).pop();
              },
            ));
  }

  Future<CheckinModel> checkin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = Constants.CHECKIN_URL;
    var body = {
      'uid': prefs.getString('uid'),
      'idno': prefs.getString('nim'),
      'date': "$_dateStringSend",
      'employee': "${prefs.getString('fullName')}",
      'timein': "$_timeString",
      'location': _currentAddress,
      'statusin': seletedStatus,
      'reason': controllerIzin.text,
      'selfie': fileName,
    };

    print("YOUR BODY REQUEST IS ${json.encode(body)}");

    Map<String, String> headers = {
      "Accept": "application/json",
      'Content-type': 'application/json'
    };

    var response = await http.post(Uri.parse(url),
        body: json.encode(body), headers: headers);
    print("RESPONSE BODY ==> ${response.body}");
    final users = CheckinModel.fromJson(json.decode(response.body));
    if (response.statusCode == 200) {
      prefs.setString('chekinTime', users.checkin.timein);
      prefs.setString('location', users.checkin.location);
      prefs.setString('dateIn', users.checkin.date);
      prefs.setString('reason', users.checkin.reason);
      prefs.setString('statusin', users.checkin.statusTimein);
      prefs.setString('selfie', users.checkin.selfie);
      _upload(context);
      showSuccess(context);
    } else if (users.messages == "AllReadyCheckin") {
      failedDialog(context, "Checkin Gagal", "Anda sudah checkin hari ini");
    } else {
      failedDialog(context, "Checkin Gagal", "Silahkan coba lagi nanti");
    }
    return users;
  }

  bool isCheckin = false;
  setCheckinState(bool checkin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isCheckin', checkin);
    if (mounted) {
      Navigator.of(context).pushReplacementNamed("main_page", arguments: 0);
    }
  }

  bool isLoading = true;
  String nim = "";
  getCheckinState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoading = false;
      isCheckin = prefs.getBool('isCheckin');
      nim = prefs.getString('nim');
    });
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
  }

  failedDialog(BuildContext context, String title, String description) {
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialogError(
          title: "$title", description: "$description", buttonText: "Oke"),
    );
  }

  void onStatusChange(String key) {
    setState(() {
      seletedStatus = key;
    });
  }

  @override
  Widget build(BuildContext context) {
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("Check-in", style: TextStyle(color: LightColor.unsBlue)),
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[
          Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: _child),
          SingleChildScrollView(
            padding: EdgeInsets.only(top: 180),
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(1, 4),
                      blurRadius: 6,
                      color: Colors.black,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18, top: 10),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 3,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[600],
                          borderRadius: BorderRadius.all(Radius.circular(20),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Text("Yuuk lengkapi absensi hari ini...", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300)),
                      Padding(
                          padding: const EdgeInsets.only(left: 18, right: 18, top: 30),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(20.0),
                                  decoration: BoxDecoration(
                                    color: Color(0xfffcfcfd),
                                    borderRadius: BorderRadius.circular(15.0),
                                    border: Border.all(
                                      color: Colors.grey[200],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(1, 4),
                                        blurRadius: 6,
                                        color: Colors.grey[200],
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "$_tanggal",
                                        style: TextStyle(
                                            color: Colors.grey[500],
                                            fontWeight: FontWeight.w900,
                                            fontSize: 40),
                                      ),
                                      Text(
                                        "$_bulan",
                                        style:
                                        TextStyle(color: Colors.grey[500], fontSize: 28, fontWeight: FontWeight.w300),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          style: TextStyle(color: Colors.grey),
                                          children: [
                                            TextSpan(
                                              text: "$_tahun",
                                              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 9.0,
                                      ),
                                      Divider(),

                                      SizedBox(
                                        height: 9.0,
                                      ),
                                      Container(
                                          child: Center(
                                            child: Text("$_timeString",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey[500])),
                                          )
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Bagaimana Status Anda Hari Ini ??", style: TextStyle(fontSize: 14, color: Colors.grey[500])),
                              SizedBox(height: 5),
                              genderSelectionTile,
                            ],
                          ),
                          SizedBox(width: 30),
                          Hero(
                            tag: 1,
                            child: InkWell(
                              splashColor: Colors.white,
                              onTap: (){
                                getImage2();
                              },
                              child: Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [LightColor.unsBlue, LightColor.lightBlue]),
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 3.0,
                                        offset: Offset(0, 3)),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(16)),
                                  child: _image == null
                                      ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                         Icon(Icons.camera_alt, color: Colors.white, size: 30),
                                          Text("Selfie", style: TextStyle(color: Colors.white)),
                                        ],
                                      )
                                      : Stack(
                                        children: [
                                          Container(
                                            height: 80,
                                            width: 80,
                                            child: Image.file(
                                              _image,
                                              height: 80,
                                              width: 80,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 5,
                                              right: 5,
                                              child: Center(
                                                  child: Icon(Icons.camera_alt, color: Colors.white38))
                                          )
                                        ],
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      seletedStatus == 'Izin'
                          ? FormWidget(
                        maxline: 3,
                        hint: "Keterangan",
                        obscure: false,
                        textEditingController: controllerIzin,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        icon: IconButton(icon: Icon(Icons.text_fields)),
                      ) : Container(),
                      SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () {
                          if (_image == null && seletedStatus == "Sakit") {
                            showDialogError(context, "Anda belum melakukan foto Surat Keterangan Sakit", "Harap menyertakan Surat Keterangan Sakit sebelum melakukan Checkin");
                          } else if(position.latitude == null || position.longitude == null ){
                            showDialogError(context, "Lokasi Tidak Valid", "Lokasi anda tidak dapat divalidasi");
                          } else if(seletedStatus == "Hadir" && _image != null){
                            checkin();
                          } else if(seletedStatus == "Izin" &&controllerIzin.text.isEmpty){
                            showDialogError(context, "Keterangan belum diisi", "Harap isi keterangan sebelum melakukan Checkin");
                          } else {
                            showDialogError(context, "Anda belum melakukan foto selfie", "Silahkan melakukan foto selfie terlebih dahulu sebelum Checkin");

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
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                )),
          ),

        ],
      ),
      // floatingActionButton:
      // Padding(
      //   padding: const EdgeInsets.only(left: 12.0, right: 12),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.end,
      //     children: <Widget>[
      //       Hero(
      //         tag: 1,
      //         child: GestureDetector(
      //           onTap: () {},
      //           child: Container(
      //             width: 100,
      //             height: 60,
      //             padding: EdgeInsets.all(15.0),
      //             decoration: BoxDecoration(
      //               gradient: LinearGradient(
      //                   colors: [LightColor.unsBlue, LightColor.lightBlue]),
      //               borderRadius: BorderRadius.circular(9.0),
      //               boxShadow: [
      //                 BoxShadow(
      //                     color: Colors.grey,
      //                     blurRadius: 3.0,
      //                     offset: Offset(0, 3)),
      //               ],
      //             ),
      //             child: Center(
      //               child: Text(
      //                 "Checkin",
      //                 style: Theme.of(context)
      //                     .textTheme
      //                     .button
      //                     .apply(color: Colors.white),
      //                 textAlign: TextAlign.center,
      //               ),
      //             ),
      //           ),
      //         )
      //       ),
      //     ],
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }


  Widget _buildContentUI() {
    return Row(
      children: <Widget>[
        Hero(
          tag: 1,
          child: Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(16))),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              child: Image.network(
                "https://www.thefamouspeople.com/profiles/images/edward-snowden-5.jpg",
                height: 100,
                width: 100,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 130,
        ),
        Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: CircleAvatar(
            radius: 35,
            child: Icon(Icons.camera_alt),
            foregroundColor: Colors.white,
            backgroundColor: Colors.lightBlue,
          ),
        ),
      ],
    );
  }

  Widget _buildDocumentAttachmentWidget() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12),
      height: 70,
      color: Color(0xffE7F8FA),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 3,
            color: Colors.lightBlue,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Transform.rotate(
              angle: 3.14 / 180 * 45,
              child: Icon(
                Icons.attach_file,
                color: Colors.lightBlueAccent,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Complete blood count",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.blueAccent,
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                "05 Mar 2020",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
