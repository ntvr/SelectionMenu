//
//  StaticDataSource.swift
//  SelectionMenu
//
//  Created by Michal Štembera on 16/07/2018.
//  Copyright © 2018 Michal Štembera. All rights reserved.
//

import Foundation
import UIKit

class StaticMenuDataSource {
    enum Value {
        case image(UIImage)
        case text(String)
    }

    typealias ContentType<T> = [SectionType<T>]
    typealias SectionType<T> = (type: SelectionMenu.SectionType, values: [T])
    private let sections: ContentType<Value>

    var visualEffect: UIVisualEffect? = UIBlurEffect(style: .light)

    init(sections: ContentType<Value>) {
        self.sections = sections
    }

    convenience init(sections: SectionType<Value>...) {
        self.init(sections: sections)
    }

    convenience init(textSections: SectionType<String>...) {
        let sections: ContentType<Value> = textSections.map { section in
            return (section.type, section.values.map { .text($0) })
        }

        self.init(sections: sections)
    }

    convenience init(imageSections: SectionType<UIImage>...) {
        let sections: ContentType<Value> = imageSections.map { section in
            return (section.type, section.values.map { .image($0) })
        }

        self.init(sections: sections)
    }
}

// MARK: - SelectionMenuDataSource
extension StaticMenuDataSource: SelectionMenuDataSource {
    func selectionMenu(typeOf section: Int) -> SelectionMenu.SectionType {
        return sections[section].type
    }

    func selectionMenuNumberOfSections() -> Int {
        return sections.count
    }

    func selectionMenu(numberOfElementsIn section: Int) -> Int {
        return sections[section].values.count
    }

    func selectionMenu(viewFor index: Int, in section: Int) -> SelectionElementView {
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
