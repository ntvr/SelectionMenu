//
//  ViewController.swift
//  SelectionMenu
//
//  Created by stemberamichal on 08/26/2018.
//  Copyright (c) 2018 stemberamichal. All rights reserved.
//

import UIKit
import SnapKit
import SelectionMenu

class ViewController: UIViewController {

    var menuDataSource: SelectionMenuDataSource?
    weak var stackView: UIStackView!
    weak var menu: SelectionMenu!

    override func loadView() {
        super.loadView()

        view.backgroundColor = OrangeAccent.woodVeener

        let views = (0...4).map { _ in return UIView(frame: .zero) }
        views.forEach { view in
            view.layer.cornerRadius = 10
            view.backgroundColor = OrangeAccent.charcoal
        }
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        view.addSubview(stackView)
        self.stackView = stackView

        let expandableMenu = SelectionMenu.orangeAccent
        view.addSubview(expandableMenu)
        self.menu = expandableMenu

        let dataSource = StaticMenuDataSource(textSections:
            (type: .singleSelection(selected: 0), values: ["A", "B", "C"]),
            (type: .multiSelection(selected: [0, 1]), values: ["0", "1", "2"]),
            (type: .buttonSelection, values: ["I", "II"])
        )
        dataSource.visualEffect = UIBlurEffect(style: .dark)
        self.menuDataSource = dataSource

        menu.dataSource = menuDataSource

        menu.delegate = self

        setupConstraints()
    }

    func setupConstraints() {
        menu.snp.remakeConstraints { make in
            make.right.bottom.equalTo(view.layoutMarginsGuide)
            make.size.equalTo(66)
        }

        stackView.snp_remakeConstraints { make in
            make.left.top.right.equalTo(view.layoutMarginsGuide).inset(10)
            make.bottom.equalToSuperview().offset(20)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - SelectionMenuDelegate
extension ViewController: SelectionMenuDelegate {
    func selectionMenu(_ menu: SelectionMenu, willHide animated: Bool) { }

    func selectionMenu(_ menu: SelectionMenu, willShow animated: Bool) { }

    func selectionMenu(_ menu: SelectionMenu, didSelectSingleIndex index: Int, in section: Int) {
        print("Single selection at index: \(index) in section: \(section)")
    }

    func selectionMenu(_ menu: SelectionMenu, didSelectMultipleIndexes indexes: [Int], in section: Int) {
        print("Multi selection of indexes: \(indexes) in section: \(section)")
    }

    func selectionMenu(_ menu: SelectionMenu, didSelectButtonAt index: Int, in section: Int) {
        print("Button at index: \(index) in section: \(section)")
    }
}
