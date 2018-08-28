//
//  StaticDataSource.swift
//  SelectionMenu
//
//  Created by Michal Štembera on 16/07/2018.
//  Copyright © 2018 Michal Štembera. All rights reserved.
//

import Foundation
import UIKit

public class StaticMenuDataSource {
    public enum Value {
        case image(UIImage)
        case text(String)
    }
    public typealias ContentType<T> = [SectionType<T>]
    public typealias SectionType<T> = (type: SelectionMenu.SectionType, values: [T])

    public var visualEffect: UIVisualEffect? = UIBlurEffect(style: .light)

    // Private properties
    private let sections: ContentType<Value>

    public init(sections: ContentType<Value>) {
        self.sections = sections
    }

    public convenience init(sections: SectionType<Value>...) {
        self.init(sections: sections)
    }

    public convenience init(textSections: SectionType<String>...) {
        let sections: ContentType<Value> = textSections.map { section in
            return (section.type, section.values.map { .text($0) })
        }

        self.init(sections: sections)
    }

    public convenience init(imageSections: SectionType<UIImage>...) {
        let sections: ContentType<Value> = imageSections.map { section in
            return (section.type, section.values.map { .image($0) })
        }

        self.init(sections: sections)
    }
}

// MARK: - SelectionMenuDataSource
extension StaticMenuDataSource: SelectionMenuDataSource {
    public func selectionMenu(typeOf section: Int) -> SelectionMenu.SectionType {
        return sections[section].type
    }

    public func selectionMenuNumberOfSections() -> Int {
        return sections.count
    }

    public func selectionMenu(numberOfElementsIn section: Int) -> Int {
        return sections[section].values.count
    }

    public func selectionMenu(viewFor index: Int, in section: Int) -> SelectionElementView {
        switch sections[section].values[index] {
        case let .text(title):
            return LabelSelectionElement(text: title)
        case let .image(image):
            let imageView = UIImageView(image: image.withRenderingMode(.alwaysTemplate))
            imageView.contentMode = .scaleAspectFit
            return imageView
        }
    }
}
