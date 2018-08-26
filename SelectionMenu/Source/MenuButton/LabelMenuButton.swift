//
//  LabelMenuButton.swift
//  SelectionMenu
//
//  Created by Michal Štembera on 16/07/2018.
//  Copyright © 2018 Michal Štembera. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class LabelMenuButton: UIView {
    struct AssociatedKeys {
        static var TapGesture = "LabelMenuButtonTapGesture"
    }

    private var labelMenuButtonGestureRecognizer: UITapGestureRecognizer? {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.TapGesture) as? UITapGestureRecognizer }
        set { objc_setAssociatedObject(self, &AssociatedKeys.TapGesture, newValue, .OBJC_ASSOCIATION_ASSIGN) }
    }

    weak var label: UILabel!

    required init(text: String? = nil) {
        super.init(frame: .zero)

        let label = UILabel(frame: .zero)
        addSubview(label)
        self.label = label

        setupConstrains()

        label.text = text
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Setup
extension LabelMenuButton {
    func setupConstrains() {
        label.snp.remakeConstraints { make in
            make.center.equalToSuperview()
            make.left.top.greaterThanOrEqualToSuperview()
            make.right.bottom.lessThanOrEqualToSuperview()
        }
    }
}

// MARK: - MenuButton
extension LabelMenuButton: MenuButton {
    var tapEnabled: Bool {
        get { return self.labelMenuButtonGestureRecognizer?.isEnabled ?? false }
        set { labelMenuButtonGestureRecognizer?.isEnabled = newValue }
    }

    func addTargetForTapGesture(target: Any?, action: Selector) {
        let tapGestureRecognizer = UITapGestureRecognizer(target: target, action: action)
        addGestureRecognizer(tapGestureRecognizer)
        isUserInteractionEnabled = true
    }

    func expand() {
        label.transform = .identity
    }

    func collapse() {
        label.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
    }
}
