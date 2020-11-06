//
//  ComplicationController.swift
//  WristEmojis WatchKit Extension
//
//  Created by Michael Schoder on 22.10.20.
//

import ClockKit


class ComplicationController: NSObject, CLKComplicationDataSource {
    var dataProvider: DataProvider { AppDataProvider() }
    
    // MARK: Complication Configuration

    func getComplicationDescriptors(handler: @escaping ([CLKComplicationDescriptor]) -> Void) {
        var descriptors = [CLKComplicationDescriptor]()

        for configuration in self.dataProvider.userData.configurations {
            descriptors.append(
                CLKComplicationDescriptor(
                    identifier: "\(configuration.id)_\(Date().timeIntervalSince1970)",
                    displayName: configuration.name,
                    supportedFamilies: [.modularSmall, .modularLarge, .utilitarianSmall, .utilitarianSmallFlat, .utilitarianLarge, .circularSmall, .extraLarge, .graphicCircular, .graphicCorner],
                    userInfo: ["id": configuration.id]
                )
            )
        }

        // Call the handler with the currently supported complication descriptors
        handler(descriptors)
    }
    
    func handleSharedComplicationDescriptors(_ complicationDescriptors: [CLKComplicationDescriptor]) {
        // Do any necessary work to support these newly shared complication descriptors
    }

    // MARK: Timeline Configuration
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        // Call the handler with your desired behavior when the device is locked
        handler(.showOnLockScreen)
    }

    // MARK: Timeline Population
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        guard let id = complication.userInfo?["id"] as? String,
              let emoji = self.dataProvider.userData.configurations.first(where: { $0.id == id })?.emoji,
              let template = self.template(for: complication.family, emoji: emoji) else {
            handler(nil)
            return
        }
        handler(CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template))
    }

    // MARK: Sample Templates
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        guard let id = complication.userInfo?["id"] as? String,
              let emoji = self.dataProvider.userData.configurations.first(where: { $0.id == id })?.emoji else {
            handler(nil)
            return
        }
        handler(self.template(for: complication.family, emoji: emoji))
    }

    // MARK: Helper Methods

    private func template(for family: CLKComplicationFamily, emoji: String) -> CLKComplicationTemplate? {
        switch family {
        case .modularSmall:
            return CLKComplicationTemplateModularSmallSimpleText(textProvider: CLKTextProvider(format: emoji))
        case .modularLarge:
            return CLKComplicationTemplateModularLargeTallBody(headerTextProvider: CLKTextProvider(format: ""), bodyTextProvider: CLKTextProvider(format: emoji))
        case .utilitarianSmall:
            return CLKComplicationTemplateUtilitarianSmallFlat(textProvider: CLKTextProvider(format: emoji))
        case .utilitarianSmallFlat:
            return CLKComplicationTemplateUtilitarianSmallFlat(textProvider: CLKTextProvider(format: emoji))
        case .utilitarianLarge:
            return CLKComplicationTemplateUtilitarianLargeFlat(textProvider: CLKTextProvider(format: emoji))
        case .circularSmall:
            return CLKComplicationTemplateCircularSmallSimpleText(textProvider: CLKTextProvider(format: emoji))
        case .extraLarge:
            return CLKComplicationTemplateExtraLargeSimpleText(textProvider: CLKTextProvider(format: emoji))
        case .graphicCircular:
            guard let image = emoji.image(size: CGSize(width: 47, height: 47)) else {
                return nil
            }
            return CLKComplicationTemplateGraphicCircularImage(imageProvider: CLKFullColorImageProvider(fullColorImage: image))
        case .graphicCorner:
            guard let image = emoji.image(size: CGSize(width: 36, height: 36)) else {
                return nil
            }
            return CLKComplicationTemplateGraphicCornerCircularImage(imageProvider: CLKFullColorImageProvider(fullColorImage: image))
        case .graphicBezel, .graphicRectangular, .graphicExtraLarge:
            return nil
        @unknown default:
            return nil
        }
    }
}

private extension String {

    func image(size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, true, 2.0)

        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.center

        (self as NSString).draw(
            in: CGRect(origin: CGPoint(x: 0, y: size.height / 5), size: size),
            withAttributes: [
                .font: UIFont.systemFont(ofSize: size.height / 2.0),
                .paragraphStyle: style
            ]
        )
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

}
