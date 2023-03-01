import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:uni_flutter_plugin/fps/fps_constants.dart';
import 'package:uni_flutter_plugin/fps/fps_device_info.dart';
import 'package:uni_flutter_plugin/fps/sensor_response.dart';
import 'package:uni_flutter_plugin/fps/sensor_verify_image_response.dart';
import 'package:uni_flutter_plugin/fps/sensor_verify_response.dart';
import 'package:uni_flutter_plugin/fps/template_data.dart';
import 'package:uni_flutter_plugin/fps/uni_fps_plugin.dart';
import 'package:uni_flutter_plugin/utility/helper_functions.dart';

import 'heading.dart';

class FPSPage extends StatefulWidget {
  const FPSPage({Key? key}) : super(key: key);

  @override
  State<FPSPage> createState() => _FPSPageState();
}

class _FPSPageState extends State<FPSPage> {
  String status = "FPS Status";

  final UniFPSPlugin uniFPSPlugin = UniFPSPlugin();
  Uint8List? currentBMPData;
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController timeOutController = TextEditingController();
  List<TemplateData> templateDataList = [];
  final StreamController<String> streamController = StreamController();
  String templateTypeValue = "";
  List<String> templateTypeList = [
    "Template_Type_PK_COMP",
    "Template_Type_PK_MAT_NORM",
    "Template_Type_PK_COMP_NORM",
    "Template_Type_PK_ANSI_378",
    "Template_Type_PK_MINEX_A",
    "Template_Type_PK_ISO_FMR",
    "Template_Type_PK_ISO_FMC_NS",
    "Template_Type_PK_ISO_FMC_CS",
    "Template_Type_PK_DIN_V66400_CS",
    "Template_Type_PK_DIN_V66400_CS_AA",
    "Template_Type_PK_ISO_FMC_CS_AA",
    "Template_Type_PK_ANSI_378_2009",
    "Template_Type_PK_ISO_FMR_2011"
  ];

  String securityLevelListValue = "";
  List<String> securityLevelList = [
    "Critical",
    "High",
    "Medium",
    "Low",
    "Default",
    "None"
  ];

  String imageCompressionAlgoValue = "";
  List<String> imageCompressionAlgoList = [
    "Uncompressed_No_Bit_Packing",
    "Uncompressed_Bit_Packed",
    "Compressed_WSQ",
    "Compressed_JPEG",
    "PNG",
    "Compress_V1",
    "Compressed_JPEG2000"
  ];
  bool isNotProcessing = true;

  Future<void> initFPS() async {
    if (isNotProcessing) {
      isNotProcessing = false;
      int ret = await uniFPSPlugin.initFPS();
      setStatus("FPS : Init FPS : $ret");
      isNotProcessing = true;
    }
  }

  Future<void> closeFPS() async {
    if (isNotProcessing) {
      isNotProcessing = false;
      int ret = await uniFPSPlugin.closeFPS();
      setStatus("FPS : Close FPS : $ret");
      isNotProcessing = true;
    }
  }

  Future<void> captureFPS() async {
    if (isNotProcessing) {
      isNotProcessing = false;
      templateDataList.clear();
      String data = sizeController.text;
      if (data.isNotEmpty) {
        int size = int.parse(data);
        if (size > 20) {
          return;
        }
        int template = await uniFPSPlugin.getTemplate();
        TemplateType? templateType =
            HelperFunctions.getValueOfTemplateType(template);
        if (templateType != null) {
          for (int i = 0; i < size; i++) {
            SensorResponse sensorResponse = await uniFPSPlugin.captureFPS();
            currentBMPData = sensorResponse.BMPImageData != null
                ? Uint8List.fromList(sensorResponse.BMPImageData!)
                : null;
            if (sensorResponse.responseCode == FPSConstants.SDK_OK) {
              templateDataList.add(TemplateData(
                  templateData: sensorResponse.templateData!,
                  templateType: templateType));
            }
            setStatus(
                "FPS : Capture FPS (index:$i) : ${sensorResponse.responseCode}");
          }
        }
      }
      isNotProcessing = true;
    }
  }

  Future<void> verifyFPS() async {
    if (isNotProcessing) {
      isNotProcessing = false;
      if (templateDataList.isNotEmpty) {
        SensorVerifyImageResponse sensorVerifyImageResponse = await uniFPSPlugin
            .verifyFPS(templateDataList[0].templateData, true);
        setStatus("FPS : Verify FPS : ${sensorVerifyImageResponse.toString()}");
      }
      isNotProcessing = true;
    }
  }

  Future<void> verifyFPSMatch() async {
    if (isNotProcessing) {
      isNotProcessing = false;
      if (templateDataList.length >= 2) {
        SensorVerifyResponse sensorVerifyResponse =
            await uniFPSPlugin.verifyFPSMatch(templateDataList[0].templateData,
                templateDataList[1].templateData);
        setStatus(
            "FPS : Verify FPS Match : ${sensorVerifyResponse.toString()}");
      }
      isNotProcessing = true;
    }
  }

  Future<void> verifyFPSWithTemplate() async {
    if (isNotProcessing) {
      isNotProcessing = false;
      if (templateDataList.isNotEmpty) {
        SensorVerifyImageResponse sensorVerifyImageResponse =
            await uniFPSPlugin.verifyFPSWithTemplate(templateDataList, true);
        setStatus(
            "FPS : Verify FPS Template : ${sensorVerifyImageResponse.toString()}");
      }
      isNotProcessing = true;
    }
  }

  Future<void> getFPSDeviceInfo() async {
    if (isNotProcessing) {
      isNotProcessing = false;
      FPSDeviceInfo fpsDeviceInfo = await uniFPSPlugin.getFPSDeviceInfo();
      setStatus("FPS : Get FPS Device Info : ${fpsDeviceInfo.toString()}");
      isNotProcessing = true;
    }
  }

  Future<void> setTemplate() async {
    if (isNotProcessing) {
      isNotProcessing = false;
      TemplateType templateType = getTemplateTypeValue();
      final ret = await uniFPSPlugin.setTemplate(templateType);
      setStatus("FPS : Set Template : $ret");
      isNotProcessing = true;
    }
  }

  Future<void> getTemplate() async {
    if (isNotProcessing) {
      isNotProcessing = false;
      final ret = await uniFPSPlugin.getTemplate();
      setStatus("FPS : Get Template : $ret");
      isNotProcessing = true;
    }
  }

  Future<void> setTimeout() async {
    if (isNotProcessing) {
      isNotProcessing = false;
      String data = timeOutController.text;
      if (data.isNotEmpty) {
        int timeout = int.parse(data);
        final ret = await uniFPSPlugin.setTimeout(timeout);
        setStatus("FPS : Set Timeout : $ret");
      }
      isNotProcessing = true;
    }
  }

  Future<void> getTimeout() async {
    if (isNotProcessing) {
      isNotProcessing = false;
      final ret = await uniFPSPlugin.getTimeout();
      setStatus("FPS : Get Timeout : $ret");
      isNotProcessing = true;
    }
  }

  Future<void> setImageCompressionAlgo() async {
    if (isNotProcessing) {
      isNotProcessing = false;
      ImageCompressionType imageCompressionType =
          getImageCompressionTypeValue();
      final ret =
          await uniFPSPlugin.setImgCompressionAlgo(imageCompressionType);
      setStatus("FPS : Set Image Compression Algo : $ret");
      isNotProcessing = true;
    }
  }

  Future<void> getImageCompressionAlgo() async {
    if (isNotProcessing) {
      isNotProcessing = false;
      final ret = await uniFPSPlugin.getImageCompressionAlgo();
      setStatus("FPS : Get Image Compression Algo : $ret");
      isNotProcessing = true;
    }
  }

  Future<void> getImageQuality() async {
    if (isNotProcessing) {
      isNotProcessing = false;
      final ret = await uniFPSPlugin.getImageQuality();
      setStatus("FPS : Get Image Quality : $ret");
      isNotProcessing = true;
    }
  }

  Future<void> setFFDSecurityLevel() async {
    if (isNotProcessing) {
      isNotProcessing = false;
      SecurityLevel securityLevel = getSecurityLevel();
      final ret = await uniFPSPlugin.setFFDSecurityLevel(securityLevel);
      setStatus("FPS : Set FFD Security Level : $ret");
      isNotProcessing = true;
    }
  }

  Future<void> enableFingerPositionUpdates() async {
    if (isNotProcessing) {
      isNotProcessing = false;
      final ret = await uniFPSPlugin.enableFingerPositionUpdates();
      setStatus("FPS : Enable Finger Position Updates : $ret");
      isNotProcessing = true;
    }
  }

  Future<void> disableFingerPositionUpdates() async {
    if (isNotProcessing) {
      isNotProcessing = false;
      final ret = await uniFPSPlugin.disableFingerPositionUpdates();
      setStatus("FPS : Disable Finger Position Updates : $ret");
      isNotProcessing = true;
    }
  }

  void setStatus(String status) {
    this.status = status;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    securityLevelListValue = securityLevelList[5];
    imageCompressionAlgoValue = imageCompressionAlgoList[0];
    templateTypeValue = templateTypeList[5];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('FPS example'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Heading(heading: "FPS Status"),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  status,
                  style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Heading(heading: "Finger Position Updates"),
              const SizedBox(
                height: 20,
              ),
              StreamBuilder<FingerPosition>(
                stream: uniFPSPlugin.fingerPositionUpdates,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return streamView("None");
                    case ConnectionState.waiting:
                      return streamView("Waiting");
                    case ConnectionState.active:
                      return streamView(snapshot.data.toString());
                    case ConnectionState.done:
                      return streamView("Done");
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Heading(heading: "FPS Options"),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => initFPS(),
                      child: const Text(
                        "Init FPS",
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => closeFPS(),
                      child: const Text("Close FPS"),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: sizeController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        label: Text("Size"),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => captureFPS(),
                      child: const Text("FPS Capture"),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => verifyFPS(),
                      child: const Text("Capture & Verify"),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => verifyFPSMatch(),
                      child: const Text("Verify FPS match"),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => verifyFPSWithTemplate(),
                  child: const Text("Verify FPS Template"),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => getImageQuality(),
                  child: const Text("Get Image Quality"),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => getFPSDeviceInfo(),
                  child: const Text("Get FPS Details Info"),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              timeout(),
              const SizedBox(
                height: 10,
              ),
              imageCompression(),
              const SizedBox(
                height: 10,
              ),
              templateTypeWidget(),
              const SizedBox(
                height: 10,
              ),
              securityLevel(),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => enableFingerPositionUpdates(),
                      child: const Text("Enable Finger Position Updates"),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => disableFingerPositionUpdates(),
                      child: const Text("Disable Finger Position Updates"),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Heading(heading: "FPS Image"),
              const SizedBox(
                height: 10,
              ),
              currentBMPData != null
                  ? Center(
                      child: Image.memory(
                        currentBMPData!,
                        height: 300,
                        width: 300,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget streamView(String data) {
    return Center(
      child: Text(
        data,
        style: const TextStyle(
            color: Colors.red, fontWeight: FontWeight.w600, fontSize: 16),
      ),
    );
  }

  Widget timeout() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: TextField(
            controller: timeOutController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              label: Text("Timeout"),
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          flex: 2,
          child: ElevatedButton(
            onPressed: () => setTimeout(),
            child: const Text("Set Timeout"),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          flex: 2,
          child: ElevatedButton(
            onPressed: () => getTimeout(),
            child: const Text("Get Timeout"),
          ),
        ),
      ],
    );
  }

  Widget imageCompression() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: DropdownButton(
                value: imageCompressionAlgoValue,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: imageCompressionAlgoList.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    imageCompressionAlgoValue = newValue!;
                  });
                },
              ),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => setImageCompressionAlgo(),
                child: const Text("Set Img Comp Algo"),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () => getImageCompressionAlgo(),
                child: const Text("Get Img Comp Algo"),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget securityLevel() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: DropdownButton(
                value: securityLevelListValue,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: securityLevelList.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    securityLevelListValue = newValue!;
                  });
                },
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: () => setFFDSecurityLevel(),
                child: const Text("Set FFD Security"),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget templateTypeWidget() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: DropdownButton(
                value: templateTypeValue,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: templateTypeList.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    templateTypeValue = newValue!;
                  });
                },
              ),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => setTemplate(),
                child: const Text("Set Template"),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () => getTemplate(),
                child: const Text("Get Template"),
              ),
            ),
          ],
        )
      ],
    );
  }

  TemplateType getTemplateTypeValue() {
    switch (templateTypeValue) {
      case "Template_Type_PK_COMP":
        return TemplateType.Template_Type_PK_COMP;
      case "Template_Type_PK_MAT_NORM":
        return TemplateType.Template_Type_PK_MAT_NORM;
      case "Template_Type_PK_COMP_NORM":
        return TemplateType.Template_Type_PK_COMP_NORM;
      case "Template_Type_PK_ANSI_378":
        return TemplateType.Template_Type_PK_ANSI_378;
      case "Template_Type_PK_MINEX_A":
        return TemplateType.Template_Type_PK_MINEX_A;
      case "Template_Type_PK_ISO_FMC_NS":
        return TemplateType.Template_Type_PK_ISO_FMC_NS;
      case "Template_Type_PK_ISO_FMC_CS":
        return TemplateType.Template_Type_PK_ISO_FMC_CS;
      case "Template_Type_PK_DIN_V66400_CS":
        return TemplateType.Template_Type_PK_DIN_V66400_CS;
      case "Template_Type_PK_DIN_V66400_CS_AA":
        return TemplateType.Template_Type_PK_DIN_V66400_CS_AA;
      case "Template_Type_PK_ISO_FMC_CS_AA":
        return TemplateType.Template_Type_PK_ISO_FMC_CS_AA;
      case "Template_Type_PK_ANSI_378_2009":
        return TemplateType.Template_Type_PK_ANSI_378_2009;
      case "Template_Type_PK_ISO_FMR_2011":
        return TemplateType.Template_Type_PK_ISO_FMR_2011;
      case "Template_Type_PK_ISO_FMR":
      default:
        return TemplateType.Template_Type_PK_ISO_FMR;
    }
  }

  SecurityLevel getSecurityLevel() {
    switch (securityLevelListValue) {
      case "Critical":
        return SecurityLevel.Critical;
      case "High":
        return SecurityLevel.High;
      case "Medium":
        return SecurityLevel.Medium;
      case "Low":
        return SecurityLevel.Low;
      case "Default":
        return SecurityLevel.Default;
      case "None":
      default:
        return SecurityLevel.None;
    }
  }

  ImageCompressionType getImageCompressionTypeValue() {
    switch (imageCompressionAlgoValue) {
      case "Uncompressed_Bit_Packed":
        return ImageCompressionType.Uncompressed_Bit_Packed;
      case "Compressed_WSQ":
        return ImageCompressionType.Compressed_WSQ;
      case "Compressed_JPEG":
        return ImageCompressionType.Compressed_JPEG;
      case "PNG":
        return ImageCompressionType.PNG;
      case "Compress_V1":
        return ImageCompressionType.Compress_V1;
      case "Compressed_JPEG2000":
        return ImageCompressionType.Compressed_JPEG2000;
      case "Uncompressed_No_Bit_Packing":
      default:
        return ImageCompressionType.Uncompressed_No_Bit_Packing;
    }
  }

  @override
  void dispose() {
    super.dispose();
    sizeController.dispose();
    timeOutController.dispose();
  }
}
