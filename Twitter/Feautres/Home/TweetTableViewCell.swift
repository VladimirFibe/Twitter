import UIKit

final class TweetTableViewCell: UITableViewCell {

    static let identifier = "TweetTableViewCell"
    private let avatarImageView = UIImageView()
    private let displayNameLabel = UILabel()
    private let usernameLabel = UILabel()
    private let tweetTextContentLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TweetTableViewCell {
    private func setupViews() {
        setupAvatarImageView()
        setupDisplayNameLabel()
        setupUsernameLabel()
        setupTweetTextContentLabel()
    }
    
    private func setupAvatarImageView() {
        contentView.addSubview(avatarImageView)
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.image = UIImage(resource: .avatar)
        avatarImageView.contentMode = .scaleAspectFill
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalToSystemSpacingBelow: contentView.topAnchor, multiplier: 1),
            avatarImageView.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 1),
            avatarImageView.widthAnchor.constraint(equalToConstant: 50),
            avatarImageView.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func setupDisplayNameLabel() {
        contentView.addSubview(displayNameLabel)
        displayNameLabel.translatesAutoresizingMaskIntoConstraints = false
        displayNameLabel.text = "Vladimir Fibe"
        displayNameLabel.font = .systemFont(ofSize: 18, weight: .bold)
        NSLayoutConstraint.activate([
            displayNameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            displayNameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: avatarImageView.trailingAnchor, multiplier: 1)
        ])
    }
    
    private func setupUsernameLabel() {
        contentView.addSubview(usernameLabel)
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.text = "@macuser"
        usernameLabel.textColor = .secondaryLabel
        usernameLabel.font = .systemFont(ofSize: 16)
        NSLayoutConstraint.activate([
            usernameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: displayNameLabel.trailingAnchor, multiplier: 1),
            usernameLabel.centerYAnchor.constraint(equalTo: displayNameLabel.centerYAnchor)
        ])
    }
    
    private func setupTweetTextContentLabel() {
        contentView.addSubview(tweetTextContentLabel)
        tweetTextContentLabel.translatesAutoresizingMaskIntoConstraints = false
        tweetTextContentLabel.text = "Супербыстрые чипы M1 Pro и M1 Max дают феноменальную производительность и обеспечивают удивительно долгое время работы без подзарядки. Прибавьте к этому потрясающий дисплей Liquid Retina XDR и ещё больше портов для профессиональной работы. Это тот самый ноутбук, который вы так ждали."
        tweetTextContentLabel.numberOfLines = 0
        NSLayoutConstraint.activate([
            tweetTextContentLabel.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
            tweetTextContentLabel.topAnchor.constraint(equalToSystemSpacingBelow: displayNameLabel.bottomAnchor, multiplier: 1),
            contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: tweetTextContentLabel.trailingAnchor, multiplier: 1),
            contentView.bottomAnchor.constraint(equalToSystemSpacingBelow: tweetTextContentLabel.bottomAnchor, multiplier: 1)
        ])
    }
}
