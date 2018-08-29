//
//  SingleSelectionCollection.swift
//  SelectionMenu
//
//  Created by Michal Štembera on 10/07/2018.
//  Copyright © 2018 NETVOR s.r.o. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

// MARK: - SingleChoiceView
public class SingleSelectionCollection: UIControl, SelectionCollection {
    // Public properties
    public weak var delegate: SelectionCollectionDelegate?
    public private(set) var selectedIndex: Int = 0
    public var highlightColor: UIColor?
    public var collectionStyle: SelectionCollectionStyling = UniversalStyle.blackWhite {
        didSet { updateTheme() }
    }
    public var elementStyle: SelectionElementStyling = UniversalStyle.blackWhite {
        didSet { updateTheme() }
    }

    // Subviews
    public private(set) weak var backgroundView: UIView!
    public private(set) weak var markView: UIView!
    public private(set) var elements: [SelectionElementView]

    // Private properties
    private weak var markViewOriginalConstraint: Constraint?
    private weak var markViewMovingConstraint: Constraint?

    public required init(elements: [SelectionElementView]) {
        self.elements = elements
        super.init(frame: .zero)

        initSubviews(with: elements)
        updateTheme()
        setupConstrains()
        moveMark(to: selectedIndex)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Expandable
extension SingleSelectionCollection {
    public func expand() {
        elements.forEach { $0.expand() }
    }

    public func collapse() {
        elements.forEach { $0.collapse() }
    }
}

// MARK: - External API
extension SingleSelectionCollection {
    public func setSelected(index: Int) {
        let allowedIndex = max(min(elements.count - 1, index), 0)
        selectedIndex = allowedIndex
        moveMark(to: allowedIndex)
    }
}

// MARK: - Setup + Update
private extension SingleSelectionCollection {
    func initSubviews(with elements: [SelectionElementView]) {
        let backgroundView = UIView()
        addSubview(backgroundView)
        self.backgroundView = backgroundView

        let markView = UIView()
        addSubview(markView)
        self.markView = markView

        elements.forEach { element in
            addSubview(element)
        }
    }

    func updateTheme() {
        collectionStyle.apply(to: self)

        markView.backgroundColor = highlightColor

        elements.enumerated().forEach { offset, element in
            elementStyle.apply(to: element, selected: offset == selectedIndex)
        }
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

        markView.snp.remakeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.9)
            make.width.equalTo(markView.snp.height)
            make.centerY.equalToSuperview()
        }

        backgroundView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - Postitioning mark view
private extension SingleSelectionCollection {
    func moveMark(to selectedIndex: Int) {
        guard 0..<elements.count ~= selectedIndex  else {
            return
        }

        let centerToView: UIView = elements[selectedIndex]

        markViewOriginalConstraint?.deactivate()
        markViewMovingConstraint?.deactivate()
        markViewMovingConstraint = nil

        markView.snp.makeConstraints { make in
            markViewOriginalConstraint = make.centerX.equalTo(centerToView).constraint
        }
    }

    func moveMark(with touch: UITouch) {
        markViewOriginalConstraint?.deactivate()

        let leastX = self.convert(elements.first?.center ?? .zero, from: self).x
        let mostX = self.convert(elements.last?.center ?? .zero, from: self).x
        let newLocation = (leastX...mostX).clamp(touch.location(in: self).x)

        markViewMovingConstraint?.deactivate()
        markView.snp.makeConstraints { make in
            markViewMovingConstraint = make.centerX.equalTo(newLocation).constraint
        }
    }

    func returnMarkToOriginal() {
        markViewMovingConstraint?.deactivate()
        markViewMovingConstraint = nil

        markViewOriginalConstraint?.activate()
    }
}

// MARK: - Tracking touches
extension SingleSelectionCollection {
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }

        moveMark(with: touch)
    }

    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }

        moveMark(with: touch)
    }

    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }

        // Calculate closest
        let touchLocation = touch.location(in: self)
        let closestIndex = elements
            .enumerated()
            .map { index, view -> (CGFloat, Int) in
                let center = view.center
                let xDistance = abs(center.x - touchLocation.x)
                return (xDistance, index)
            }.sorted { $0.0 < $1.0 }
            .first?.1 ?? 0

        selectedIndex = closestIndex
        moveMark(to: closestIndex)
        updateTheme()
        delegate?.singleSelectionCollection(self,
                                            didSelect: elements[closestIndex],
                                            at: selectedIndex)
    }

    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        returnMarkToOriginal()
    }
}