//#-hidden-code
import Foundation
//#-end-hidden-code
//#-hidden-code
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//#end-hidden-code

protocol Record {
    init?(json: Any)
}

struct Response<R: Record> {
    let help: String
    let success: Bool
    let result: Result<R>

    init?(json: Any) {
        guard let help = (json as AnyObject).value(forKey: "help") as? String,
              let success = (json as AnyObject).value(forKey: "success") as? Bool,
              let result = Result<R>(json: (json as AnyObject).value(forKey: "result") as Any) else { return nil }
        self.help = help
        self.success = success
        self.result = result
    }
}

struct Result<R: Record> {
    init?(json: Any) {
        guard let recordJSON = (json as AnyObject).value(forKey: "records") as? [AnyObject] else { return nil }
        records = recordJSON.flatMap(R.init)
    }

    let records: [R]
}

struct Station: Record, CustomDebugStringConvertible, CustomStringConvertible {
    let station: String
    let stationID: String

    init?(json: Any) {
        guard let station = (json as AnyObject).value(forKey: "Station") as? String,
            let stationID = (json as AnyObject).value(forKey: "StationID") as? String else { return nil }
        self.station = station
        self.stationID = stationID
    }

    var debugDescription: String {
        get {
            return "\(#function) \(station) \(stationID)"
        }
    }

    var description: String {
        get {
            return "\(#function) \(station) \(stationID)"
        }
    }
}
/*:
 Insert a stop name you would like to search for
 */
var stopName = /*#-editable-code Olten*/""/*#-end-editable-code*/
extension URL {
    mutating func add(stopName: String) {
        let queryItem = URLQueryItem(name: "q", value: stopName)
        if var components = URLComponents(url: self, resolvingAgainstBaseURL: false) {
            components.queryItems?.append(queryItem)
            guard let url = components.url else { return }
            self = url
        }
    }
}

stationListURL.add(stopName: stopName)

let stationListTask = URLSession.shared.dataTask(with: stationListURL) { (data, response, error) in
    guard error == nil, let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) else { error; return }
    if let response = Response<Station>(json: json) {
        response.success
        response.result.records
    }
}
stationListTask.resume()