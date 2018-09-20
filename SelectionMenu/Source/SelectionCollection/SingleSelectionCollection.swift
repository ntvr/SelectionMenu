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

    public weak var delegate: SelectionCollectionDelegate?

    /// Index of currently selected element. Use `setSelected(index:)` to change it.
    public private(set) var selectedIndex: Int = 0

    public var elementStyle: SelectionElementStyling = UniversalStyle.blackWhite {
        didSet { updateTheme() }
    }

    // Subviews
    /// Background view which can be used for corner radius to not not mess up shadows.
    public private(set) weak var backgroundView: UIView!

    /// View that is placed behind currently selected element.
    public private(set) weak var markView: UIView!

    /// Contained elements.
    public private(set) var elements: [SelectionElementView]

    // Private properties
    private weak var markViewOriginalConstraint: Constraint?
    private weak var markViewMovingConstraint: Constraint?

    /// Initializes SingleSelectionCollection
    ///
    /// - Parameter elements: Elements that should be contained in SingleSelectionCollection.
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
    public func expand(animated: Bool) {
        elements.forEach { $0.expand(animated: animated) }
    }

    public func collapse(animated: Bool) {
        elements.forEach { $0.collapse(animated: animated) }
    }
}

// MARK: - Stylable
extension SingleSelectionCollection {
    public var foregroundColorStylable: UIColor? {
        get { return nil }
        set { return }
    }

    public var backgroundColorStylable: UIColor? {
        get { return backgroundView.backgroundColor }
        set { backgroundView.backgroundColor = newValue }
    }

    public var circularStylable: Bool {
        get { return backgroundView.circular }
        set { backgroundView.circular = newValue }
    }

    public var shadowedLayerStylable: CALayer? {
        return layer
    }
}

// MARK: - External API
extension SingleSelectionCollection {
    /// Changes the currently selected index.
    /// - If the index is not within allowed interval then does nothing.
    public func setSelected(index: Int) {
        guard 0..<elements.count ~= index else {
            return
        }
        selectedIndex = index
        moveMark(to: index)
    }

    public func setSelected(indexes: [Int]) {
        let index = indexes.first ?? selectedIndex
        setSelected(index: index)
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
