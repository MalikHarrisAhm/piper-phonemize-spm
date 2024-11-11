// swift-tools-version: 5.9

import PackageDescription

let onnxruntimeVersionString = "1.19.2"
let onnxruntimeVersion = Version(onnxruntimeVersionString)!

let package = Package(
    name: "piper_phonemize",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "piper_phonemize",
            targets: ["piper_phonemize"])
    ],
    dependencies: [
        .package(url: "https://github.com/IhorShevchuk/espeak-ng-spm",
                 "2023.9.13"..."2023.9.13"), /// Uses 0f65aa301e0d6bae5e172cc74197d32a6182200f version of espeak-ng from https://github.com/rhasspy/espeak-ng that is mentioned in piper-phonemize/CMakeLists.txt
        .package(url: "https://github.com/microsoft/onnxruntime-swift-package-manager", onnxruntimeVersion...onnxruntimeVersion)
    ],
    targets: [
        .target(name: "piper_phonemize",
                dependencies: [
                    .product(name: "libespeak-ng", package: "espeak-ng-spm"),
                    .product(name: "onnxruntime", package: "onnxruntime-swift-package-manager")
                ],
                path: "",
                sources: [
                    "piper_phonemize/src/phonemize.cpp",
                    "piper_phonemize/src/phoneme_ids.cpp",
                    "piper_phonemize/src/tashkeel.cpp",
                    "piper_phonemize/src/shared.cpp"
                ],
                publicHeadersPath: "public"
               )
    ],
    cxxLanguageStandard: .cxx17
)
