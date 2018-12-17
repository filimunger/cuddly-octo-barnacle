import { T_CardName, T_Card, Classes_Card } from './classes-card'
import { T_Character } from './classes'

let createCard = (cardName: T_CardName, deck: T_Deck) => {
    deck.Cards.push(new Classes_Card[cardName]())
}

class Deck {
    Character: T_Character
    Cards: T_Card[] = []
    Play() {
        for (let card of this.Cards) {
            card.Play(this.Character.Model.GetPrimaryPartCFrame())
        }
    }
    constructor(character: T_Character) {
        this.Character = character
    }
}

export type T_Deck = Deck
export type T_DeckName = keyof typeof Classes_Deck

export namespace Classes_Deck {
    export class RandomizedBossDeck extends Deck {}
    export class Noid extends Deck {
        constructor(character: T_Character) {
            super(character)
            createCard('NoidCard', this)
        }
    }
}
