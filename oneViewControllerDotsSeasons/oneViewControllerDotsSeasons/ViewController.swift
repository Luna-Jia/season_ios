import UIKit



class ViewController: UIViewController, UIScrollViewDelegate {

    private let scrollView = UIScrollView()

    

    private let pageControl: UIPageControl = {

        let pageControl = UIPageControl()

        pageControl.numberOfPages = 4

        pageControl.backgroundColor = UIColor.black

        return pageControl

    }()

    

    override func viewDidLoad() {

        super.viewDidLoad()

        // Do any additional setup after loading the view.

        pageControl.addTarget(self, action: #selector(pageControlDidChange(_:)), for: .valueChanged)

        scrollView.backgroundColor = .white

        view.addSubview(scrollView)

        view.addSubview(pageControl)

        scrollView.delegate = self

        scrollView.isPagingEnabled = true

    }

    

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        let width = scrollView.frame.size.width

        let currentPage = Int(scrollView.contentOffset.x / width)

        pageControl.currentPage = currentPage

    }

    

    @objc private func pageControlDidChange(_ sender: UIPageControl) {

        let current = sender.currentPage

        scrollView.setContentOffset(CGPoint(x: CGFloat(current) * view.frame.size.width, y: 0), animated: true)

    }

    

    override func viewDidLayoutSubviews() {

        super.viewDidLayoutSubviews()

        pageControl.frame = CGRect(x: 0, y: view.frame.size.height - 60, width: view.frame.size.width, height: 60)

        

        scrollView.frame = CGRect(x: 0, y: 70, width: view.frame.size.width, height: view.frame.size.height - 70)

        if scrollView.subviews.count == 2 {

            configureScrollView()

        }

    }

    

    private func configureScrollView() {

        scrollView.contentSize = CGSize(width: view.frame.size.width * 4, height: scrollView.frame.size.height)

        

        let imageNames = ["Spring", "Summer", "Fall", "Winter"]

        

        for (index, imageName) in imageNames.enumerated() {

            if let image = UIImage(named: imageName) {

                let page = UIView(frame: CGRect(x: CGFloat(index) * view.frame.size.width, y: 0, width: view.frame.size.width, height: scrollView.frame.size.height))

                

                let imageView = UIImageView(frame: page.bounds)

                imageView.contentMode = .scaleAspectFill

                imageView.clipsToBounds = true

                imageView.image = image

                

                imageView.frame = CGRect(x: 0, y: 0, width: page.frame.width - 0, height:

                                                            page.frame.height - 60)

                

                page.addSubview(imageView)

                scrollView.addSubview(page)

            } else {

                print("Failed to load image named \(imageName) from the asset catalog.")

            }

        }

    }

}

