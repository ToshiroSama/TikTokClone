//
//  ViewController.swift
//  TikTokClone
//
//  Created by Alisher Djuraev on 14/06/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    let horizontalScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
   let control: UISegmentedControl = {
       let titles = ["Following", "For You"]
       let control = UISegmentedControl(items: titles)
       control.selectedSegmentIndex = 1
       control.backgroundColor = nil
       control.selectedSegmentTintColor = .white
       let titleTextAttributesWhite = [NSAttributedString.Key.foregroundColor: UIColor.white]
       control.setTitleTextAttributes(titleTextAttributesWhite, for: .normal)
       let titletextAttriburesBlack = [NSAttributedString.Key.foregroundColor: UIColor.black]
       control.setTitleTextAttributes(titletextAttriburesBlack, for: .selected)
       return control
    }()
    
    let followingPageViewController = UIPageViewController(
        transitionStyle: .scroll,
        navigationOrientation: .vertical,
        options: [:]
    )
    
    let forYouPageViewController = UIPageViewController(
        transitionStyle: .scroll,
        navigationOrientation: .vertical,
        options: [:]
    )
    
    private var followingPosts = PostModel.mockModels()
    private var forYouPosts = PostModel.mockModels()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(horizontalScrollView)
        setupFeed()
        horizontalScrollView.delegate = self
        horizontalScrollView.contentOffset = CGPoint(x: view.width, y: 0)
        setUpHeaderButtons()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        horizontalScrollView.frame = view.bounds
    }
    
    func setUpHeaderButtons() {
        control.addTarget(self, action: #selector(didChangeSegmentControl(_:)), for: .valueChanged)
        navigationItem.titleView = control
    }
    
    @objc private func didChangeSegmentControl(_ sender: UISegmentedControl) {
        horizontalScrollView.setContentOffset(CGPoint(
                                                      x: view.width * CGFloat(sender.selectedSegmentIndex),
                                                      y: 0),
                                                      animated: true)
    }
    
    private func setupFeed() {
        horizontalScrollView.contentSize = CGSize(width: view.width * 2, height: view.height)
        setUpFollowingFeed()
        setUpForYouFeed()
    }
    
    func setUpFollowingFeed() {
        guard let model = followingPosts.first else {
            return
        }
        
        followingPageViewController.setViewControllers(
            [PostViewController(model: model)],
            direction: .forward,
            animated: false,
            completion: nil
        )
        followingPageViewController.dataSource = self
        
        horizontalScrollView.addSubview(followingPageViewController.view)
        followingPageViewController.view.frame = CGRect(x: 0,
                                             y: 0,
                                             width: horizontalScrollView.width,
                                             height: horizontalScrollView.height)
        addChild(followingPageViewController)
        followingPageViewController.didMove(toParent: self)
    }
    
    func setUpForYouFeed() {
        guard let model = forYouPosts.first else {
            return
        }
        
        forYouPageViewController.setViewControllers(
            [PostViewController(model: model)],
            direction: .forward,
            animated: false,
            completion: nil
        )
        forYouPageViewController.dataSource = self
        
        horizontalScrollView.addSubview(forYouPageViewController.view)
        forYouPageViewController.view.frame = CGRect(x: view.width,
                                             y: 0,
                                             width: horizontalScrollView.width,
                                             height: horizontalScrollView.height)
        addChild(forYouPageViewController)
        forYouPageViewController.didMove(toParent: self)
    }
}


// MARK: - Extensions

extension HomeViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let fromPost = (viewController as? PostViewController)?.model else {
            return nil
        }
        
        guard let index = currentPosts.firstIndex(where: {
            $0.identifier == fromPost.identifier
        }) else {
            return nil
        }

        if index == 0 {
            return nil
        }
        
        let priorIndex = index - 1
        let model = currentPosts[priorIndex]
        let vc = PostViewController(model: model)
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let fromPost = (viewController as? PostViewController)?.model else {
            return nil
        }
        
        guard let index = currentPosts.firstIndex(where: {
            $0.identifier == fromPost.identifier
        }) else {
            return nil
        }

        guard index < (currentPosts.count - 1) else {
            return nil
        }
        
        let nextIndex = index + 1
        let model = currentPosts[nextIndex]
        let vc = PostViewController(model: model)
        return vc
    }
    
    var currentPosts: [PostModel] {
        if horizontalScrollView.contentOffset.x == 0 {
            // Following
            return followingPosts
        }
        
        // For You
        return forYouPosts
    }
}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x == 0 || scrollView.contentOffset.x <= (view.width / 2){
            control.selectedSegmentIndex = 0
        } else if scrollView.contentOffset.x > (view.width / 2){
            control.selectedSegmentIndex = 1
        }
    }
}
