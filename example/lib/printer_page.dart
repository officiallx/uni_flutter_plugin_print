import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uni_flutter_plugin/printer/printer_constants.dart';
import 'package:uni_flutter_plugin/printer/uni_printer_plugin.dart';

class PrinterPage extends StatefulWidget {
  const PrinterPage({Key? key}) : super(key: key);

  @override
  State<PrinterPage> createState() => _PrinterPageState();
}

class _PrinterPageState extends State<PrinterPage> {
  final uniPrinterPlugin = UniPrinterPlugin();

  final textController = TextEditingController();
  final lineController = TextEditingController();
  final qrCodeController = TextEditingController();
  final eanController = TextEditingController();
  final eanHeightController = TextEditingController();

  String textAlignmentValue = "";
  List<String> textAlignmentList = ["Left", "Center", "Right"];
  List<String> imageAlignmentList = ["Left", "Center", "Right"];
  String imageAlignmentValue = "";

  List<String> imageWidthList = ["Inch_1", "Inch_2"];
  String imageWidthValue = "";

  bool enableLog = false;

  @override
  initState() {
    super.initState();
    textAlignmentValue = textAlignmentList[0];
    imageAlignmentValue = imageAlignmentList[0];
    imageWidthValue = imageWidthList[0];
  }

  Future<void> initPrinter() async {
    int ret = await uniPrinterPlugin.initPrinter();
    setStatus("Printer : Init Status : $ret");
  }

  Future<void> printText() async {
    String data = textController.text;
    if (data.isNotEmpty) {
      int ret = await uniPrinterPlugin.printText("$data\n");
      setStatus("Printer : Print Text Status : $ret");
    }
  }

  Future<void> closePrinter() async {
    int ret = await uniPrinterPlugin.closePrinter();
    setStatus("Printer : Close Status : $ret");
  }

  Future<void> checkPaper() async {
    bool status = await uniPrinterPlugin.checkPaper();
    setStatus(
        "Printer :  Check Paper : ${status ? "Paper present" : "Paper not present"}");
  }

  Future<void> printLine() async {
    String data = lineController.text;
    if (data.isNotEmpty) {
      int line = int.parse(data);
      int ret = await uniPrinterPlugin.printLine(line);
      setStatus("Printer : Print Line : $ret");
    }
  }

  Future<void> iGetPrinterStatus() async {
    int ret = await uniPrinterPlugin.iGetPrinterStatus();
    setStatus("Printer : Printer Status : $ret");
  }

  Future<void> printImg() async {
    final ByteData bytes = await rootBundle.load('assets/print_logo.png');
    final List<int> list = bytes.buffer.asInt8List();
    int ret = await uniPrinterPlugin.printImage(list);
    setStatus("Printer : Image Status : $ret");
  }

  Future<void> printQRCode() async {
    String data = qrCodeController.text;
    if (data.isNotEmpty) {
      int ret = await uniPrinterPlugin.printQRCode(data,
          width: getImageWidth(imageWidthValue),
          imageAlignment: getImageAlignment(imageAlignmentValue));
      setStatus("Printer : Print QRCode : $ret");
    }
  }

  Future<void> getVersion() async {
    String ver = await uniPrinterPlugin.getVersion();
    setStatus("Printer : Get Version : $ver");
  }

  Future<void> enableLogSDK() async {
    int ret = await uniPrinterPlugin.setLogEnable(enableLog);
    setStatus("Printer : Enable Log : $ret");
  }

  Future<void> printReceipt() async {
    await uniPrinterPlugin.iFlushBuffer();
    await uniPrinterPlugin.iUpdateBufferTextAlignment(TextAlignment.Center);
    await uniPrinterPlugin.iUpdateBufferString("PAYMENT RECEIPT\n");
    await uniPrinterPlugin.iUpdateBufferTextAlignment(TextAlignment.Left);
    await uniPrinterPlugin
        .iUpdateBufferString("******************************\n");
    await uniPrinterPlugin
        .iUpdateBufferString("Taxable GST SR             49.95\n");
    await uniPrinterPlugin
        .iUpdateBufferString("GST                         5.55\n");
    await uniPrinterPlugin
        .iUpdateBufferString("Sub:                       55.50\n");
    await uniPrinterPlugin
        .iUpdateBufferString("Cash                      100.00\n");
    await uniPrinterPlugin
        .iUpdateBufferString("Change                     44.50\n");
    await uniPrinterPlugin
        .iUpdateBufferString("******************************\n");
    await uniPrinterPlugin.iUpdateBufferString("\n");
    await uniPrinterPlugin.iUpdateBufferString("Evolute\n");
    await uniPrinterPlugin.iUpdateBufferTextAlignment(TextAlignment.Center);
    await uniPrinterPlugin.iUpdateBufferString("Evolute\n");
    await uniPrinterPlugin.iUpdateBufferTextAlignment(TextAlignment.Right);
    await uniPrinterPlugin.iUpdateBufferString("Evolute\n");
    await uniPrinterPlugin.iUpdateBufferString("\n");
    await uniPrinterPlugin.iUpdateBufferString("\n");
    await uniPrinterPlugin.iUpdateBufferString("\n");
    await uniPrinterPlugin.iUpdateBufferString("\n");
    int ret = await uniPrinterPlugin.iStartPrinting();
    setStatus("Printer : Print Receipt : $ret");
  }

  Future<void> printRawData() async {
    await uniPrinterPlugin.iFlushBuffer();
    await uniPrinterPlugin.iUpdateBufferListInteger([0x1B, 0x40]);
    await uniPrinterPlugin.iUpdateBufferListInteger([27, 97, 0X00]);
    await uniPrinterPlugin.iUpdateBufferListInteger(
        [0x45, 0x56, 0x4F, 0x4C, 0x55, 0x54, 0x45, 0x0A]);
    await uniPrinterPlugin.iUpdateBufferListInteger([27, 97, 0x01]);
    await uniPrinterPlugin.iUpdateBufferListInteger(
        [0x45, 0x56, 0x4F, 0x4C, 0x55, 0x54, 0x45, 0x0A]);
    await uniPrinterPlugin.iUpdateBufferListInteger([27, 97, 0x02]);
    await uniPrinterPlugin.iUpdateBufferListInteger(
        [0x45, 0x56, 0x4F, 0x4C, 0x55, 0x54, 0x45, 0x0A]);
    await uniPrinterPlugin.iUpdateBufferListInteger([0x1B, 0x40]);
    int ret = await uniPrinterPlugin.iStartPrinting();
    setStatus("Printer : Print Raw Data : $ret");
  }

  Future<void> setPrinterProperties() async {
    TextAlignment textAlignment = getTextAlignment(textAlignmentValue);
    int ret = await uniPrinterPlugin.iSetPrinterProperties(
        FontSize.Width_x_Height_1x1, textAlignment);
    setStatus("Printer : Set Print Properties : $ret");
  }

  void setStatus(String status) {
    this.status = status;
    setState(() {});
  }

  String status = "Printer Status";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Printer example '),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                heading("Printer Status"),
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
                heading("Printer Options"),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () => initPrinter(),
                          child: const Text(
                            "Init Printer",
                          )),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () => closePrinter(),
                          child: const Text("Close Printer")),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextField(
                        decoration: const InputDecoration(
                          label: Text("Data"),
                        ),
                        controller: textController,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () => printText(),
                        child: const Text("Print Text"),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                setProperties(),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          label: Text("Line"),
                        ),
                        controller: lineController,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () => printLine(),
                        child: const Text("Print Line"),
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
                        onPressed: () => checkPaper(),
                        child: const Text("Check paper"),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => iGetPrinterStatus(),
                        child: const Text("Printer Status"),
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
                        onPressed: () => printImg(),
                        child: const Text("Print Img"),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => getVersion(),
                        child: const Text("Printer Version"),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                qrCode(),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => printReceipt(),
                        child: const Text("Print Receipt"),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => printRawData(),
                        child: const Text("Print RawData"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SwitchListTile(
                    title: const Text("Enable Log"),
                    value: enableLog,
                    onChanged: (value) {
                      setState(() {
                        enableLog = value;
                      });
                      enableLogSDK();
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget setProperties() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: DropdownButton(
            value: textAlignmentValue,
            icon: const Icon(Icons.keyboard_arrow_down),
            items: textAlignmentList.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                textAlignmentValue = newValue!;
              });
            },
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: ElevatedButton(
            onPressed: () => setPrinterProperties(),
            child: const Text("Set Properties"),
          ),
        ),
      ],
    );
  }

  Widget qrCode() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: TextField(
                decoration: const InputDecoration(
                  label: Text("QR Code"),
                ),
                controller: qrCodeController,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              flex: 1,
              child: DropdownButton(
                value: imageWidthValue,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: imageWidthList.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    imageWidthValue = newValue!;
                  });
                },
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              flex: 1,
              child: DropdownButton(
                value: imageAlignmentValue,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: imageAlignmentList.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    imageAlignmentValue = newValue!;
                  });
                },
              ),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => printQRCode(),
            child: const Text("Print QR Code"),
          ),
        )
      ],
    );
  }

  Widget heading(String heading) {
    return Text(
      heading,
      style: const TextStyle(fontWeight: FontWeight.w600),
    );
  }

  void showSnackBar(String m) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(m)));
  }

  TextAlignment getTextAlignment(String data) {
    switch (data) {
      case "Left":
        return TextAlignment.Left;
      case "Center":
        return TextAlignment.Center;
      case "Right":
        return TextAlignment.Right;
      default:
        return TextAlignment.Left;
    }
  }

  ImageAlignment getImageAlignment(String data) {
    switch (data) {
      case "Left":
        return ImageAlignment.Left;
      case "Center":
        return ImageAlignment.Center;
      case "Right":
        return ImageAlignment.Right;
      default:
        return ImageAlignment.Left;
    }
  }

  ImageWidth getImageWidth(String data) {
    switch (data) {
      case "Inch_1":
        return ImageWidth.Inch_1;
      case "Inch_2":
        return ImageWidth.Inch_2;
      default:
        return ImageWidth.Inch_1;
    }
  }

  @override
  void dispose() {
    super.dispose();
    textController.dispose();
    lineController.dispose();
    qrCodeController.dispose();
    eanHeightController.dispose();
    eanController.dispose();
  }
}
