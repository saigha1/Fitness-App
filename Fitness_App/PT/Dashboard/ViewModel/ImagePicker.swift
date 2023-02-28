//
//  ImagePicker.swift
//  Fitness_App
//
//  Created by MAC on 2023-02-16.
//

import PhotosUI
import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: [UIImage]

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 0 // ignores limit
        
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
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)

            guard let provider = results.first?.itemProvider else { return }

            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, error in
                    if let error = error {
                      print("Can't load image \(error.localizedDescription)")
                    } else if let image = image as? UIImage {
                        self.parent.image.append(image)
                        //                    self.parent.image = image as? UIImage
                    }
                }
            }
        }
    }
}
