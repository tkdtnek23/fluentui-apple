//
//  Copyright © 2018 Microsoft Corporation. All rights reserved.
//

class MSPopupMenuSectionHeaderView: UITableViewHeaderFooterView {
    private struct Constants {
        static let padding = UIEdgeInsets(top: 14, left: 16, bottom: 0, right: 16)
        static let titleFontStyle: MSTextStyle = .subhead
    }

    static let identifier: String = "MSPopupMenuSectionHeaderView"

    static func isHeaderVisible(for section: MSPopupMenuSection) -> Bool {
        return section.title != nil
    }

    static func preferredWidth(for section: MSPopupMenuSection) -> CGFloat {
        guard isHeaderVisible(for: section), let title = section.title else {
            return 0
        }

        let labelFont = Constants.titleFontStyle.font
        let labelSize = title.boundingRect(
            with: CGSize(width: .greatestFiniteMagnitude, height: labelFont.deviceLineHeight),
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: [.font: labelFont],
            context: nil
        )

        return Constants.padding.left + labelSize.width + Constants.padding.right
    }

    static func preferredHeight(for section: MSPopupMenuSection) -> CGFloat {
        if isHeaderVisible(for: section) {
            return Constants.padding.top + Constants.titleFontStyle.font.deviceLineHeight + Constants.padding.bottom
        } else {
            return 0
        }
    }

    private let label: UILabel = {
        let label = UILabel()
        label.font = Constants.titleFontStyle.font
        label.textColor = MSColors.PopupMenu.sectionHeader
        return label
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        backgroundView = view

        contentView.addSubview(label)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(section: MSPopupMenuSection) {
        label.text = section.title
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let labelSize = label.sizeThatFits(bounds.size)
        label.frame = CGRect(origin: CGPoint(x: Constants.padding.left, y: Constants.padding.top), size: labelSize)
    }
}
