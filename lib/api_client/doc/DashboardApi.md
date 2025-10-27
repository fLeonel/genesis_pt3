# openapi.api.DashboardApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiDashboardGet**](DashboardApi.md#apidashboardget) | **GET** /api/dashboard | 


# **apiDashboardGet**
> apiDashboardGet()



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getDashboardApi();

try {
    api.apiDashboardGet();
} catch on DioException (e) {
    print('Exception when calling DashboardApi->apiDashboardGet: $e\n');
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

