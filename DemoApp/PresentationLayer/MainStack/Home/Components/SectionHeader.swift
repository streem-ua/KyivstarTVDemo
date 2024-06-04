//
//  SectionHeader.swift
//  DemoApp
//
//  Created by Karpenko Bohdan on 02.06.2024.
//

import UIKit

final class SectionHeader: UICollectionReusableView {
    static let identifier = "SectionHeader"
    
    //MARK: - Properties
    
    var didTapDel: EmptyClosure?
    
    private let titleLabel = UILabel(font: Font.regular.font(size: 16), textColor: .black, textAlignment: .left, numberOfLines: 1)
    private lazy var delButton = UIButton(titleFont: Font.regular.font(size: 16), titleTextColor: .systemBlue, target: self, action: #selector(delAction(_ :)))
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        attachTitleLabel()
        attachDelButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configure
    
    func configure(type: Home.Section) {
        titleLabel.text = type.title
    }
    
    private func attachTitleLabel() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.centerY.leading.equalToSuperview()
        }
    }
    
    private func attachDelButton() {
        addSubview(delButton)
        delButton.snp.makeConstraints {
            $0.centerY.trailing.equalToSuperview()
        }
    }
    
    //MARK: - Actions
    
    @objc func delAction(_ sender: UIButton) {
        didTapDel?()
    }
}
