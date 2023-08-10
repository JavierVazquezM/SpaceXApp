//
//  Launch.swift
//  SpaceXAppDemo
//
//  Created by Javier Vazquez on 09/08/23.
//

import Foundation

struct Launch: Codable {
    let missionName: String
    let launchDateUTC: String
    let rocket: Rocket
    let launchSite: LaunchSite
    let links: Links
    let details: String?
    
    enum CodingKeys: String, CodingKey {
        case missionName = "mission_name"
        case launchDateUTC = "launch_date_utc"
        case rocket, links, details
        case launchSite = "launch_site"
    }
}

struct Links: Codable {
    let missionPatch, missionPatchSmall: String?
    let redditCampaign: String?
    let redditLaunch: String?
    let redditRecovery, redditMedia: String?
    let presskit: String?
    let articleLink: String?
    let wikipedia: String?
    let videoLink: String
    let youtubeID: String
    let flickrImages: [String]
    
    enum CodingKeys: String, CodingKey {
        case missionPatch = "mission_patch"
        case missionPatchSmall = "mission_patch_small"
        case redditCampaign = "reddit_campaign"
        case redditLaunch = "reddit_launch"
        case redditRecovery = "reddit_recovery"
        case redditMedia = "reddit_media"
        case presskit
        case articleLink = "article_link"
        case wikipedia
        case videoLink = "video_link"
        case youtubeID = "youtube_id"
        case flickrImages = "flickr_images"
    }
}

struct LaunchSite: Codable {
    let siteID: String
    let siteName: String
    let siteNameLong: String
    
    enum CodingKeys: String, CodingKey {
        case siteID = "site_id"
        case siteName = "site_name"
        case siteNameLong = "site_name_long"
    }
}

struct Rocket: Codable {
    let rocketID: String?
    let rocketName: String?
    let rocketType: String?
    
    enum CodingKeys: String, CodingKey {
        case rocketID = "rocket_id"
        case rocketName = "rocket_name"
        case rocketType = "rocket_type"
    }
}
