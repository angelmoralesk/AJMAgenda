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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let headerNib = UINib(nibName: "DayHeader", bundle: nil)
        collectionView.register(headerNib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "DayHeader")
        collectionView.register(headerNib, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "HourHeader")
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
            view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "DayHeader", for: indexPath) as! DayHeader
            (view as! DayHeader).titleLabel.text = days[indexPath.row]
            break;
        default:
           view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "DayHeader", for: indexPath) as! DayHeader
           (view as! DayHeader).titleLabel.text = days[indexPath.row]
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
