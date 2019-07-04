//
//  PlaceCell.swift
//  SampleProject
//
//  Created by orangemac05 on 03/07/19.
//  Copyright © 2019 Saurabh. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class PlaceCell: UITableViewCell {
    
    var placeRow : Rows? {
        didSet {
            guard let title = placeRow?.title else { return }
            guard let description = placeRow?.description else { return }
            
            titleLabel.text = title
            descriptionLabel.text = description
            
            var urlString = placeRow?.imageHref
            urlString = urlString?.replacingOccurrences(of: "\\", with: "")
            if let str = urlString {
                Alamofire.request(str).responseImage { response in
                    if let image = response.result.value {
                        DispatchQueue.main.async {
                            self.placeImageView.image = image
                        }
                    }else {
                        DispatchQueue.main.async {
                            self.placeImageView.image = UIImage.init(named: "Default")
                        }
                    }
                }
            }else {
                if title.count > 0 || description.count > 0 {
                    DispatchQueue.main.async {
                        self.placeImageView.image = UIImage.init(named: "Default")
                    }
                }
            }
        }
    }
    
    
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
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 17)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let placeImageView : UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(placeImageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            placeImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            placeImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            placeImageView.widthAnchor.constraint(equalToConstant: 150),
            placeImageView.heightAnchor.constraint(equalToConstant: 90),
            
            titleLabel.leadingAnchor.constraint(equalTo: placeImageView.trailingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: placeImageView.topAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor
                , constant: -15),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: placeImageView.leadingAnchor, constant: 0),
            descriptionLabel.topAnchor.constraint(equalTo: placeImageView.bottomAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor
                , constant: -15),
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
