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
    var pageControl: UIPageControl!
    var barButtonWidth: CGFloat = 44
    var barButtonHeight: CGFloat = 44
    var listButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate=self
        dataSource=self
        setViewControllers([createDetailVC(forPage: 0)], direction: .forward, animated: false, completion: nil)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        configurePageControl()
        configureListButton()
    }
    
    //MARK:- UI configureation methods
    func configurePageControl(){
        let pageControlHeight: CGFloat=barButtonHeight
        let pageControlWidth: CGFloat=view.frame.width-(barButtonWidth*2)
        let safeHeight=view.frame.height-view.safeAreaInsets.bottom
        pageControl=UIPageControl(frame: CGRect(x: (view.frame.width-pageControlWidth)/2, y: safeHeight-pageControlHeight, width: pageControlWidth, height: pageControlHeight))
        pageControl.pageIndicatorTintColor=UIColor.lightGray
        pageControl.currentPageIndicatorTintColor=UIColor.black
        pageControl.numberOfPages=locationsArray.count
        pageControl.currentPage=currentPage
        view.addSubview(pageControl)
    }
    
    func configureListButton(){
        let safeHeight=view.frame.height-view.safeAreaInsets.bottom
        listButton=UIButton(frame: CGRect(x: view.frame.width-barButtonWidth, y: safeHeight-barButtonHeight, width: barButtonWidth, height: barButtonHeight))
        listButton.setImage(UIImage(named: "listbutton"), for: .normal)
        listButton.setImage(UIImage(named: "listbutton-highlighted"), for: .highlighted)
        listButton.addTarget(self, action: #selector(segueTLocationVC), for: .touchUpInside)
        view.addSubview(listButton)
    }
    
    @objc func segueTLocationVC(){
        print("Hey, its me!")
    }
    
    //MARK:- Create View Controller for UIPageVIewController
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
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let currentViewController=pageViewController.viewControllers?[0] as? DetailedVC{
            pageControl.currentPage=currentViewController.currentPage
        }
    }
}
