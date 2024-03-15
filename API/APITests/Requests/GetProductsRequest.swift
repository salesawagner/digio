import API

struct GetProductsRequest: APIRequest {
    typealias Response = GetProductsResponse

    var httpMethod: APIHTTPMethod {
        .get
    }

    var resourceName: String {
        "products"
    }
}
