//
//  ViewController.swift
//  Autolayout
//
//  Created by liubin on 15/6/26.
//  Copyright (c) 2015年 liubin. All rights reserved.
//

import UIKit

class AutolayoutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    
    private var aspectRatioConstraint: NSLayoutConstraint? {
        willSet {
            if let c = aspectRatioConstraint {
                view.removeConstraint(c)
            }
        }
        didSet {
            if let c = aspectRatioConstraint {
                view.addConstraint(c)
            }
        }
    }
    
    private var image: UIImage? {
        get {
            return imageView?.image
        }
        set {
            imageView?.image = newValue
            if let constraintView = imageView {
                if let newImage = newValue {
                    aspectRatioConstraint = NSLayoutConstraint(
                        item: constraintView,
                        attribute: .Width,
                        relatedBy: .Equal,
                        toItem: constraintView,
                        attribute: .Height,
                        multiplier: newImage.aspectRatio,
                        constant: 0)
                } else {
                    aspectRatioConstraint = nil
                }
            }
        }
    }
    
    var loginUser: User? {
        didSet {
            updateUI()
        }
    }
    
    private var secure: Bool = false {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        println("login user: \(loginUser?.login) \(loginUser?.company)")
        passwordLabel?.text = secure ? "Secure Password" : "Password"
        password?.secureTextEntry = secure
        nameLabel?.text = loginUser?.name
        companyLabel?.text = loginUser?.company
        image = loginUser?.image
    }
    
    @IBAction func toggleSecure() {
        secure = !secure
    }
    
    @IBAction func login() {
        loginUser = User.login(username?.text ?? "", password: password?.text ?? "")
    }
}

extension User {
    var image: UIImage? {
        return UIImage(named: login) ?? UIImage(named: "unknown_user")
    }
}

extension UIImage {
    var aspectRatio: CGFloat {
        return size.height != 0 ? size.width / size.height : 0
    }
}

