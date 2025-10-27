# openapi.api.ProductosApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiProductosGet**](ProductosApi.md#apiproductosget) | **GET** /api/productos | 
[**apiProductosIdDelete**](ProductosApi.md#apiproductosiddelete) | **DELETE** /api/productos/{id} | 
[**apiProductosIdGet**](ProductosApi.md#apiproductosidget) | **GET** /api/productos/{id} | 
[**apiProductosIdPut**](ProductosApi.md#apiproductosidput) | **PUT** /api/productos/{id} | 
[**apiProductosPost**](ProductosApi.md#apiproductospost) | **POST** /api/productos | 


# **apiProductosGet**
> apiProductosGet()



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getProductosApi();

try {
    api.apiProductosGet();
} catch on DioException (e) {
    print('Exception when calling ProductosApi->apiProductosGet: $e\n');
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

# **apiProductosIdDelete**
> apiProductosIdDelete(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getProductosApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.apiProductosIdDelete(id);
} catch on DioException (e) {
    print('Exception when calling ProductosApi->apiProductosIdDelete: $e\n');
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

# **apiProductosIdGet**
> apiProductosIdGet(id)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getProductosApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.apiProductosIdGet(id);
} catch on DioException (e) {
    print('Exception when calling ProductosApi->apiProductosIdGet: $e\n');
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

# **apiProductosIdPut**
> apiProductosIdPut(id, updateProductoCommand)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getProductosApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final UpdateProductoCommand updateProductoCommand = ; // UpdateProductoCommand | 

try {
    api.apiProductosIdPut(id, updateProductoCommand);
} catch on DioException (e) {
    print('Exception when calling ProductosApi->apiProductosIdPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **updateProductoCommand** | [**UpdateProductoCommand**](UpdateProductoCommand.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiProductosPost**
> apiProductosPost(createProductoCommand)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getProductosApi();
final CreateProductoCommand createProductoCommand = ; // CreateProductoCommand | 

try {
    api.apiProductosPost(createProductoCommand);
} catch on DioException (e) {
    print('Exception when calling ProductosApi->apiProductosPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createProductoCommand** | [**CreateProductoCommand**](CreateProductoCommand.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

