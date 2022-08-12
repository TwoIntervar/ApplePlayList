//
//  PreviewMyPlayListCollectionViewCell.swift
//  Mapli
//
//  Created by 김상현 on 2022/08/11.
//

import UIKit

class PreviewMyPlayListCollectionViewCell: UICollectionViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var titleLabelLeadingConstraints: NSLayoutConstraint!
    
    var selectedTemplate: Template? = nil
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setUI(_ titleText: String) {
        guard let selectedTemplate = selectedTemplate else { return }
        switch selectedTemplate {
        case .templates1:
            self.titleLabel.textColor = .darkGray
        case .templates2:
            self.titleLabelLeadingConstraints.constant = self.contentView.frame.width * 0.1
            self.titleLabel.textColor = .black
        case .templates3:
            self.titleLabel.textColor = .white

        case .templates4:
            self.titleLabel.font = .font(size: 20, font: .ChosunCentennial)
            self.titleLabel.textColor = .white

        case .templates5:
            self.titleLabel.textColor = .black

        }
        DispatchQueue.main.async {
            self.titleLabel.text = titleText
        }
    }
}
