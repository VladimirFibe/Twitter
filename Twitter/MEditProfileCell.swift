import UIKit

final class MEditProfileCell: BaseTableViewCell {
    static let identifier = "MEditProfileCell"
    private let avatarView = UIImageView()
    private let editButton = UIButton(type: .system)
    private let titleLabel = UILabel()
    
    func configure(with person: Person) {
        avatarView.kf.setImage(with: URL(string: person.profileImageUrl), placeholder: UIImage(named: "avatar"))
    }
}

extension MEditProfileCell {
    override func setupViews() {
        setupAvatarView()
        setupEditButton()
        setupTitleLabel()
    }
    
    private func setupAvatarView() {
        contentView.addSubview(avatarView)
        avatarView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.top.equalToSuperview().inset(10)
            $0.height.width.equalTo(60)
        }
    }
    
    private func setupEditButton() {
        contentView.addSubview(editButton)
        editButton.setTitle("Edit", for: .normal)
        editButton.snp.makeConstraints {
            $0.top.equalTo(avatarView.snp.bottom).offset(10)
            $0.bottom.equalToSuperview().inset(10)
            $0.centerX.equalTo(avatarView.snp.centerX)
        }
    }
    
    private func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.text = "Enter you name and add an optional profile picture"
        titleLabel.numberOfLines = 2
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(avatarView.snp.top)
            $0.left.equalTo(avatarView.snp.right).offset(10)
            $0.right.equalToSuperview().inset(16)
        }
    }
}
