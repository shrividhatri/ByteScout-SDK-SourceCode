//*******************************************************************************************//
//                                                                                           //
// Download Free Evaluation Version From: https://bytescout.com/download/web-installer       //
//                                                                                           //
// Also available as Web API! Get Your Free API Key: https://app.pdf.co/signup               //
//                                                                                           //
// Copyright © 2017-2019 ByteScout, Inc. All rights reserved.                                //
// https://www.bytescout.com                                                                 //
// https://pdf.co                                                                            //
//                                                                                           //
//*******************************************************************************************//


using System.Diagnostics;
using System.Text;
using Bytescout.BarCode;

namespace QRCodeWithBinaryData
{
	class Program
	{
		static void Main(string[] args)
		{
			// Create and activate QRCode component instance
			using (QRCode barcode = new QRCode())
			{
				barcode.RegistrationName = "demo";
				barcode.RegistrationKey = "demo";

				// Sample byte array to use as value 
				byte[] byteArray = new byte[] { 0, 10, 11, 12, 13, 14, 15, 0xFF };

				// Set value by converting byte array to string 
				barcode.Value = Encoding.ASCII.GetString(byteArray);

				// Save barcode image
				barcode.SaveImage("result.png");

				// Open the image in default associated application (for the demo purpose)
				Process.Start("result.png");
			}
		}
	}
}
