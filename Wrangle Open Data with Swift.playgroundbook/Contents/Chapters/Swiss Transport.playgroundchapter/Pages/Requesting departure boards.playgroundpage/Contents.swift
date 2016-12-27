//#-hidden-code
import Foundation
//#-end-hidden-code
let requestDocument = AEXMLDocument()
let trias = requestDocument.addChild(name: "Trias", value: nil, attributes: ["version":"1.1", "xmlns":"http://www.vdv.de/trias", "xmlns:siri":"http://www.siri.org.uk/siri", "xmlns:xsi":"http://www.w3.org/2001/XMLSchema-instance"])
let serviceRequest = trias.addChild(name: "ServiceRequest")
let requestTimestamp = serviceRequest.addChild(name: "siri:RequestTimestamp", value: "2016-12-27T11:50:50", attributes: [:])
let requestorRef = serviceRequest.addChild(name: "siri:RequestorRef")
let requestPayload = serviceRequest.addChild(name: "RequestPayload")
let stopEventRequest = requestPayload.addChild(name: "StopEventRequest")
let location = stopEventRequest.addChild(name: "Location")
let params = stopEventRequest.addChild(name: "Params")
let locationRef = location.addChild(name: "LocationRef")
let stopPointRef = locationRef.addChild(name: "StopPointRef", value: "8591391", attributes: [:])
let depArrTime = location.addChild(name: "DepArrTime", value: "2016-12-10T10:10:10", attributes: [:])
let numberOfResults = params.addChild(name: "NumberOfResults", value: "30", attributes: [:])
requestDocument.xml


var request = URLRequest(url: URL(string: "https://api.opentransportdata.swiss/trias")!)
request.httpMethod = "POST"
request.httpBody = requestDocument.xml.data(using: .utf8)
request.addValue("application/XML", forHTTPHeaderField: "Content-Type")

let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
    data
    if let json = try? JSONSerialization.jsonObject(with: data!, options: []) {
        json
    }
    if let document = try? AEXMLDocument(xml: data!) {
        print(document.tree())
        document["Trias"]["ServiceDelivery"].first?.children.map { $0.xml }
        document["Trias"]["ServiceDelivery"]["DeliveryPayload"]["StopEventResponse"]["StopEventResult"]["StopEvent"]["Service"].first?.children.map { $0.xml }
    }
    response?.description
    if let error = error as? NSError {
        error
        error.localizedDescription
        error.userInfo
    }
})
task.resume()

extension AEXMLDocument {
    func tree() -> String {
        var tree = ""
        tree = self.tree(parent: self, depth: 0, result: tree)
        return tree
    }

    private func tree(parent: AEXMLElement, depth: Int, result: String) -> String {
        var result = result

        parent.children.forEach { (element) in
            if element.children.count == 0 {
                (0...depth-1).forEach { _ in result.append("-") }
                result.append("┫ \(element.name)\n")
            } else {
                (0..<depth).forEach { _ in result.append("-") }
                result.append("┳\(element.name)\n")
                result = tree(parent: element, depth: depth+1, result: result)
            }
        }
        return result
    }
}