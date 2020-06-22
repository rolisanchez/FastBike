import Foundation

class TrentinoBikeStationService: BikeStationService {

    private let url: URL
    private var delegate: BikeStationServiceDelegate?

    init(url:URL) {
        print("url is \(url)")
        self.url = url
    }

    func getStations(delegate: BikeStationServiceDelegate) {
        self.delegate = delegate
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: url, completionHandler: self.handleResponse)
        task.resume()
    }

    private func handleResponse(data: Data?, response: URLResponse?, error: Error?) {
        
        switch (data, response, error) {
        case let (_, _, error?):
            self.delegate?.set(bikeStations: [])
            print("Error = \(error.localizedDescription)")
        case let (data?, response?, _) where self.isSuccess(response: response):
            if let stations = try? JSONDecoder().decode([BikeStationNew].self, from: data) {
                let legacyStations = stations.compactMap { BikeStation(bikeStationNew: $0) }
                self.delegate?.set(bikeStations: legacyStations)
                print("Got \(legacyStations.count) bikes from URL")
            } else {
                self.delegate?.set(bikeStations: [])
                print("Could not get bikes from URL")
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
