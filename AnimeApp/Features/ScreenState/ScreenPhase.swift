//
//  ScreenPhase.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import Foundation

enum ScreenPhase<Value> {
    case idle
    case loading
    case loaded(Value)
    case failed(String)
}
