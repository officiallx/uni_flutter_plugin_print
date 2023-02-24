## 1.0.0-0
Describe initial release.

## 1.0.0-2
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