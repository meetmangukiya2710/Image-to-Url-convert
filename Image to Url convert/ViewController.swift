//
//  ViewController.swift
//  Image to Url convert
//
//  Created by R95 on 11/03/24.
//

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var arr = [UserData]()
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var text1: UITextField!
    @IBOutlet weak var text2: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DBHelper.createFile()
        arr = DBHelper.userArray
    }
    
    
    @IBAction func imageClickBuutonAction(_ sender: Any) {
        alert()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        image.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        dismiss(animated: true)
    }
    
    func alert() {
        let a = UIAlertController(title: "Select Image", message: "", preferredStyle: .alert)
        
        a.addAction(UIAlertAction(title: "Ok", style: .default))
        a.addAction(UIAlertAction(title: "Camara", style: .default))
        a.addAction(UIAlertAction(title: "Gallary", style: .default, handler: { _ in
            let a = UIImagePickerController()
            a.sourceType = .photoLibrary
            a.delegate = self
            a.allowsEditing = true
            self.present(a, animated: true)
            
        }))
        present(a, animated: true)
    }
    
    @IBAction func addData(_ sender: Any) {
        let imageString = self.image.image?.pngData()?.base64EncodedString()
        print(imageString ?? "Nil Value")
        
        if text1.text == "" && text2.text == "" {
            alert1(title: "Error!",message: "Enter the Deatil!")
        }
        else if text1.text == "" {
            alert1(title: "Error!",message: "Enter the Email!")
        }
        else if text2.text == "" {
            alert1(title: "Error!",message: "Enter the Password!")
        }
        else {
            DBHelper.addData(email: text1.text ?? "", password: text2.text ?? "", image : imageString!)
        }
        
    }
    
    func alert1(title: String, message: String) {
        let a = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        a.addAction(UIAlertAction(title: "Ok", style: .cancel))
        a.addAction(UIAlertAction(title: "Cancel", style: .destructive))
        present(a, animated: true)
    }
    
    @IBAction func getData(_ sender: Any) {
        let navigate = storyboard?.instantiateViewController(identifier: "GetDataViewController") as! GetDataViewController
        navigationController?.pushViewController(navigate, animated: true)
    }
}


