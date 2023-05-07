import UIKit
import Kingfisher

final class MSettignsProfileCell: BaseTableViewCell {
    static let identifier = "MSettignsProfileCell"
    private let avatarView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    func configure(with person: Person) {
//        avatarView.kf.setImage(with: URL(string: person.profileImageUrl), placeholder: UIImage(named: "avatar"))
        titleLabel.text = person.username
        print(person.profileImageUrl)
        subtitleLabel.text = "Я свободен!"
        FileStorage.downloadImage(person: person) { image in
            if let image {
                self.avatarView.image = image.circleMasked
            } else {
                print("пустой имидж")
            }
        }
    }
}

extension MSettignsProfileCell {
    override func setupViews() {
        setupAvatarView()
        setupTitleLabel()
        setupSubtitleLabel()
    }
    
    private func setupAvatarView() {
        contentView.addSubview(avatarView)
        avatarView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.top.bottom.equalToSuperview().inset(10)
            $0.height.width.equalTo(60)
        }
    }
    
    private func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.font = .avenirMedium(size: 17)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(avatarView.snp.top)
            $0.left.equalTo(avatarView.snp.right).offset(8)
            $0.right.equalToSuperview().inset(8)
        }
    }
    
    private func setupSubtitleLabel() {
        contentView.addSubview(subtitleLabel)
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.font = .avenirBook(size: 17)
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.left.right.equalTo(titleLabel)
        }
    }
}
