# openapi.api.GENESISIAApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiAiInsightsGet**](GENESISIAApi.md#apiaiinsightsget) | **GET** /api/ai/insights | Análisis inteligente de ventas estacionales con DeepSeek R1


# **apiAiInsightsGet**
> apiAiInsightsGet()

Análisis inteligente de ventas estacionales con DeepSeek R1

### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getGENESISIAApi();

try {
    api.apiAiInsightsGet();
} catch on DioException (e) {
    print('Exception when calling GENESISIAApi->apiAiInsightsGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

