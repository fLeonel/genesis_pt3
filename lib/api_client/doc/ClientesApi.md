# openapi.api.ClientesApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiClientesGet**](ClientesApi.md#apiclientesget) | **GET** /api/clientes | 
[**apiClientesIdDelete**](ClientesApi.md#apiclientesiddelete) | **DELETE** /api/clientes/{id} | 
[**apiClientesIdGet**](ClientesApi.md#apiclientesidget) | **GET** /api/clientes/{id} | 
[**apiClientesIdPut**](ClientesApi.md#apiclientesidput) | **PUT** /api/clientes/{id} | 
[**apiClientesPost**](ClientesApi.md#apiclientespost) | **POST** /api/clientes | 


# **apiClientesGet**
> apiClientesGet()



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getClientesApi();

try {
    api.apiClientesGet();
} catch on DioException (e) {
    print('Exception when calling ClientesApi->apiClientesGet: $e\n');
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

# **apiClientesIdDelete**
> apiClientesIdDelete(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getClientesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.apiClientesIdDelete(id);
} catch on DioException (e) {
    print('Exception when calling ClientesApi->apiClientesIdDelete: $e\n');
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

# **apiClientesIdGet**
> apiClientesIdGet(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getClientesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.apiClientesIdGet(id);
} catch on DioException (e) {
    print('Exception when calling ClientesApi->apiClientesIdGet: $e\n');
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

# **apiClientesIdPut**
> apiClientesIdPut(id, updateClienteCommand)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getClientesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final UpdateClienteCommand updateClienteCommand = ; // UpdateClienteCommand | 

try {
    api.apiClientesIdPut(id, updateClienteCommand);
} catch on DioException (e) {
    print('Exception when calling ClientesApi->apiClientesIdPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **updateClienteCommand** | [**UpdateClienteCommand**](UpdateClienteCommand.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiClientesPost**
> apiClientesPost(createClienteCommand)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getClientesApi();
final CreateClienteCommand createClienteCommand = ; // CreateClienteCommand | 

try {
    api.apiClientesPost(createClienteCommand);
} catch on DioException (e) {
    print('Exception when calling ClientesApi->apiClientesPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createClienteCommand** | [**CreateClienteCommand**](CreateClienteCommand.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

