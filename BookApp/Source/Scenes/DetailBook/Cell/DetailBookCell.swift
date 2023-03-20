//
//  DetailBookCell.swift
//  BookApp
//
//  Created by Julia on 2023/03/13.
//

import UIKit
import Kingfisher
import SnapKit

final class DetailBookCell: UITableViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ title: String, _ info: String?) {
        self.titleLabel.text = title
        self.infoLabel.text = info
    }
    
    private func setupLayouts() {
        [self.titleLabel, self.infoLabel].forEach { label in
            self.addSubview(label)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(60)
            make.centerY.equalToSuperview()
        }
        
        self.infoLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.titleLabel.snp.trailing).offset(20)
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }

}
