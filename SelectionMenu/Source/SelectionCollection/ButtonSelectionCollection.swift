//
//  ButtonSelectionCollection.swift
//  SelectionMenu
//
//  Created by Michal Štembera on 06/08/2018.
//  Copyright © 2018 Michal Štembera. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ButtonSelectionCollection
class ButtonSelectionCollection: UIControl, SelectionCollection {
    var elements: [SelectionElementView]!
    var backgroundView: UIView!

    weak var delegate: SelectionCollectionDelegate?

    var collectionStyle: SelectionCollectionStyling = UniversalStyle.blackWhite {
        didSet { updateTheme() }
    }
    var elementStyle: SelectionElementStyling = UniversalStyle.blackWhite {
        didSet { updateTheme() }
    }

    private var initiallyTouchedElement: SelectionElementView?

    required init(elements: [SelectionElementView]) {
        super.init(frame: .zero)

        initSubviews(with: elements)
        setupConstrains()
        updateTheme()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup + Theme
extension ButtonSelectionCollection {
    func initSubviews(with elements: [SelectionElementView]) {
        let backgroundView = UIView()
        addSubview(backgroundView)
        self.backgroundView = backgroundView

        elements.forEach { element in
            addSubview(element)
        }
        self.elements = elements
    }

    func updatedHighlighted(to index: Int?) {
        let index = index ?? -1

        elements.enumerated().forEach { offset, element in
            elementStyle.apply(to: element, selected: offset == index)
        }
    }

    func updateTheme() {
        collectionStyle.apply(to: self)

        updatedHighlighted(to: nil)
    }

    func setupConstrains() {
        var leftEdge = snp.left
        elements.forEach { element in
            element.snp.remakeConstraints { make in
                make.top.bottom.equalToSuperview()
                make.width.equalTo(element.snp.height)
                make.left.equalTo(leftEdge)

                leftEdge = element.snp.right
            }
        }
        elements.last?.snp.makeConstraints { make in
            make.right.equalToSuperview()
        }

        backgroundView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - Expandable
extension ButtonSelectionCollection {
    func expand() {
        elements.forEach { $0.expand() }
    }

    func collapse() {
        elements.forEach { $0.collapse() }
    }
}

// MARK: Tracking touches
extension ButtonSelectionCollection {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touched = touchedElement(for: touches, with: event)
        updatedHighlighted(to: touched?.offset)
        initiallyTouchedElement = touched?.element
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touched = touchedElement(for: touches, with: event)
        if let touched = touched,
            let initiallyTouchedElement = initiallyTouchedElement,
            touched.element == initiallyTouchedElement {
                updatedHighlighted(to: touched.offset)
        } else {
            updatedHighlighted(to: nil)
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let hitView = self.touchedElement(for: touches, with: event),
            let initiallyTouchedElement = initiallyTouchedElement,
            hitView.element == initiallyTouchedElement {
                delegate?.buttonSelectionCollection(self, didTapIndex: hitView.offset)
        }

        elements.forEach { elementStyle.apply(to: $0, selected: false) }
        initiallyTouchedElement = nil
    }

    func touchedElement(for touches: Set<UITouch>,
                        with event: UIEvent?) -> (offset: Int, element: SelectionElementView)? {
        guard let touch = touches.first else {
            return nil
        }

        let hitViews = elements.enumerated().filter { _, element -> Bool in
            let location = touch.location(in: element)
            return element.point(inside: location, with: event)
        }

        return hitViews.first
    }
}
