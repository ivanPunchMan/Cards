//
//  BoardGameController.swift
//  Cards
//
//  Created by Admin on 06.01.2022.
//

import UIKit

class BoardGameController: UIViewController {

    var cardsPairsCount = 7
    
    lazy var game: Game = getNewGame()
    
    private func getNewGame() -> Game {
        let game = Game()
        game.countCards = cardsPairsCount
        game.generateCards()
        return game
    }
    
    lazy var startButtonView = getStartButtonView()
    
    func getStartButtonView() -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        button.center.x = view.center.x
        let window = UIApplication.shared.windows[0]
        let topPadding = window.safeAreaInsets.top
        button.frame.origin.y = topPadding
        button.setTitle("Начать игру", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.backgroundColor = .systemGray4
        button.layer.cornerRadius = 10
        button.addTarget(nil, action: #selector(startGame(_:)), for: .touchUpInside)
        return button
    }
        
    @objc func startGame(_ sender: UIButton) {
//        print("asdsads")
        game = getNewGame()
        let cards = getCardsBy(modelData: game.cards)
        placeCardsOnBoard(cards)
        boardGameView.setNeedsDisplay()
        print("\(boardGameView)")
    }
    
    lazy var boardGameView = getBoardGameView()
    
    func getBoardGameView() -> UIView {
        let margin: CGFloat = 10
        let boardView = UIView()
        
        boardView.frame.origin.x = margin
        
        let window = UIApplication.shared.windows[0]
        let topPadding = window.safeAreaInsets.top
        boardView.frame.origin.y = topPadding + startButtonView.frame.height + margin
        
        boardView.frame.size.width = UIScreen.main.bounds.width - margin * 2
        
        let buttomPadding = window.safeAreaInsets.bottom
        boardView.frame.size.height = UIScreen.main.bounds.height - boardView.frame.origin.y - buttomPadding - margin
        
        boardView.layer.cornerRadius = 5
        boardView.backgroundColor = UIColor(red: 0.1, green: 0.9, blue: 0.1, alpha: 0.3)
        
        return boardView
    }
    
    private var flippedCards = [UIView]()
    
    private func getCardsBy(modelData: [Card]) -> [UIView] {
        var cardViews = [UIView]()
        
        let cardViewFactory = CardViewFactory()
        
        for (index, modelCard) in modelData.enumerated() {
            let cardOne = cardViewFactory.get(modelCard.type, withSize: cardSize, andColor: modelCard.color)
            cardOne.tag = index
            cardViews.append(cardOne)
            
            let cardTwo = cardViewFactory.get(modelCard.type, withSize: cardSize, andColor: modelCard.color)
            cardTwo.tag = index
            cardViews.append(cardTwo)
//            print("getCards")
            
            for card in cardViews {
                (card as! FlippableView).flipCompletionHandler = { [self] flippedCard in
                    flippedCard.superview?.bringSubviewToFront(flippedCard)
                    
                    if flippedCard.isFlipped {
                        self.flippedCards.append(flippedCard)
                    } else {
                        if let cardIndex = self.flippedCards.firstIndex(of: flippedCard) {
                            self.flippedCards.remove(at: cardIndex)
                        }
                    }
                    
                    if self.flippedCards.count == 2 {
                        let firstCard = game.cards[self.flippedCards.first!.tag]
                        print("\(firstCard)")
                        let secondCard = game.cards[self.flippedCards.last!.tag]
                        print("\(secondCard)")

                        if game.checkCards(firstCard, secondCard) {
                            UIView.animate(withDuration: 0.3, animations: {
                                self.flippedCards.first!.layer.opacity = 0
                                self.flippedCards.last!.layer.opacity = 0
                            }, completion: { _ in
                                self.flippedCards.first!.removeFromSuperview()
                                self.flippedCards.first!.removeFromSuperview()
                                self.flippedCards = []
                            })
                        } else {
                            for card in self.flippedCards {
                                (card as! FlippableView).flip()
                            }
                        }
                    }
                    
                }
            }
        }
        return cardViews
    }
    
    private var cardSize: CGSize {
        CGSize(width: 50, height: 120)
    }
    
    private var cardMaxXCoordinate: Int {
        Int(boardGameView.frame.width - cardSize.width)
    }
    
    private var cardMaxYCoordinate: Int {
        Int(boardGameView.frame.height - cardSize.height)
    }
    
    var cardViews = [UIView]()
    
    private func placeCardsOnBoard(_ cards: [UIView]) {
        
        for card in cardViews {
            card.removeFromSuperview()
        }
        
        cardViews = cards
        
        for card in cardViews {
            let randomXCoordinate = Int.random(in: 0...cardMaxXCoordinate)
            let randomYCoordinate = Int.random(in: 0...cardMaxYCoordinate)
            card.frame.origin = CGPoint(x: randomXCoordinate, y: randomYCoordinate)
//            print("\(card)")
            
            boardGameView.addSubview(card)
            card.setNeedsDisplay()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        view.addSubview(startButtonView)
        view.addSubview(boardGameView)
    }
}
