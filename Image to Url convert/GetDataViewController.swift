//
//  GetDataViewController.swift
//  Image to Url convert
//
//  Created by R95 on 12/03/24.
//

import UIKit

class GetDataViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    var arr = [UserData]()
    
    @IBOutlet weak var userDetailOutlet: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DBHelper.getData()
        arr = DBHelper.userArray
        navigationItem.hidesBackButton = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = userDetailOutlet.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UserDeatilCollectionViewCell
        
        let userData = arr[indexPath.item]
        cell.emailOutlet.text = userData.email
        cell.passwordOutlet.text = userData.password
        
        if let imageData = Data(base64Encoded: userData.image, options: .ignoreUnknownCharacters) {
            cell.imageOutlet.image = UIImage(data: imageData)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 181, height: 333)
    }
    
}
