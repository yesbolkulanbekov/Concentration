//
//  PhotoLoader.swift
//  Concentration
//
//  Created by Yesbol Kulanbekov on 7/2/18.
//  Copyright © 2018 Yesbol Kulanbekov. All rights reserved.
//

import Foundation
import Photos


class PhotoLoader {
    let library = PHPhotoLibrary()
    
    
    func imagePicker(type: UIImagePickerControllerSourceType) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = type
        //imagePicker.delegate = self
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: type)!
        return imagePicker
    }
    

}

struct ImageSheetPresenter {
    
    func pickImage(takePicture: Command, choosePicture: Command) -> UIAlertController {
        let actionSheetController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
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




//extension EditContactViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
//    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
//            output.picked(imageContainer: ImageInfo(image: image))
//        }
//        self.dismiss(animated: true, completion: nil)
//    }
//
//}

