//
//  ViewController.swift
//  SwiftMarathon6
//
//  Created by Anton Charny on 16/03/2023.
//

import UIKit

class ViewController: UIViewController {
    
    var squareView: UIView!
    
    var animator: UIDynamicAnimator!
    
    var collision: UICollisionBehavior!
    var snap: UISnapBehavior!
    
    var dynamicProperties: UIDynamicItemBehavior!
    
    lazy var colors: [UIColor] = [.red, .blue, .green, .magenta, .black, .cyan, .orange, .purple]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.view.addGestureRecognizer(tapRecognizer)
        
        squareView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        squareView.backgroundColor = UIColor.blue
        squareView.layer.cornerRadius = 16
        view.addSubview(squareView)
        
        animator = UIDynamicAnimator(referenceView: view)
        
        collision = UICollisionBehavior(items: [squareView])
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        self.snap = .init(item: squareView, snapTo: squareView.center)
        self.animator.addBehavior(self.snap)
        
        // Do any additional setup after loading the view.
        
        self.dynamicProperties = UIDynamicItemBehavior(items: [self.squareView])
        self.dynamicProperties.elasticity = 1
        self.dynamicProperties.friction = 0.5
        self.dynamicProperties.allowsRotation = true
//        self.dynamicProperties.resistance = 0.5
        self.dynamicProperties.charge = 1
        self.animator.addBehavior(self.dynamicProperties)
    }
    
    @IBAction func handleTap(sender: UITapGestureRecognizer) {
        
        let tapPoint: CGPoint = sender.location(in: view)
        
        if (snap != nil) {
            animator.removeBehavior(snap)
        }
        
        let newColor: UIColor? = self.colors.randomElement()
        let newCornerRadius: CGFloat = self.squareView.layer.cornerRadius == 16 ? 50 : 16
        
        snap = UISnapBehavior(item: squareView, snapTo: tapPoint)
        snap.action = {
            self.squareView.backgroundColor = newColor ?? .blue
            self.squareView.layer.cornerRadius = newCornerRadius
        }
        snap.damping = 0.5
        animator.addBehavior(snap)
    }
}
