//
//  ProfileVC.swift
//  EasyRent
//
//  Created by Hitesh on 2022-10-19.
//

import UIKit

class ProfileVC: UIViewController {
    static let identifier = "ProfileVC"
    
    //MARK: IBOutlets
    @IBOutlet weak var imgUser: DesignableImageView!
    @IBOutlet weak var tfFirstName: UITextField!
    @IBOutlet weak var tfLastName: UITextField!
    
    //MARK: Vars
    var uploadedImageLink:String?
    
    //MARK: View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    //MARK: Fxns
    fileprivate func setupUI(){
        // hide default top navigation bar
        navigationController?.isNavigationBarHidden = true
        getMyInfo()
    }
    
    fileprivate func getMyInfo(){
        guard let myUserId = Utility.getUD(.userId) as? String else {
            return
        }
        Webservices.instance.get(url: API_BASE_URL+ApiEndpoints.getUserById.rawValue+myUserId, params: nil) { success, response, error in
            if success {
                if let dict = response as? NSDictionary {
                    if let profilePic = dict["profilePic"] as? String, let fName = dict["firstName"] as? String, let lName = dict["lastName"] as? String {
                        self.tfFirstName.text = fName
                        self.tfLastName.text = lName
                        self.imgUser.loadImageWithIndicator(profilePic, placeholder: nil)
                    }
                } else {
//                    Utility.showAlert(with: .commonError, on: self)
                }
            } else {
//                Utility.showAlert(with: .commonError, on: self)
            }
        }
    }
    
    fileprivate func getAllUsersAndSaveMyData(_ fName:String,lastName:String){
        Webservices.instance.get(url: API_BASE_URL+ApiEndpoints.getAllUsers.rawValue, params: nil) { success, response, error in
            Utility.hideLoader(from: self)
            if success {
                if let users = response as? NSArray {
                    var allUsersArr = [UserModel]()
                    for i in 0..<users.count {
                        if let user = users[i] as? NSDictionary {
                            let obj = UserModel(_id: user["_id"] as? String ?? "", firstName: user["firstName"] as? String ?? "", lastName: user["lastName"] as? String ?? "", profilePic: user["profilePic"] as? String ?? "", email: user["email"] as? String ?? "", password: user["password"] as? String ?? "")
                            allUsersArr.append(obj)
                        }
                    }
                    // find my user id from result
                    if let myModel = allUsersArr.first(where: {$0.firstName == fName && $0.lastName == lastName}) {
                        print("myModel : \(myModel)")
                        Utility.saveUD(myModel._id, key: .userId)
                        Utility.showAlert(with: .success, on: self)
                    } else {
                        print("my user details not found in db")
                        Utility.showAlert(with: .commonError, on: self)
                    }
                } else {
                    Utility.showAlert(with: .commonError, on: self)
                }
            } else {
                Utility.showAlert(with: .commonError, on: self)
            }
        }
    }
    
    //MARK: IBActions
    @IBAction func editPhotoPressed(_ sender: UIButton) {
        // show options to click a picture right now or choose from gallery
        let alertController = UIAlertController(title: APP_NAME, message: Messages.chooseOption.rawValue, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { cA in
            // open device camera - only works on a real device
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = .camera
            self.present(imagePicker, animated: true, completion: nil)
        }
        alertController.addAction(cameraAction)
        let photoAction = UIAlertAction(title: "Photos", style: .default) { pA in
            // choose from Photos app
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
        alertController.addAction(photoAction)
        // option to cancel if i changed my mind about adding a profile picture
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancel)
        present(alertController, animated: true)
    }
    
    @IBAction func savePressed(_ sender: UIButton) {
        // perform validations
        guard let firstName = tfFirstName.text, let lastName = tfLastName.text else {
            Utility.showAlert(with: .invalidInput, on: self)
            return
        }
        // check if name is valid
        if firstName.isValidName && lastName.isValidName {
            let params = ["firstName":firstName,"lastName":lastName,"profilePic":self.uploadedImageLink ?? "", "email":"","password":""] as [String:Any]
            Utility.showLoader(on: self)
            Webservices.instance.post(url: API_BASE_URL+ApiEndpoints.createUser.rawValue, params: params) { success, response, error in
                if success {
                    // get my uploaded details and then save its id in local storage
                    self.getAllUsersAndSaveMyData(firstName, lastName: lastName)
                } else {
                    Utility.hideLoader(from: self)
                    Utility.showAlert(with: .commonError, on: self)
                }
            }
            
        } else {
            Utility.showAlert(with: .invalidInput, on: self)
        }
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        Navigation.instance.pop(vc: self)
    }
    
}

extension ProfileVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            imgUser.image = image
            // upload on firebase and get url
            Utility.showLoader(on: self)
            FirebaseHandler.uploadImage("/images/", image: image) { uploadedFileLink in
                Utility.hideLoader(from: self)
                self.uploadedImageLink = uploadedFileLink
            }
            picker.dismiss(animated: true, completion: nil)
        }
    }
}
