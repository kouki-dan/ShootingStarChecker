//
//  ConfigView.swift
//  ShootingStarChecker
//
//  Created by Kouki Saito on 2014/09/05.
//  Copyright (c) 2014年 Kouki. All rights reserved.
//


class ConfigViewController: UIViewController {

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let root = QRootElement()
        root.title = "Hello world"
        root.grouped = true
        
        let section = QSection()
        
        let label = QLabelElement(title: "Hello", value: "World")
        
        section.addElement(label)
        
        root.addSection(section)
        
        
        let navigation = QuickDialogController.controllerWithNavigationForRoot(root)
        
        self.presentViewController(navigation, animated: true, completion: nil)
        
    }
}
