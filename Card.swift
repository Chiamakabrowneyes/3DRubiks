import SwiftUI

//
//  TripCard.swift
//  ParallaxCarousel
//
//  Created by Balaji on 12/08/23.
//

import SwiftUI

/// Trip Card Model
struct Card: Identifiable {
    let id = UUID()
    let image: String
}

var secondLayerOne: [Card] = [
    .init(image: "secondLayerOne (9)"),
    .init(image: "secondLayerOne (1)"),
    .init(image: "secondLayerOne (2)"),
    .init(image: "secondLayerOne (3)"),
    .init(image: "secondLayerOne (4)"),
    .init(image: "secondLayerOne (5)"),
    .init(image: "secondLayerOne (6)"),
    .init(image: "secondLayerOne (7)"),
    .init(image: "secondLayerOne (8)")
]

var secondLayerTwo: [Card] = [
    .init(image: "secondLayerTwo (8)"),
    .init(image: "secondLayerTwo (1)"),
    .init(image: "secondLayerTwo (2)"),
    .init(image: "secondLayerTwo (3)"),
    .init(image: "secondLayerTwo (4)"),
    .init(image: "secondLayerTwo (5)"),
    .init(image: "secondLayerTwo (6)"),
    .init(image: "secondLayerTwo (7)")
]

var LShape3Layer: [Card] = [
    .init(image: "LShape3Layer (6)"),
    .init(image: "LShape3Layer"),
    .init(image: "LShape3Layer (1)"),
    .init(image: "LShape3Layer (2)"),
    .init(image: "LShape3Layer (3)"),
    .init(image: "LShape3Layer (4)"),
    .init(image: "LShape3Layer (5)")
]


var FlatShape3Layer: [Card] = [
    .init(image: "FlatShape3Layer (6)"),
    .init(image: "FlatShape3Layer"),
    .init(image: "FlatShape3Layer (1)"),
    .init(image: "FlatShape3Layer (2)"),
    .init(image: "FlatShape3Layer (3)"),
    .init(image: "FlatShape3Layer (4)"),
    .init(image: "FlatShape3Layer (5)")
]



var CrossShape1: [Card] = [
    .init(image: "CrossShape1 (7)"),
    .init(image: "CrossShape1"),
    .init(image: "Untitled"),
    .init(image: "CrossShape1 (2)"),
    .init(image: "Untitled (1)"),
    .init(image: "CrossShape1 (4)"),
    .init(image: "Untitled"),
    .init(image: "CrossShape1 (6)")
]

var CrossShape2: [Card] = [
    .init(image: "CrossShape2 (9)"),
    .init(image: "CrossShape2 (2)"),
    .init(image: "CrossShape2 (3)"),
    .init(image: "CrossShape2 (4)"),
    .init(image: "CrossShape2 (5)"),
    .init(image: "CrossShape2 (6)"),
    .init(image: "CrossShape2 (7)"),
    .init(image: "CrossShape2 (8)")
]

var KnobShape1: [Card] = [
    .init(image: "KnobShape1 (2)"),
    .init(image: "KnobShape1 (3)"),
    .init(image: "KnobShape1 (4)"),
    .init(image: "KnobShape1 (5)"),
    .init(image: "KnobShape1 (6)"),
    .init(image: "KnobShape1 (7)"),
    .init(image: "KnobShape1 (8)")
]

var KnobShape2: [Card] = [
    .init(image: "KnobShape2 (2)"),
    .init(image: "KnobShape2 (3)"),
    .init(image: "KnobShape2 (4)"),
    .init(image: "KnobShape2 (5)"),
    .init(image: "KnobShape2 (6)"),
    .init(image: "KnobShape2 (7)"),
    .init(image: "KnobShape2 (8)")
]

var AdjacentCross1: [Card] = [
    .init(image: "AdjacentCross1 (10)"),
    .init(image: "AdjacentCross1 (2)"),
    .init(image: "AdjacentCross1 (3)"),
    .init(image: "AdjacentCross1 (4)"),
    .init(image: "AdjacentCross1 (5)"),
    .init(image: "AdjacentCross1 (6)"),
    .init(image: "AdjacentCross1 (7)"),
    .init(image: "AdjacentCross1 (8)"),
    .init(image: "AdjacentCross1 (9)")
]


var AdjacentCross2: [Card] = [
    .init(image: "AdjacentCross2 (2)"),
    .init(image: "AdjacentCross2 (3)"),
    .init(image: "AdjacentCross2 (4)"),
    .init(image: "AdjacentCross2 (5)"),
    .init(image: "AdjacentCross2 (6)"),
    .init(image: "AdjacentCross2 (7)"),
    .init(image: "AdjacentCross2 (8)")
]


var SnakeShape1: [Card] = [
    .init(image: "SnakeShape1 (2)"),
    .init(image: "SnakeShape1 (3)"),
    .init(image: "SnakeShape1 (4)"),
    .init(image: "SnakeShape1 (5)"),
    .init(image: "SnakeShape1 (6)"),
    .init(image: "SnakeShape1 (7)"),
    .init(image: "SnakeShape1 (8)"),
    .init(image: "SnakeShape1 (9)"),
    .init(image: "SnakeShape1 (10)")
]

var LastMove: [Card] = [
    .init(image: "LastMove (11)"),
    .init(image: "LastMove (2)"),
    .init(image: "LastMove (3)"),
    .init(image: "LastMove (4)"),
    .init(image: "LastMove (5)"),
    .init(image: "LastMove (6)"),
    .init(image: "LastMove (7)"),
    .init(image: "LastMove (8)"),
    .init(image: "LastMove (9)"),
    .init(image: "LastMove (10)")
]

var LastMove2: [Card] = [
    .init(image: "LastMove2 (2)"),
    .init(image: "LastMove2 (3)"),
    .init(image: "LastMove2 (4)"),
    .init(image: "LastMove2 (5)"),
    .init(image: "LastMove2 (6)"),
    .init(image: "LastMove2 (7)"),
    .init(image: "LastMove2 (8)"),
    .init(image: "LastMove2 (9)"),
    .init(image: "LastMove2 (10)"),
    .init(image: "LastMove2 (11)")
]
