//
//  ViewController.swift
//  PickPhotos
//
//  Created by 李世文 on 2021/7/18.
//

import UIKit
import PhotosUI

class ViewController: UIViewController, PHPickerViewControllerDelegate {
    //選擇多張Photo
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {

        picker.dismiss(animated: true, completion: nil)

        let itemProviders = results.map(\.itemProvider)
        for (i, itemProvider) in itemProviders.enumerated() where
            itemProvider.canLoadObject(ofClass: UIImage.self){

            let previousImage = self.imageViews[i].image

            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                DispatchQueue.main.async {
                    guard let self = self,
                          let image = image as? UIImage,
                          self.imageViews[i].image == previousImage else{
                        return
                    }

                    self.imageViews[i].image = image
                }
            }
        }
    }
    //選擇單張Photo
//    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
//
//        picker.dismiss(animated: true, completion: nil)
//
//        let itemProviders = results.map(\.itemProvider)
//        if let itemProvider = itemProviders.first,
//           itemProvider.canLoadObject(ofClass: UIImage.self){
//
//            let previousImage = self.imageViews.first?.image
//
//            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
//                DispatchQueue.main.async {
//                    guard let self = self,
//                          let image = image as? UIImage,
//                          self.imageViews.first?.image == previousImage else{
//                        return
//                    }
//
//                    self.imageViews.first?.image = image
//                }
//            }
//        }
//    }
    

    
    @IBOutlet var imageViews: [UIImageView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func selectPhotos(_ sender: Any) {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 2
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
    
}
