# openapi.api.VentasApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiVentasGet**](VentasApi.md#apiventasget) | **GET** /api/ventas | 
[**apiVentasIdConfirmarPut**](VentasApi.md#apiventasidconfirmarput) | **PUT** /api/ventas/{id}/confirmar | 
[**apiVentasIdDelete**](VentasApi.md#apiventasiddelete) | **DELETE** /api/ventas/{id} | 
[**apiVentasIdGet**](VentasApi.md#apiventasidget) | **GET** /api/ventas/{id} | 
[**apiVentasIdPut**](VentasApi.md#apiventasidput) | **PUT** /api/ventas/{id} | 
[**apiVentasPost**](VentasApi.md#apiventaspost) | **POST** /api/ventas | 


# **apiVentasGet**
> apiVentasGet()



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getVentasApi();

try {
    api.apiVentasGet();
} catch on DioException (e) {
    print('Exception when calling VentasApi->apiVentasGet: $e\n');
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

# **apiVentasIdConfirmarPut**
> apiVentasIdConfirmarPut(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getVentasApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.apiVentasIdConfirmarPut(id);
} catch on DioException (e) {
    print('Exception when calling VentasApi->apiVentasIdConfirmarPut: $e\n');
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

# **apiVentasIdDelete**
> apiVentasIdDelete(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getVentasApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.apiVentasIdDelete(id);
} catch on DioException (e) {
    print('Exception when calling VentasApi->apiVentasIdDelete: $e\n');
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

# **apiVentasIdGet**
> apiVentasIdGet(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getVentasApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.apiVentasIdGet(id);
} catch on DioException (e) {
    print('Exception when calling VentasApi->apiVentasIdGet: $e\n');
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

# **apiVentasIdPut**
> apiVentasIdPut(id, updateVentaCommand)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getVentasApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final UpdateVentaCommand updateVentaCommand = ; // UpdateVentaCommand | 

try {
    api.apiVentasIdPut(id, updateVentaCommand);
} catch on DioException (e) {
    print('Exception when calling VentasApi->apiVentasIdPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **updateVentaCommand** | [**UpdateVentaCommand**](UpdateVentaCommand.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiVentasPost**
> apiVentasPost(createVentaCommand)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getVentasApi();
final CreateVentaCommand createVentaCommand = ; // CreateVentaCommand | 

try {
    api.apiVentasPost(createVentaCommand);
} catch on DioException (e) {
    print('Exception when calling VentasApi->apiVentasPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createVentaCommand** | [**CreateVentaCommand**](CreateVentaCommand.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

