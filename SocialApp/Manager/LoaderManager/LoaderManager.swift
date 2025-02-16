////
////  LoaderManager.swift
////  SocialApp
////
////  Created by Mina Emad on 16/02/2025.
////
//
//
//import UIKit
//import NVActivityIndicatorView
//
//class LoaderManager {
//    // MARK: - Propertys
//    
//    private let indicator: NVActivityIndicatorView
//    private let backgroundView: UIView
//    private let overlayView: UIView
//    var shouldShowOverlay: Bool = false
//    
//    // MARK: - Singleton
//    static let shared = LoaderManager()
//    
//    private init() {
//        self.backgroundView = UIView(frame: .init(x: 0, y: 0, width: 80, height: 80))
//        self.indicator = NVActivityIndicatorView(frame: .init(x: 0, y: 0, width: 48, height: 48))
//        self.overlayView = UIView(frame: UIScreen.main.bounds)
//        setupBackgroundView()
//        setupIndicator()
//        setupOverlayView()
//    }
//    
//    func startLoading() {
//        guard let window = Window.keyWindow else { return }
//        
//        for subview in window.subviews {
//            if let _ = subview as? NVActivityIndicatorView {
//                subview.removeFromSuperview()
//            } else if subview == backgroundView {
//                subview.removeFromSuperview()
//            }
//        }
//        
//        if shouldShowOverlay {
//            window.addSubview(overlayView)
//        }
//
//        window.addSubview(backgroundView)
//        backgroundView.center = UIScreen.main.bounds.center
//        
//        backgroundView.addSubview(indicator)
//        indicator.center = backgroundView.bounds.center
//        
//        indicator.startAnimating()
//    }
//    
//    func stopLoading() {
//        DispatchQueue.main.async {
//            self.overlayView.removeFromSuperview()
//            self.backgroundView.removeFromSuperview()
//            self.indicator.stopAnimating()
//        }
//    }
//}
//
//// MARK: - Setup
//private extension LoaderManager {
//    func setupIndicator() {
//        indicator.type = .circleStrokeSpin
//        indicator.color = .mainColor
//    }
//    
//    func setupBackgroundView() {
//        backgroundView.backgroundColor = .white
//        backgroundView.layer.cornerRadius = 12
//        backgroundView.layer.masksToBounds = true
//    }
//    
//    func setupOverlayView() {
//        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
//        overlayView.isUserInteractionEnabled = true
//    }
//}
