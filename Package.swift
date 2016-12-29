import PackageDescription

let package = Package(
    name: "Swifterland-Open-Data",
    dependencies: [
        .Package(url: "https://github.com/tadija/AEXML.git", majorVersion: 4),
])