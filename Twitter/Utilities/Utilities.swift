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
    imageView.anchor(top: view.topAnchor, left: view.leftAnchor, width: 24, height: 24)
    view.addSubview(textField)
    textField.anchor(top: view.topAnchor, left: imageView.rightAnchor, right: view.rightAnchor, paddingLeft: padding)
    
    let divider = UIView()
    divider.backgroundColor = .white
    view.addSubview(divider)
    divider.anchor(top: textField.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: padding, height: 0.75)
    return view
  }
  
  func textField(placeholder: String) -> UITextField {
    let textField = UITextField()
    textField.textColor = .white
    textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    return textField
  }
  
  func attibutedButton(_ firstPart: String, _ secondPart: String) -> UIButton {
    let button = UIButton(type: .system)
    let attributedTitle = NSMutableAttributedString(string: firstPart, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSMutableAttributedString.Key.foregroundColor: UIColor.white])
    attributedTitle.append(NSAttributedString(string: secondPart, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white]))
    button.setAttributedTitle(attributedTitle, for: .normal)
    return button
  }
  
  func loginButton(_ title: String) -> UIButton {
    let button = UIButton(type: .system)
    button.setTitle(title, for: .normal)
    button.setTitleColor(.twitterBlue, for: .normal)
    button.titleLabel?.font = .boldSystemFont(ofSize: 20)
    button.backgroundColor = .white
    button.layer.cornerRadius = 10
    button.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
    return button
  }
  static let shared = Utilities()
}
