//
//  ViewController.swift
//  AJMAgenda
//
//  Created by Angel Jesse Morales Karam Kairuz on 24/08/17.
//  Copyright © 2017 TheKairuzBlog. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var scale = CGFloat(1.0)
    var scaleStart : CGFloat = CGFloat(0)

    var days : [String] = {
        var listOfDays : [String] = []
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        for index in 1...5 {
            let day = NSDate(timeIntervalSince1970: TimeInterval((4 * 24 * 60 * 60) + (24 * 60 * 60 * index)))
            listOfDays.append(formatter.string(from: day as Date))
        }
        listOfDays.reverse()
        return listOfDays
    }()
    
    let hours : [String] = {
        var temp = ["9:00", "10:00", "11:00", "12:00", "13:00"]
        return temp.reversed()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let headerNib = UINib(nibName: "CollectionHeader", bundle: nil)
        collectionView.register(headerNib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "DayHeader")
        collectionView.register(headerNib, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "HourHeader")
     
        let pinchGesture = UIPinchGestureRecognizer.init(target: self, action: #selector(ViewController.didReceivePinch(gesture:)))
        collectionView.addGestureRecognizer(pinchGesture)
        if let layout = collectionView.collectionViewLayout as? AgendaLayout {
            layout.delegate = self
        }
    }
    
    func didReceivePinch(gesture : UIPinchGestureRecognizer) {
        
        if (gesture.state == UIGestureRecognizerState.began)
        {
            scaleStart = self.scale
        }
        else if (gesture.state == UIGestureRecognizerState.changed)
        {
            self.scale = scaleStart * gesture.scale
            self.collectionView.collectionViewLayout.invalidateLayout()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
       return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventCell", for: indexPath) as! EventCell
        //cell.title = "Evento"
        cell.backgroundColor = UIColor.red
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.black.cgColor
  
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var view : UICollectionReusableView?
        switch kind {
        case UICollectionElementKindSectionFooter:
            view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "HourHeader", for: indexPath) as! CollectionHeader
            (view as! CollectionHeader).titleLabel.text = hours[indexPath.row]
            (view as! CollectionHeader).backgroundColor = UIColor.yellow
            break;
        default:
           view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "DayHeader", for: indexPath) as! CollectionHeader
           (view as! CollectionHeader).titleLabel.text = days[indexPath.row]
           break;
        }
        
        return view!
    }
    
}

extension ViewController : UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.green
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.clear
    }
    
    
}

extension ViewController : AgendaLayoutDelegate {
    
    func scaleForItem() -> CGFloat {
        print("La escala es \(scale)")
        return scale
    }
}
