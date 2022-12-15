//
//  VC.swift
//  SampleRxSwift
//
//  Created by 秋山悠 on 2022/12/14.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class VC: UIViewController {
    
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var adressField: UITextField!
    @IBOutlet weak var adressLabel: UILabel!
    
    
    private let maxNameSize = 10
    private let maxAddresSize = 50
    
    let limitText: (Int) -> String = {
        return "あと\($0)文字"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.addTarget(self, action: #selector(nameFieldEditingChanged(sender:)), for: .editingChanged)
        
        adressField.addTarget(self, action: #selector(adressFieldEditingChaged(sender:)), for: .editingChanged)
    }
    
    @objc func nameFieldEditingChanged(sender: UITextField) {
        guard let changedText = sender.text else { return }
        let limitCount = maxNameSize - changedText.count
        nameLabel.text = limitText(limitCount)
    }
    
    @objc func adressFieldEditingChaged(sender: UITextField) {
        guard let changedText = sender.text else { return }
        let limitCount = maxAddresSize - changedText.count
        adressLabel.text = limitText(limitCount)
    }
}
