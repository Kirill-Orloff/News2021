//
//  BaseNetwork.swift
//  News
//
//  Created by Kirill Orloff on 23.01.2021.
//

import Moya

typealias NetworkFailureBlock = ((PresentableError?) -> ())

class BaseNetwork {
    
    // MARK: - Internal
    func processResponse<T>(
        result: Result<Response, MoyaError>,
        success: ((T) -> ())?,
        failure: NetworkFailureBlock?
    ) where T: Codable {
        switch result {
        case .success(let response):
            validateResponse(response) { [weak self] in
                self?.processData(response: response) { data in
                    success?(data)
                } failure: { error in
                    failure?(error)
                }
            } failure: { error in
                failure?(error)
            }
        case .failure(let error):
            let presentableError = PresentableError(message: error.localizedDescription)
            failure?(presentableError)
        }
    }
    
    // MARK: - Private
    private func validateResponse(_ response: Response, success: (() -> ())?, failure: NetworkFailureBlock?) {
        do {
            let _ = try response.filterSuccessfulStatusCodes()
            success?()
        } catch {
            processServerError(response: response, failure: failure)
        }
    }
    
    private func processData<T>(
        response: Response,
        success: ((T) -> ())?,
        failure: NetworkFailureBlock?
    ) where T: Codable {
        do {
            let data = try response.map(T.self)
            success?(data)
        } catch let error {
            let presentableError = PresentableError(message: error.localizedDescription)
            failure?(presentableError)
        }
    }
    
    private func processServerError(response: Response, failure: NetworkFailureBlock?) {
        do {
            let serverError = try response.map(ServerError.self)
            let presentableError = PresentableError(message: serverError.message)
            failure?(presentableError)
        } catch let error {
            let presentableError = PresentableError(message: error.localizedDescription)
            failure?(presentableError)
        }
    }
}
