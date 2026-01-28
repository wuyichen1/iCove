//
//  Route.swift
//  iCove
//
//  Created by yangyang on 2026/1/16.
//

import Foundation

enum PubtypeixL8MqcCr6wZE: String, Hashable {
  case vdoSddWQll1w6vvS = "video"
  case imgHkANxe83jDb0E = "imagePost"
}

enum Route: Hashable {
  case homeQMOFX4gLvyU3x
  case vdodetfheedD4mgJl4V(vidROutctPY4KAW9: String)
  case podeti0Gx1PwxsKGxM(postId: String)
  case chadetBhKPSi5YgfcOZ(cid7EWVIP6LCiVby: String, uidKePZA2dVjXZzF: String)
  case videoCall(conversationId: String, otherUserId: String)
  case profibW16jiY12DMmv(uidmhh7e21b987RS: String, showBackicon: Bool)
  case settings
  case editProfile
  case blacklist
  case wallet
  case ai
  case publish(type: PubtypeixL8MqcCr6wZE)
  case report(userId: String)
  case agreement(url: String, title: String)
}
