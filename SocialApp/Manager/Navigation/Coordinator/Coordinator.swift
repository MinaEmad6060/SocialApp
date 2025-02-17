//
//  Coordinator.swift
//  SocialApp
//
//  Created by Mina Emad on 16/02/2025.
//

import UIKit

protocol Coordinator {
    var router: Router { get }
    
    func showLoader()
    func hideLoader()
}

extension Coordinator {
    func showLoader() {
        LoaderManager.shared.shouldShowOverlay = true
        LoaderManager.shared.startLoading()
    }
    
    func hideLoader() {
        LoaderManager.shared.stopLoading()
    }
}
