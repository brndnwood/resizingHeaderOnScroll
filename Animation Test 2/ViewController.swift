//
//  ViewController.swift
//  Animation Test 2
//
//  Created by Brandon Wood on 5/10/19.
//  Copyright © 2019 Brandon Wood. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    let headerMaxHeight: CGFloat = 88
    let headerMinHeight: CGFloat = 44
    var previousScrollOffset : CGFloat = 0
    var scrollingUp : Bool = false
    var newHeight : CGFloat = 0
    var hiddenRows : [IndexPath] = []


    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var myTable: UITableView!
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.myTable.dataSource = self
        self.myTable.delegate = self
        
        myTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    
    // MARK: TableView functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Cell \(indexPath.row)"
        cell.isHidden = false

        if hiddenRows.contains(indexPath) {
            cell.isHidden = true
        }

        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var rowHeight : CGFloat = 40
        
        if hiddenRows.contains(indexPath) {
            rowHeight = 0
        }
        
        return rowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        hiddenRows.append(indexPath)
        tableView.reloadRows(at: [indexPath], with: .none)
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if(scrollView.contentOffset.y < previousScrollOffset) {
            scrollingUp = true
        } else {
            scrollingUp = false
        }

        
        
        
        if (scrollView.contentOffset.y < 100.0 && scrollView.contentOffset.y >= 0) {

//            if (!scrollingUp) {
//                self.newHeight = self.headerMaxHeight - abs(scrollView.contentOffset.y)
//            }
//            else {
//                self.newHeight = self.headerMaxHeight - scrollView.contentOffset.y
////                if (self.newHeight > self.headerMaxHeight) {
////                    self.newHeight = self.headerMaxHeight
////                }
//            }
            self.newHeight = self.headerMaxHeight - scrollView.contentOffset.y
            
            if (self.newHeight > self.headerMaxHeight) {
                self.newHeight = self.headerMaxHeight
            } else if (self.newHeight < self.headerMinHeight) {
                self.newHeight = self.headerMinHeight
            }

            
//            let labelAlpha : CGFloat = 1.0 * (self.newHeight / self.headerMaxHeight) + 0.25
            let labelScaleValue = (self.newHeight / self.headerMaxHeight)
            
            self.headerHeightConstraint.constant = self.newHeight
//              self.headerLabel.alpha = labelAlpha
            self.headerLabel.transform = CGAffineTransform(scaleX: labelScaleValue, y: labelScaleValue)
            self.view.layoutIfNeeded()

        }
        
        if (scrollView.contentOffset.y < 0) {
            self.headerHeightConstraint.constant = self.headerMaxHeight
        }
        
        previousScrollOffset = scrollView.contentOffset.y
    }


    
}

