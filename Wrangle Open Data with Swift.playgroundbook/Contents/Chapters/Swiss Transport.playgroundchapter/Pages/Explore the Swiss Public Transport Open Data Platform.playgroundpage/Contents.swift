//#-hidden-code
import Foundation
//#-end-hidden-code
import PlaygroundSupport
import SafariServices

public let openDataURL = URL(string: "https://opentransportdata.swiss/")!
let safariViewController = SFSafariViewController(url: openDataURL)
PlaygroundPage.current.liveView = safariViewController
/*:
 Next, find out how to use a few of the data sets
 */