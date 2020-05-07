//
//  FileManager+AppGroupExtension.swift
//  MuseuZap
//
//  Created by Bernardo Silva on 03/05/20.
//  Copyright © 2020 Bernardo. All rights reserved.
//

import Foundation

public extension FileManager {
  static func sharedContainerURL() -> URL {
    return FileManager.default.containerURL(
      forSecurityApplicationGroupIdentifier: "group.museuGroup"
    )!
  }
}
