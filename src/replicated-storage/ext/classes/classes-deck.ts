import { T_CardName, T_Card, Classes_Card } from './classes-card'

let createCard = (cardName: T_CardName, deck: T_Deck) => {
    deck.Cards.push(new Classes_Card[cardName]())
}

class Deck {
    Cards: T_Card[] = []
    Play() {
        for (let card of this.Cards) {
            card.Play()
        }
    }
}

export type T_Deck = Deck
export type T_DeckName = keyof typeof Classes_Deck

export namespace Classes_Deck {
    export class RandomizedBossDeck extends Deck {}
    export class Noid extends Deck {
        constructor() {
            super()
            createCard('NoidCard', this)
        }
    }
}
