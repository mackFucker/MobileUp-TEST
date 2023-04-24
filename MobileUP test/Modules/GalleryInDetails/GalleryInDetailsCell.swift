//
//  GalleryInDetailsCell.swift
//  MobileUP test
//
//  Created by дэвид Кихтенко on 24.04.2023.
//

import UIKit
import SDWebImage

final class GalleryInDetailsCell: UICollectionViewCell, UIScrollViewDelegate{
    
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        addSubview(image)
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        image.frame = self.bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(viewModel: ViewModel) {
        image.sd_setImage(with: .init(string: viewModel.image))
    }
}
