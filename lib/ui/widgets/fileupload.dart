import 'package:deepaprakasar/database/crud/user/uploadfile.dart';
import 'package:deepaprakasar/database/dao/status.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:deepaprakasar/ui/widgets/showalertdialog.dart';
import 'package:deepaprakasar/ui/widgets/styles.dart';
import 'package:deepaprakasar/utils/sharedpreferences.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class FileUploadWithHttp extends StatefulWidget {
  @override
  _FileUploadWithHttpState createState() => _FileUploadWithHttpState();
}

class _FileUploadWithHttpState extends State<FileUploadWithHttp> {
  late PlatformFile objFile;
  Future<Status>? _futureStatus;
  late String fileName;

  void chooseFileUsingFilePicker() async {
    var result = await FilePicker.platform.pickFiles(withReadStream: true,);
    if (result != null) {
      setState(() {
        objFile = result.files.single;
        _futureStatus = uploadFile(objFile, SharedPrefs().username,
            Strings.TITLE_MM_TB_VAT);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget roundedRectButton(String title, List<Color> gradient) {
      return Builder(builder: (BuildContext mContext) {
        return InkWell(
          onTap: () {
            switch (title) {
              case Strings.BTN_TITLE_CHOOSE_FILE:
                chooseFileUsingFilePicker();
                break;
            }
          },
          splashColor: Colors.lightBlue,
          child: Container(
            alignment: Alignment.center,
            height: MediaQuery.of(mContext).size.height * 0.05,
            width: MediaQuery.of(mContext).size.width / 3,
            decoration: shapeDecoration(gradient),
            child: Text(title, style: normalTextStyle),
          ),
        );
      });
    }

    return Scaffold(
        appBar: AppBar(
        title: Text(
        Strings.TITLE_VAT_REGISTRATION,
        style: new TextStyle(color: Colors.white),
    ),
    leading: new IconButton(
    icon: new Icon(Icons.arrow_back),
    onPressed: () {
        Navigator.pop(context);
    },
    ),
    ),
    body: SingleChildScrollView(
    child: Container(
      height: MediaQuery.of(context).size.height,
    color: Colors.black12,
    child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
    SizedBox(
    height: 10,
    ),
    Center(
    child: Stack(
    alignment: Alignment.center,
    children: <Widget>[
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        // ignore: unnecessary_null_comparison
        child: (_futureStatus != null)
            ? FutureBuilder<Status>(
          future: _futureStatus,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.status.contains(
                  Strings.NO_FILE_SELECTED)) {
                SchedulerBinding.instance!
                    .addPostFrameCallback((_) {
                  CircularProgressIndicator(
                      value: 1.0);
                  return showAlertDialogSingle(
                      context,
                      Strings.ALERT_HDR_NO_FILE_SELECTED,
                      snapshot.data!.status);
                });
              } else if (snapshot.data!.status
                  .contains(Strings.FILE_NOT_UPLOADED)) {
                SchedulerBinding.instance!
                    .addPostFrameCallback((_) {
                  CircularProgressIndicator(
                      value: 1.0);
                  return showAlertDialogSingle(
                      context,
                      Strings.ALERT_HDR_FILE_NOT_UPLOADED,
                      snapshot.data!.status);
                });
              } else if (snapshot.data!.status
                  .startsWith(Strings.FILE_EXISTS)) {
                SchedulerBinding.instance!
                    .addPostFrameCallback((_) {
                  CircularProgressIndicator(
                      value: 1.0);
                  return showAlertDialogSingle(
                      context,
                      Strings.ALERT_HDR_FILE_EXISTS,
                      snapshot.data!.status);
                });
              } else if (snapshot.data!.status.startsWith(
                  Strings.FILE_UPLOADED)) {
                SchedulerBinding.instance!
                    .addPostFrameCallback((_) {
                  CircularProgressIndicator(
                      value: 1.0);
                  fileName = snapshot.data!.status.substring
                    (snapshot.data!.status.indexOf(Strings.SPACE) + 1);
                  Navigator.pop(context, fileName);
                });
              } else if (snapshot.data!.status.startsWith(
                  Strings.FILE_SIZE_ERROR)) {
                SchedulerBinding.instance!
                    .addPostFrameCallback((_) {
                  CircularProgressIndicator(
                      value: 1.0);
                  return showAlertDialogSingle(
                      context,
                      Strings.ALERT_HDR_FILE_SIZE_ERROR,
                      snapshot.data!.status);
                });
              } else if (snapshot.data!.status.startsWith(
                  Strings.FILE_FORMAT_ERROR)) {
                SchedulerBinding.instance!
                    .addPostFrameCallback((_) {
                  CircularProgressIndicator(
                      value: 1.0);
                  return showAlertDialogSingle(
                      context,
                      Strings.ALERT_HDR_FILE_FORMAT_ERROR,
                      snapshot.data!.status);
                });
              }
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator(
                value: 0.0);
          },
        )
            : Text(
            Strings.DET_MMM_REG_INPUT_REQ_FIELDS),
      ),
    Column(
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          roundedRectButton(
            Strings.BTN_TITLE_CHOOSE_FILE,
            [
              Colors.pink,
              Colors.amber,
            ],
          ),
        ],
      ),
    ]
    )],
    ),
    ),
    ],
    ),
    ),
    ),
    );
  }
}