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

    var selectionLimit: Int = 0
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.preferredAssetRepresentationMode = .compatible
        config.selectionLimit = selectionLimit // ignores limit when set to 0
        
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
                        let parent = self.parent
                        if parent.selectionLimit == 1 && !parent.image.isEmpty {
                            parent.image[0] = image
                        } else {
                            parent.image.append(image)
                        }
                    }
                }
            }
        }
    }
}
