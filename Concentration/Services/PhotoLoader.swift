//
//  PhotoLoader.swift
//  Concentration
//
//  Created by Yesbol Kulanbekov on 7/2/18.
//  Copyright © 2018 Yesbol Kulanbekov. All rights reserved.
//


import UIKit

import OpalImagePicker
import ImagePicker

class PhotoLoader: NSObject {
    
    var hasPickedImages = CommandWith<[UIImage]> { _ in}
    
    var pickedImages = [UIImage]()

    private var image = [Card:UIImage]()
    
    func image(for card: Card) -> UIImage {
        var pickedImages = self.pickedImages.prefix(20)
        if image[card] == nil, pickedImages.count > 0 {
            image[card] = pickedImages.remove(at: pickedImages.count.arc4random)
        }
        return image[card] ?? UIImage()
    }
    
    func imagePicker(type: UIImagePickerControllerSourceType) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = type
        imagePicker.delegate = self
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: type)!
        return imagePicker
    }

    
    func customImagePicker() -> ImagePickerController {
        let imagePicker = ImagePickerController()
        imagePicker.delegate = self
        return imagePicker
    }

    func opalPicker() -> OpalImagePickerController {
        let imagePicker = OpalImagePickerController()
        imagePicker.imagePickerDelegate = self
        return imagePicker
    }

}

extension PhotoLoader: OpalImagePickerControllerDelegate {
    func imagePickerDidCancel(_ picker: OpalImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePicker(_ picker: OpalImagePickerController, didFinishPickingImages images: [UIImage]) {

    }
    
}


extension PhotoLoader: ImagePickerDelegate {
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        pickedImages = images
        imagePicker.dismiss(animated: true) {
            self.hasPickedImages.perform(with: images)
        }
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        imagePicker.dismiss(animated: true) 

    }
    
    
}

extension PhotoLoader: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            pickedImages.append(image)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
}



struct ImageSheetPresenter {
    
    func pickImage(takePicture: Command, choosePicture: Command) -> UIAlertController {
        let actionSheetController = UIAlertController(title: nil, message: nil , preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        actionSheetController.addAction(cancelAction)
        let takePictureAction = UIAlertAction(title: "Камера", style: .default) { action -> Void in
            takePicture.perform()
        }
        actionSheetController.addAction(takePictureAction)
        let choosePictureAction = UIAlertAction(title: "Мои фото", style: .default) { action -> Void in
            choosePicture.perform()
        }
        
        actionSheetController.addAction(choosePictureAction)
        return actionSheetController
    }
}


struct AlertPresenter {
    
    func showAlert(choosePicture: Command, count: Int) -> UIAlertController {
        let alertController = UIAlertController(title: "Choose More", message: "You have only chosen \(count)", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)
        let choosePictureAction = UIAlertAction(title: "Камера", style: .default) { action -> Void in
            choosePicture.perform()
        }
        alertController.addAction(choosePictureAction)
        return alertController
    }
}



