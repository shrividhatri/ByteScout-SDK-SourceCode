## How to file calculate hash in C# and PDF.co Web API What is PDF.co Web API? It is the flexible Web API that includes full set of functions from e-signature requests to data extraction, OCR, images recognition, pdf splitting and pdf splitting. Can also generate barcodes and read barcodes from images, scans and pdf.

## REQUEST FREE TECH SUPPORT

[Click here to get in touch](https://bytescout.zendesk.com/hc/en-us/requests/new?subject=PDF.co%20Web%20API%20Question)

or just send email to [support@bytescout.com](mailto:support@bytescout.com?subject=PDF.co%20Web%20API%20Question) 

## ON-PREMISE OFFLINE SDK 

[Get Your 60 Day Free Trial](https://bytescout.com/download/web-installer?utm_source=github-readme)
[Explore Documentation](https://bytescout.com/documentation/index.html?utm_source=github-readme)
[Explore Source Code Samples](https://github.com/bytescout/ByteScout-SDK-SourceCode/)
[Sign Up For Online Training](https://academy.bytescout.com/)


## ON-DEMAND REST WEB API

[Get your API key](https://app.pdf.co/signup?utm_source=github-readme)
[Security](https://pdf.co/security)
[Explore Web API Documentation](https://apidocs.pdf.co?utm_source=github-readme)
[Explore Web API Samples](https://github.com/bytescout/ByteScout-SDK-SourceCode/tree/master/PDF.co%20Web%20API)

## VIDEO REVIEW

[https://www.youtube.com/watch?v=NEwNs2b9YN8](https://www.youtube.com/watch?v=NEwNs2b9YN8)




<!-- code block begin -->

##### **FileCalculateHash.cs:**
    
```
using System;
using RestSharp;
namespace HelloWorldApplication {
		class HelloWorld {
				static void Main(string[] args) {
						var client = new RestClient("https://api.pdf.co/v1/file/hash");
						client.Timeout = -1;
						var request = new RestRequest(Method.POST);
						request.AddHeader("x-api-key", "{{x-api-key}}");
						request.AddHeader("Content-Type", "application/json");
						request.AddParameter("application/json", "{\n    \"url\": \"https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-split/sample.pdf\"\n}",  ParameterType.RequestBody);
						IRestResponse response = client.Execute(request);
						Console.WriteLine(response.Content);
				}
		}
}

```

<!-- code block end -->