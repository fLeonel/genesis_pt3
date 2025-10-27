# openapi.api.RecetasApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiRecetasGet**](RecetasApi.md#apirecetasget) | **GET** /api/recetas | 
[**apiRecetasIdDelete**](RecetasApi.md#apirecetasiddelete) | **DELETE** /api/recetas/{id} | 
[**apiRecetasIdGet**](RecetasApi.md#apirecetasidget) | **GET** /api/recetas/{id} | 
[**apiRecetasIdPut**](RecetasApi.md#apirecetasidput) | **PUT** /api/recetas/{id} | 
[**apiRecetasPost**](RecetasApi.md#apirecetaspost) | **POST** /api/recetas | 


# **apiRecetasGet**
> apiRecetasGet()



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getRecetasApi();

try {
    api.apiRecetasGet();
} catch on DioException (e) {
    print('Exception when calling RecetasApi->apiRecetasGet: $e\n');
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

# **apiRecetasIdDelete**
> apiRecetasIdDelete(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getRecetasApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.apiRecetasIdDelete(id);
} catch on DioException (e) {
    print('Exception when calling RecetasApi->apiRecetasIdDelete: $e\n');
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

# **apiRecetasIdGet**
> apiRecetasIdGet(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getRecetasApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.apiRecetasIdGet(id);
} catch on DioException (e) {
    print('Exception when calling RecetasApi->apiRecetasIdGet: $e\n');
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

# **apiRecetasIdPut**
> apiRecetasIdPut(id, updateRecetaCommand)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getRecetasApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final UpdateRecetaCommand updateRecetaCommand = ; // UpdateRecetaCommand | 

try {
    api.apiRecetasIdPut(id, updateRecetaCommand);
} catch on DioException (e) {
    print('Exception when calling RecetasApi->apiRecetasIdPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **updateRecetaCommand** | [**UpdateRecetaCommand**](UpdateRecetaCommand.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiRecetasPost**
> apiRecetasPost(createRecetaCommand)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getRecetasApi();
final CreateRecetaCommand createRecetaCommand = ; // CreateRecetaCommand | 

try {
    api.apiRecetasPost(createRecetaCommand);
} catch on DioException (e) {
    print('Exception when calling RecetasApi->apiRecetasPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createRecetaCommand** | [**CreateRecetaCommand**](CreateRecetaCommand.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

