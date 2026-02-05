//
//  KinescopeVideo.swift
//  KinescopeSDK
//
//  Created by Никита Коробейников on 23.03.2021.
//

public struct KinescopeVideo: Codable {
    public let id: String
    public let workspaceId: String?
    public let projectId: String
    public let folderId: String?
    public let type: KinescopeStreamType?
    public let title: String
    public let description: String
    public let status: String?
    public let progress: Int?
    public let duration: Double
    public let qualityMap: [KinescopeVideoAsset]?
    public let chapters: KinescopeVideoChapter
    public let poster: KinescopeVideoPoster?
    public let attachments: [KinescopeVideoAdditionalMaterial]?
    public let subtitles: [KinescopeVideoSubtitle]?
    public let hlsLink: String
    public let dashLink: String?
    public let live: KinescopeStreamMeta?
    public let analytic: KinescopeAnalyticEndpoints?
    public let drm: KinescopeDRMData?

    enum CodingKeys: String, CodingKey {
        case id
        case workspaceId
        case projectId
        case folderId
        case type
        case title
        case description
        case status
        case progress
        case duration
        case qualityMap
        case chapters
        case poster
        case attachments
        case subtitles
        case hlsLink
        case dashLink
        case live
        case analytic = "sdk"
        case drm
    }
}

// MARK: - Offline stub for native fullscreen

public extension KinescopeVideo {
    /// Минимальные метаданные для офлайн-воспроизведения
    static func offlineStub(id: String, title: String = "Offline") -> KinescopeVideo {
        KinescopeVideo(
            id: id,
            workspaceId: nil,
            projectId: "",
            folderId: nil,
            type: .vod,
            title: title,
            description: "",
            status: nil,
            progress: nil,
            duration: 0,
            qualityMap: nil,
            chapters: KinescopeVideoChapter(items: nil),
            poster: nil,
            attachments: nil,
            subtitles: nil,
            hlsLink: "",
            dashLink: nil,
            live: nil,
            analytic: nil,
            drm: nil
        )
    }
}
