//
//  ViewController.swift
//  DocumentScanner
//
//  Created by berk birkan on 31.12.2018.
//  Copyright © 2018 Turansoft. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var result: UITextView!
    
    @IBOutlet weak var image: UIImageView!
    
    @IBAction func takeimage(_ sender: Any) {
        let imageupload = UIImagePickerController()
        imageupload.delegate = self
        imageupload.sourceType = .photoLibrary
        imageupload.allowsEditing = false
        self.present(imageupload,animated: true){
            //later
        }
        
        
        
    }
    
    @IBAction func takephoto(_ sender: UIButton) {
        let imagecamera = UIImagePickerController()
        imagecamera.delegate = self
        imagecamera.sourceType = .camera
        imagecamera.allowsEditing = false
        self.present(imagecamera,animated: true){
            //later
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if (info[UIImagePickerController.InfoKey.originalImage] as? UIImage) != nil{
            image.image = info[.originalImage] as? UIImage
            result.text = "Deneme"
            let vision = Vision.vision()
            let textRecognizer = vision.onDeviceTextRecognizer()
            let imagevision = VisionImage(image: image.image!)
            
            textRecognizer.process(imagevision) { sonuc, error in
                guard error == nil, let sonuc = sonuc else {
                    self.result.text = "Can't read :("
                    return
                }
                
                // Recognized text
                self.result.text=sonuc.text
            }
            
            
         }else{
            //Error
         }
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
}

