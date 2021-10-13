//
//  DetailsViewController.swift
//  CustomTransitionsAgoraVai
//
//  Created by Leonardo on 11/10/2021.
//

import UIKit

class DetailsViewController: UIViewController {
    
    let detailsImageView = UIImageView()
    var imageName: String!
    let emojiImageViewFinalFrame = CGRect(x: 50, y: 50, width: UIScreen.main.bounds.width - 100 , height: UIScreen.main.bounds.height/3)
    var tempImageView: UIImageView!
    var tempImageInitialFrame: CGRect!
    var interactiveTransition: UIPercentDrivenInteractiveTransition!
    var percentage: CGFloat = 0.0
        
    init(imageName: String) {
        super.init(nibName: nil, bundle: nil)
        self.imageName = imageName
        
        view.backgroundColor = .white
        
        //view.addGestureRecognizer(UIPinchGestureRecognizer(target: self, action: #selector(onPinch(sender:))))
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped)))
    }
    
    @objc func viewTapped() {
        dismiss(animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDetailsImageView()
    }
    
    private func configureDetailsImageView() {
        view.addSubview(detailsImageView)
        detailsImageView.frame = emojiImageViewFinalFrame
        detailsImageView.image = UIImage(systemName: imageName)
        detailsImageView.alpha = 0
    }
    
    @objc func onPinch(sender: UIPinchGestureRecognizer) {
        let scale = sender.scale
        if scale < 1 {
            if (sender.state == .began) {
                dismiss(animated: true)
            } else if (sender.state == .changed) {
                percentage += scale/50
                interactiveTransition.update(percentage)
            } else if sender.state == .ended {
                    interactiveTransition.finish()
            }
        }
    }
}
