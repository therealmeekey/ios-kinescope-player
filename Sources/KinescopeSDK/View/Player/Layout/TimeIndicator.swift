//
//  TimeIndicator.swift
//  KinescopeSDK
//
//  Created by Никита Коробейников on 31.03.2021.
//

import UIKit

protocol TimeIndicatorInput {

    /// Update time value
    ///
    /// - parameter time: Positive time interval describes current moment in video
    func setIndicator(to time: TimeInterval)
}

class TimeIndicatorView: UIView {

    private let label = UILabel()

    private let config: KinescopePlayerTimeindicatorConfiguration

    init(config: KinescopePlayerTimeindicatorConfiguration) {
        self.config = config
        super.init(frame: .zero)
        setupInitialState(with: config)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        let label = UILabel()
        label.font = monospacedFont()
        label.text = getText(from: 3600 * 24)
        label.sizeToFit()
        return .init(width: label.frame.size.width, height: label.font.lineHeight)
    }

}

// MARK: - TimeIndicatorInput

extension TimeIndicatorView: TimeIndicatorInput {

    func setIndicator(to time: TimeInterval) {
        label.text = getText(from: time)
    }

}

// MARK: - Private

private extension TimeIndicatorView {

    func setupInitialState(with config: KinescopePlayerTimeindicatorConfiguration) {
        backgroundColor = .clear
        configureLabel()
    }

    func configureLabel() {
        label.textColor = config.color
        label.font = monospacedFont()
        label.textAlignment = .right

        addSubview(label)
        stretch(view: label)

        label.text = getText(from: 0)
    }

    func getText(from time: TimeInterval) -> String {
        let duration = KinescopeVideoDuration.from(raw: time)
        let totalSeconds = Int(time)
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
        
        switch duration {
        case .inTenMinute:
            // "m:ss" - минуты:секунды (для < 10 минут)
            return String(format: "%d:%02d", minutes, seconds)
        case .inHour:
            // "mm:ss" - минуты:секунды (для 10 минут - 1 час)
            return String(format: "%02d:%02d", minutes, seconds)
        case .inTenHours:
            // "H:mm:ss" - часы:минуты:секунды (для 1-10 часов)
            return String(format: "%d:%02d:%02d", hours, minutes, seconds)
        case .inDay:
            // "HH:mm:ss" - часы:минуты:секунды (для > 10 часов)
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        }
    }

    func monospacedFont() -> UIFont {
        let fontFeatures = [
            [
                UIFontDescriptor.FeatureKey.featureIdentifier: kNumberSpacingType,
                UIFontDescriptor.FeatureKey.typeIdentifier: kMonospacedNumbersSelector
            ]
        ]
        let descriptorWithFeatures = UIFont.systemFont(ofSize: config.fontSize)
            .fontDescriptor
            .addingAttributes([UIFontDescriptor.AttributeName.featureSettings: fontFeatures])
        return UIFont(descriptor: descriptorWithFeatures, size: config.fontSize)
    }

}
