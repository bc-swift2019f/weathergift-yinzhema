//
//  PageVC.swift
//  WeatherGift
//
//  Created by Yinzhe Ma on 10/12/19.
//  Copyright © 2019 Yinzhe Ma. All rights reserved.
//

import UIKit

class PageVC: UIPageViewController {

    var currentPage=0
    var locationsArray=["Local City",
                        "Syndney, Australia",
                        "Accra, Ghana",
                        "Uglich, Russia"
                    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate=self
        dataSource=self
        setViewControllers([createDetailVC(forPage: 0)], direction: .forward, animated: false, completion: nil)
        // Do any additional setup after loading the view.
    }
    
    func createDetailVC(forPage page: Int)->DetailedVC {
        currentPage=min(max(0,page),locationsArray.count-1)
        let detailVC=storyboard!.instantiateViewController(withIdentifier: "DetailedVC") as! DetailedVC
        detailVC.locationsArray=locationsArray
        detailVC.currentPage=currentPage
        return detailVC
    }
    
}


extension PageVC: UIPageViewControllerDataSource,UIPageViewControllerDelegate{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let currentViewController=viewController as? DetailedVC{
            if currentViewController.currentPage>0{
                return createDetailVC(forPage: currentViewController.currentPage-1)
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let currentViewController=viewController as? DetailedVC{
            if currentViewController.currentPage<locationsArray.count-1{
                return createDetailVC(forPage: currentViewController.currentPage+1)
            }
        }
        return nil
    }
}
