
//  ViewController.swift
//  PhotoPicker
//
//  Created by Stephen Zhu on 6/10/22.
//

import UIKit
import Photos
import PhotosUI

class PhotoPickerView: UIViewController,PHPickerViewControllerDelegate{
    
    var image: UIImage!
    var VideoUrl: URL!
    @IBOutlet weak var Confirm: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Please Pick a Photo And a Video"
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(TapAdd))
    }
    @objc private func TapAdd(){
        //narrow the scale for picking
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.selectionLimit = 2
        config.selection = .ordered
        config.filter = PHPickerFilter.any(of: [.images,.videos])
        let VC = PHPickerViewController(configuration: config)
        VC.delegate = self
        present(VC, animated: true)
    }
    /// - Tag: ParsePickerResults
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true,completion: nil)
        
        for result in results{
            if result.itemProvider.canLoadObject(ofClass: UIImage.self){
                result.itemProvider.loadObject(ofClass: UIImage.self) { reading, error in
                    if error == nil{
                        if let tempimage = reading as? UIImage{
                            self.image = tempimage
//                            print("it's a image: \(tempimage)\n")
                        }else{
                            return
                        }
                    }
                }
            }
            if result.itemProvider.hasItemConformingToTypeIdentifier("public.movie"){
                result.itemProvider.loadFileRepresentation(forTypeIdentifier: "com.apple.quicktime-movie") { Url, error in
                    if let tempVideoUrl = Url{
                        self.VideoUrl = tempVideoUrl
//                        print("it's a video:\(tempVideoUrl)")
                    }else{
                        return
                    }
                }
                
            }
        }
//                if image == nil{
//        print("it's \(image as Optional)\n")
////                    if VideoUrl == nil{
//        print("it's \(VideoUrl as Optional)\n")
//                    }
//                }

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ARViewController
        destinationVC.LoadImage = image
        destinationVC.LoadVideoUrl = VideoUrl
//        print("it's \(self.image as Optional)\n")
        //                    if VideoUrl == nil{
//        print("it's \(self.VideoUrl as Optional)\n")
//        if destinationVC.Image != nil{
//            print("it's a image\n")
//            if destinationVC.videoUrl != nil{
//                print("it's a video\n")
//            }
//        }
    }
    @IBAction func Confirm(_ sender: UIButton) {
        performSegue(withIdentifier: segue.WelcomeToAR, sender: self)
//        if let vc = storyboard?.instantiateViewController(withIdentifier: "ARViewController") as? ARViewController {
//                  //informs the Juice ViewController that the restaurant is the delegate
//                    vc.delegate = self
//            self.navigationController?.pushViewController(vc, animated: true)
    }
}
//    func GetData(_ image: UIImage?, _ url : URL?) {
//        let image = self.image
//        let url = self.VideoUrl
//    }
//}
