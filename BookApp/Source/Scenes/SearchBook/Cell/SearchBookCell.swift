//
//  SearchBookCell.swift
//  BookApp
//
//  Created by Julia on 2023/03/07.
//

import UIKit
import Kingfisher
import SnapKit

final class SearchBookCell: UITableViewCell {
    
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
    }()

    private let authorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let publicatedDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ data: SearchBook.FetchBooks.ViewModel.DisplayedBook) {
        if !data.thumbnailLink.isEmpty {
            let thumbnailURL = URL(string: data.thumbnailLink)
            self.thumbnailImageView.kf.setImage(with: thumbnailURL)
        }
        self.titleLabel.text = data.title
        self.authorLabel.text = data.author
        self.publicatedDateLabel.text = data.publishedDate
    }
    
    private func setupLayouts() {
        [self.titleLabel, self.authorLabel, self.publicatedDateLabel].forEach { label in
            self.infoStackView.addArrangedSubview(label)
        }
        
        [self.thumbnailImageView, self.infoStackView].forEach { view in
            self.addSubview(view)
        }
        
        self.thumbnailImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().inset(10)
            make.width.equalTo(85)
            make.height.equalTo(100)
        }
        
        self.infoStackView.snp.makeConstraints { make in
            make.top.equalTo(self.thumbnailImageView.snp.top)
            make.leading.equalTo(self.thumbnailImageView.snp.trailing).offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(self.thumbnailImageView.snp.bottom)
        }
    }
    
}
