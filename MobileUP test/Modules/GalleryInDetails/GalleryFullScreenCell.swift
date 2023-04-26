//
//  GalleryInDetailsCell.swift
//  MobileUP test
//
//  Created by дэвид Кихтенко on 24.04.2023.
//

import UIKit
import SDWebImage

final class GalleryFullScreenCell: UICollectionViewCell, UIScrollViewDelegate {
    
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.sd_imageTransition = .fade
        image.contentMode = .scaleAspectFit
        scrollImg.addSubview(image)
        return image
    }()
    
    private lazy var scrollImg: UIScrollView = {
        let scrollImg = UIScrollView()
        scrollImg.delegate = self
        scrollImg.showsVerticalScrollIndicator = false
        scrollImg.alwaysBounceVertical = false
        scrollImg.alwaysBounceHorizontal = false
        scrollImg.flashScrollIndicators()
        scrollImg.minimumZoomScale = 1.0
        scrollImg.maximumZoomScale = 4.0
        addSubview(scrollImg)
        return scrollImg
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let doubleTapGest = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTapScrollView(recognizer:)))
        doubleTapGest.numberOfTapsRequired = 2
        scrollImg.addGestureRecognizer(doubleTapGest)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        scrollImg.frame = self.bounds
        image.frame = self.bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleDoubleTapScrollView(recognizer: UITapGestureRecognizer) {
        if scrollImg.zoomScale == 1 {
            scrollImg.zoom(to: zoomRectForScale(scale: scrollImg.maximumZoomScale, center: recognizer.location(in: recognizer.view)), animated: true)
        } else {
            scrollImg.setZoomScale(1, animated: true)
        }
    }
    
    private func zoomRectForScale(scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        zoomRect.size.height = image.frame.size.height / scale
        zoomRect.size.width  = image.frame.size.width  / scale
        let newCenter = image.convert(center, from: scrollImg)
        zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2.0)
        return zoomRect
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.image
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        scrollImg.setZoomScale(1, animated: true)
    }
    
    func setup(viewModel: ViewModel) {
        image.sd_setImage(with: .init(string: viewModel.image))
    }
}
