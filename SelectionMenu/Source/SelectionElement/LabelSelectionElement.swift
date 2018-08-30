//
//  LabelSelectionElement.swift
//  SelectionMenu
//
//  Created by Michal Štembera on 06/08/2018.
//  Copyright © 2018 Michal Štembera. All rights reserved.
//

import Foundation
import UIKit

/// Text only view which can be used with SelectionMenu as SelectionCollection.
open class LabelSelectionElement: UIView {

    /// Label for text values centered within the view.
    public weak var label: UILabel!

    /// Initializes LabelSelectionElement
    ///
    /// - Parameter text: Text for the contained label.
    public init(text: String?) {
        super.init(frame: .zero)

        let label = UILabel()
        addSubview(label)
        self.label = label

        setupConstraints()

        label.text = text
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SelectionElement
extension LabelSelectionElement: SelectionElement {
    public func expand() {
        transform = .identity
    }

    public func collapse() {
        transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
    }
}

// MARK: - Setup
private extension LabelSelectionElement {
    func setupConstraints() {
        label.snp.remakeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
