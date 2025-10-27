# openapi.api.CombosApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiCombosGet**](CombosApi.md#apicombosget) | **GET** /api/combos | 
[**apiCombosIdDelete**](CombosApi.md#apicombosiddelete) | **DELETE** /api/combos/{id} | 
[**apiCombosIdGet**](CombosApi.md#apicombosidget) | **GET** /api/combos/{id} | 
[**apiCombosIdPut**](CombosApi.md#apicombosidput) | **PUT** /api/combos/{id} | 
[**apiCombosPost**](CombosApi.md#apicombospost) | **POST** /api/combos | 


# **apiCombosGet**
> apiCombosGet()



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getCombosApi();

try {
    api.apiCombosGet();
} catch on DioException (e) {
    print('Exception when calling CombosApi->apiCombosGet: $e\n');
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

# **apiCombosIdDelete**
> apiCombosIdDelete(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getCombosApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.apiCombosIdDelete(id);
} catch on DioException (e) {
    print('Exception when calling CombosApi->apiCombosIdDelete: $e\n');
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

# **apiCombosIdGet**
> apiCombosIdGet(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getCombosApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.apiCombosIdGet(id);
} catch on DioException (e) {
    print('Exception when calling CombosApi->apiCombosIdGet: $e\n');
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

# **apiCombosIdPut**
> apiCombosIdPut(id, updateComboCommand)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getCombosApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final UpdateComboCommand updateComboCommand = ; // UpdateComboCommand | 

try {
    api.apiCombosIdPut(id, updateComboCommand);
} catch on DioException (e) {
    print('Exception when calling CombosApi->apiCombosIdPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **updateComboCommand** | [**UpdateComboCommand**](UpdateComboCommand.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiCombosPost**
> apiCombosPost(createComboCommand)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getCombosApi();
final CreateComboCommand createComboCommand = ; // CreateComboCommand | 

try {
    api.apiCombosPost(createComboCommand);
} catch on DioException (e) {
    print('Exception when calling CombosApi->apiCombosPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createComboCommand** | [**CreateComboCommand**](CreateComboCommand.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

