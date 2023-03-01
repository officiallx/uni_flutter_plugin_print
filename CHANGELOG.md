## 1.0.0-0
Describe initial release.

## 1.0.0-1
Minor Bugs Fixed

## 1.0.0-2
The following APIs are added related to Printer.
1.	initPrinter() 
2.	closePrinter()
3.	printLine(int line)
4.	printImage(List<int> data)
5.	checkPaper()
6.	iGetPrinterStatus()
7.	iSetPrinterProperties(FontSize fontSize,TextAlignment textAlignment)
8.	iFlushBuffer()
9.	iUpdateBufferString(String data)
10.	iUpdateBufferFontSize(FontSize fontSize)
11.	iUpdateBufferListInteger(List<int> data)
12.	iUpdateBufferTextAlignment(TextAlignment textAlignment)
13.	iStartPrinting()
14.	getVersion()
15.	printQRCode(String data,{ImageWidth? imageWidth,ImageAlignment? imageAlignment})
16.	sendRawData(List<int> data)

## 1.0.0-3
Downgraded Dart Version from 3 to 2.19

## 1.0.0-4
The following APIs are added related to Fingerprint.
1.	initFPS()
2.	closeFPS()
3.	captureFPS()
4.	setTemplate(TemplateType  templateType)
5.	getTemplate()
6.	setImgCompressionAlgo(ImageCompressionType imageCompressionType)
7.	getImageCompressionAlgo()
8.	setTimeout(int timeout)
9.	getTimeout()
10.	getImageQuality()
11.	setFFDSecurityLevel(SecurityLevel securityLevel)
12.	verifyFPSMatch(List<int> fingerData1,List<int> fingerData2)
13.	verifyFPS(List<int> fingerData1,bool fingerDataEnabled)
14.	getFPSDeviceInfo()
15. verifyFPSWithTemplate(List<TemplateData> templateData,bool fingerDataEnabled)
