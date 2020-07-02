'*******************************************************************************************'
'                                                                                           '
' Download Free Evaluation Version From:     https://bytescout.com/download/web-installer   '
'                                                                                           '
' Also available as Web API! Get free API Key https://app.pdf.co/signup                     '
'                                                                                           '
' Copyright © 2017-2020 ByteScout, Inc. All rights reserved.                                '
' https://www.bytescout.com                                                                 '
' https://www.pdf.co                                                                        '
'*******************************************************************************************'


' This example demonstrates how to use tiling patterns.

' Create Bytescout.PDF.Document object
Set pdfDocument = CreateObject("Bytescout.PDF.Document")
pdfDocument.RegistrationName = "demo"
pdfDocument.RegistrationKey = "demo"

' If you wish to load an existing document uncomment the line below And comment the Add page section instead
' pdfDocument.Load("existing_document.pdf")

Set comHelpers = pdfDocument.ComHelpers

' Add page
Set page1 = comHelpers.CreatePage(comHelpers.PAPERFORMAT_A4)
pdfDocument.Pages.Add(page1)

Set blueColor = comHelpers.CreateColorRGB(0, 0, 255)
Set grayColor = comHelpers.CreateColorGray(128)
Set blackColor = comHelpers.CreateColorGray(0)

' Create tiling brush and paint on it 
Set tilingBrush1 = comHelpers.CreateUncoloredTilingBrush(10, 12)
Set brushCanvas = tilingBrush1.Canvas
brushCanvas.DrawCircle comHelpers.CreateSolidPen((blueColor), 1), 0, 6, 6
tilingBrush1.Color = blueColor

' Create second tiling brush and paint on it using the first brush
Set tilingBrush2 = comHelpers.CreateColoredTilingBrush(70, 50)
Set brushCanvas = tilingBrush2.Canvas
brushCanvas.DrawEllipse_3 comHelpers.CreateSolidPen((grayColor), 1), (tilingBrush1), 0, 0, 60, 20

' Draw rectangle and fill it with combined tiling brush
page1.Canvas.DrawRectangle_3 comHelpers.CreateSolidPen((blackColor), 1), (tilingBrush2), 100, 100, 400, 400

' Save document to file
pdfDocument.Save("result.pdf")

' Open document in default PDF viewer app
Set shell = CreateObject("WScript.Shell")
shell.Run "result.pdf", 1, false
