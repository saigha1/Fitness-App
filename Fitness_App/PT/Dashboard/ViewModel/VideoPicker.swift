//
//  VideoPicker.swift
//  Fitness_App
//
//  Created by MAC on 2023-02-24.
//

import PhotosUI
import SwiftUI
import UIKit

struct VideoPicker: UIViewControllerRepresentable {
    @Binding var videoURLs : [String]
    var selectionLimit : Int = 0
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .videos
        config.selectionLimit = selectionLimit  // ignores limit
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: VideoPicker

        init(_ parent: VideoPicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)

            for result in results {
                let provider = result.itemProvider
                
                provider.loadFileRepresentation(forTypeIdentifier: "public.movie") { url, error in
                    guard error == nil else{
                        print(error)
                        return
                    }
                    // receiving the video-local-URL / filepath
                    guard let url = url else {return}
                    // create a new filename
                    let fileName = "\(Int(Date().timeIntervalSince1970)).\(url.pathExtension)"
                    // create new URL
//                    let newUrl: URL = .cachesDirectory.appending(path: fileName)
//                    let newUrl = URL(fileURLWithPath: NSHomeDirectory() + "/" + fileName)
                    let newUrl = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!.appendingPathComponent(fileName, conformingTo: .video)
                    // copy item to APP Storage
                    try? FileManager.default.copyItem(at: url, to: newUrl)
                   
                    self.parent.videoURLs.append(newUrl.absoluteString)
//                    print(type(of: self.parent.videoURLs))
                }
            }
        }
    }
}


func imageFromVideo(url: URL, at time: TimeInterval) -> UIImage? {
    let asset = AVURLAsset(url: url)

    let assetIG = AVAssetImageGenerator(asset: asset)
    assetIG.appliesPreferredTrackTransform = true
    assetIG.apertureMode = AVAssetImageGenerator.ApertureMode.encodedPixels

    let cmTime = CMTime(seconds: time, preferredTimescale: 60)
    let thumbnailImageRef: CGImage
    do {
        thumbnailImageRef = try assetIG.copyCGImage(at: cmTime, actualTime: nil)
    } catch let error {
        print("Error: \(error)")
        return nil
    }

    return UIImage(cgImage: thumbnailImageRef)
}
