import Foundation

class TrentinoBikeStationService: BikeStationService {

    private let url: URL
    private weak var delegate: BikeStationServiceDelegate?

    init(url:URL) {
        self.url = url
    }

    func getStations(delegate: BikeStationServiceDelegate) {
        print("getStations")

        self.delegate = delegate
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: url, completionHandler: self.handleResponse)
        task.resume()
    }

    private func handleResponse(data: Data?, response: URLResponse?, error: Error?) {
        print("handleResponse")
        switch (data, response, error) {
        case let (_, _, error?):
            print("error = ", error.localizedDescription)
            self.delegate?.set(bikeStations: [])
            
        case let (data?, response?, _) where self.isSuccess(response: response):
            print("isSuccess")
            if let stations = try? JSONDecoder().decode([BikeStationNew].self, from: data) {
                let legacyStations = stations.compactMap { BikeStation(bikeStationNew: $0) }
                self.delegate?.set(bikeStations: legacyStations)
            }
        default:
            print("unhandled case")
        }
    }

    private func isSuccess(response: URLResponse) -> Bool {
        if let httpResponse = response as? HTTPURLResponse {
            return httpResponse.statusCode == 200
        }
        
        return false
    }
}
