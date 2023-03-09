//
//  SearchBookCell.swift
//  BookApp
//
//  Created by Julia on 2023/03/07.
//

import UIKit
import Kingfisher

final class SearchBookCell: UITableViewCell {
    
    @IBOutlet private weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var publicationDateLabel: UILabel!
    
    func configure(_ data: SearchBook.FetchBooks.ViewModel.DisplayedBook) {
        self.thumbnailImageView.kf.setImage(with: data.thumbnailURL)
        self.titleLabel.text = data.title
        self.authorLabel.text = data.author
        self.publicationDateLabel.text = data.publishedDate
    }
    
}
