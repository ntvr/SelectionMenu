//
//  LabelSelectionElement.swift
//  SelectionMenu
//
//  Created by Michal Štembera on 06/08/2018.
//  Copyright © 2018 Michal Štembera. All rights reserved.
//

import Foundation
import UIKit

class LabelSelectionElement: UIView {
    var fgColor: UIColor? {
        get { return label.textColor }
        set { label.textColor = newValue }
    }

    var bgColor: UIColor? {
        get { return backgroundColor }
        set { backgroundColor = newValue }
    }

    weak var label: UILabel!

    init(text: String?) {
        super.init(frame: .zero)

        let label = UILabel()
        addSubview(label)
        self.label = label

        setupConstraints()

        label.text = text
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup
extension LabelSelectionElement {
    func setupConstraints() {
        label.snp.remakeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

// MARK: - SelectionElement
extension LabelSelectionElement: SelectionElement {
    func expand() {
        transform = .identity
    }

    func collapse() {
        transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
    }
}
