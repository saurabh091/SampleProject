//
//  PlaceCell.swift
//  SampleProject
//
//  Created by Saurabh on 03/07/19.
//  Copyright © 2019 Saurabh. All rights reserved.
//

import UIKit

class PlaceCell: UITableViewCell {
    
    /*
     NOTE: Stack Views can be used here, but for now i choose this approach right now. I mainly used stackView and autolayout side by side.
     */
    
    let titleLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let descriptionLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .gray
        lbl.font = UIFont.systemFont(ofSize: 17)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let placeImageView : UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.layer.masksToBounds = true
        imgView.clipsToBounds = true
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.image = UIImage.init(named: PlaceHolder_Image)
        return imgView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(placeImageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            placeImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            placeImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            placeImageView.widthAnchor.constraint(equalToConstant: 150),
            placeImageView.heightAnchor.constraint(equalToConstant: 90),
            
            titleLabel.leadingAnchor.constraint(equalTo: placeImageView.trailingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: placeImageView.topAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor
                , constant: -20),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: placeImageView.leadingAnchor, constant: 0),
            descriptionLabel.topAnchor.constraint(equalTo: placeImageView.bottomAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor
                , constant: -20),
            descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
