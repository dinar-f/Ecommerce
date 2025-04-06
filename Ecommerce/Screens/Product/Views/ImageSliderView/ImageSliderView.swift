//
//  ImageSliderView.swift
//  Ecommerce
//
//  Created by Dinar on 31.03.2025.
//

import UIKit


final class ImageSliderView: UIView {
    
    private var imagesList:[URL] = []
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsHorizontalScrollIndicator = false
        view.isPagingEnabled = true
        return view
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = R.Colors.white
        pageControl.pageIndicatorTintColor = R.Colors.white.withAlphaComponent(0.3)
        pageControl.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
        return pageControl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        addSubviews()
        setupLayout()
        setDelegates()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImages(_ images: [URL]) {
        self.imagesList = images
        pageControl.numberOfPages = images.count
        collectionView.reloadData()
    }
}

private extension ImageSliderView {
    
    func configureView() {
        backgroundColor = .red
    }
    
    func addSubviews() {
        addSubview(collectionView)
        addSubview(pageControl)
        collectionView.register(
            ImageCell.self,
            forCellWithReuseIdentifier: ImageCell.id)
    }
    
    func setDelegates() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func setupLayout() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            pageControl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor)
            
        ])
    }
}

//MARK: - UICollectionViewDataSource
extension ImageSliderView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imagesList.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.id, for: indexPath) as? ImageCell else { return UICollectionViewCell() }
        
        cell.configure(with: imagesList[indexPath.item])
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension ImageSliderView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

//MARK: - UIScrollViewDelegate
extension ImageSliderView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.frame.width > 0 else { return }
        let pageIndex = round(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}
