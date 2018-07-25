//
//  ControlAnimesDelelgate.swift
//  CollectionViewTesting
//
//  Created by Lucas Tavares on 25/07/2018.
//  Copyright © 2018 Lucas Tavares. All rights reserved.
//

import Foundation

protocol ControlAnimesDelegate {
    func favoritarAnime(at indexPath: IndexPath)
    func deletarAnime(at indexPath: IndexPath)
}
