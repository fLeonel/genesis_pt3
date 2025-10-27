# openapi.api.CategoriasApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiCategoriasGet**](CategoriasApi.md#apicategoriasget) | **GET** /api/categorias | 
[**apiCategoriasIdDelete**](CategoriasApi.md#apicategoriasiddelete) | **DELETE** /api/categorias/{id} | 
[**apiCategoriasIdGet**](CategoriasApi.md#apicategoriasidget) | **GET** /api/categorias/{id} | 
[**apiCategoriasIdPut**](CategoriasApi.md#apicategoriasidput) | **PUT** /api/categorias/{id} | 
[**apiCategoriasPost**](CategoriasApi.md#apicategoriaspost) | **POST** /api/categorias | 


# **apiCategoriasGet**
> apiCategoriasGet()



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getCategoriasApi();

try {
    api.apiCategoriasGet();
} catch on DioException (e) {
    print('Exception when calling CategoriasApi->apiCategoriasGet: $e\n');
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

# **apiCategoriasIdDelete**
> apiCategoriasIdDelete(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getCategoriasApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.apiCategoriasIdDelete(id);
} catch on DioException (e) {
    print('Exception when calling CategoriasApi->apiCategoriasIdDelete: $e\n');
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

# **apiCategoriasIdGet**
> apiCategoriasIdGet(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getCategoriasApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.apiCategoriasIdGet(id);
} catch on DioException (e) {
    print('Exception when calling CategoriasApi->apiCategoriasIdGet: $e\n');
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

# **apiCategoriasIdPut**
> apiCategoriasIdPut(id, updateCategoriaCommand)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getCategoriasApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final UpdateCategoriaCommand updateCategoriaCommand = ; // UpdateCategoriaCommand | 

try {
    api.apiCategoriasIdPut(id, updateCategoriaCommand);
} catch on DioException (e) {
    print('Exception when calling CategoriasApi->apiCategoriasIdPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **updateCategoriaCommand** | [**UpdateCategoriaCommand**](UpdateCategoriaCommand.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiCategoriasPost**
> apiCategoriasPost(createCategoriaCommand)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getCategoriasApi();
final CreateCategoriaCommand createCategoriaCommand = ; // CreateCategoriaCommand | 

try {
    api.apiCategoriasPost(createCategoriaCommand);
} catch on DioException (e) {
    print('Exception when calling CategoriasApi->apiCategoriasPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createCategoriaCommand** | [**CreateCategoriaCommand**](CreateCategoriaCommand.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

