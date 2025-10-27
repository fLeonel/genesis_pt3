# openapi.api.BodegasApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiBodegasGet**](BodegasApi.md#apibodegasget) | **GET** /api/bodegas | 
[**apiBodegasIdDelete**](BodegasApi.md#apibodegasiddelete) | **DELETE** /api/bodegas/{id} | 
[**apiBodegasIdGet**](BodegasApi.md#apibodegasidget) | **GET** /api/bodegas/{id} | 
[**apiBodegasIdPut**](BodegasApi.md#apibodegasidput) | **PUT** /api/bodegas/{id} | 
[**apiBodegasPost**](BodegasApi.md#apibodegaspost) | **POST** /api/bodegas | 


# **apiBodegasGet**
> apiBodegasGet()



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getBodegasApi();

try {
    api.apiBodegasGet();
} catch on DioException (e) {
    print('Exception when calling BodegasApi->apiBodegasGet: $e\n');
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

# **apiBodegasIdDelete**
> apiBodegasIdDelete(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getBodegasApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.apiBodegasIdDelete(id);
} catch on DioException (e) {
    print('Exception when calling BodegasApi->apiBodegasIdDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiBodegasIdGet**
> apiBodegasIdGet(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getBodegasApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.apiBodegasIdGet(id);
} catch on DioException (e) {
    print('Exception when calling BodegasApi->apiBodegasIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiBodegasIdPut**
> apiBodegasIdPut(id, updateBodegaCommand)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getBodegasApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final UpdateBodegaCommand updateBodegaCommand = ; // UpdateBodegaCommand | 

try {
    api.apiBodegasIdPut(id, updateBodegaCommand);
} catch on DioException (e) {
    print('Exception when calling BodegasApi->apiBodegasIdPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **updateBodegaCommand** | [**UpdateBodegaCommand**](UpdateBodegaCommand.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiBodegasPost**
> apiBodegasPost(createBodegaCommand)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getBodegasApi();
final CreateBodegaCommand createBodegaCommand = ; // CreateBodegaCommand | 

try {
    api.apiBodegasPost(createBodegaCommand);
} catch on DioException (e) {
    print('Exception when calling BodegasApi->apiBodegasPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createBodegaCommand** | [**CreateBodegaCommand**](CreateBodegaCommand.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

