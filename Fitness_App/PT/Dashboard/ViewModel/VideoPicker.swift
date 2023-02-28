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

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .videos
        config.selectionLimit = 3 // ignores limit
        
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

            guard let provider = results.first?.itemProvider else { return }

            provider.loadFileRepresentation(forTypeIdentifier: "public.movie") { url, error in

            guard let url = url else {return}

                self.parent.videoURLs = url.absoluteString
            print(url)
            print(FileManager.default.fileExists(atPath: url.path))

            }
        }
    }
    

            
}
