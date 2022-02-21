//
//  Utilities.swift
//  Twitter
//
//  Created by Vladimir Fibe on 21.02.2022.
//

import UIKit

class Utilities {
  func inputContainerView(systemName: String, textField: UITextField) -> UIView {
    let view = UIView()
    let padding = 8.0
    view.heightAnchor.constraint(equalToConstant: 50).isActive = true
    
    let imageView = UIImageView(image: UIImage(systemName: systemName))
    imageView.tintColor = .white
    view.addSubview(imageView)
    imageView.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop: padding, paddingLeft: padding, width: 24, height: 24)
    view.addSubview(textField)
    textField.anchor(top: view.topAnchor, left: imageView.rightAnchor, right: view.rightAnchor, paddingTop: padding, paddingLeft: padding, paddingRight: padding)
    
    let divider = UIView()
    divider.backgroundColor = .white
    view.addSubview(divider)
    divider.anchor(top: textField.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: padding, paddingLeft: padding, paddingRight: padding, height: 0.75)
    return view
  }
  
  func textField(placeholder: String) -> UITextField {
    let textField = UITextField()
    textField.textColor = .white
    textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    return textField
  }
  
  static let shared = Utilities()
}
