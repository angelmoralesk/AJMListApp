//
//  CircularEuropeVisualizerViewController.swift
//  AJMListApp
//
//  Created by Angel Jesse Morales Karam Kairuz on 07/09/17.
//  Copyright © 2017 TheKairuzBlog. All rights reserved.
//

import UIKit

class CircularEuropeVisualizerViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var names = ["berlin-cathedral","brandenburg-gate","colosseum", "eiffel", "notre-dame", "venice"]
    var places : [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        names = names.map { $0.appending(".jpg") }
        collectionView.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_2))
    }
}

extension CircularEuropeVisualizerViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CountryCell
        let name = "\(names[indexPath.row])"
        cell.imageView.image = UIImage(named: name)
        cell.imageView.contentMode = .scaleAspectFit
        cell.imageView.transform =  CGAffineTransform(rotationAngle: CGFloat(-M_PI/2))
        return cell
    }
    
}

