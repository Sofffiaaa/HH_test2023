import UIKit

open class Creature {
    var attack: Int = 1 {
        didSet {
            guard attack > 1 || attack < 30 else {
                fatalError("Недопустимое значение параметра Атака. Введите другое значение")
            }
        }
    }
    var protection: Int = 1 {
        didSet {
            guard protection > 1 || protection < 30 else {
                fatalError("Недопустимое значение параметра Защита. Введите другое значение")
            }
        }
    }
    var health: Int = 0 {
        didSet {
            guard health > 1 else {
                fatalError("Недопустимое значение параметра Здоровье. Введите другое значение")
            }
        }
    }
    
    func takeHealth(damage: Int) {
        self.health -= damage
    }
}

class Player: Creature {
    
    private var maxHealth: Int = 0 {
        didSet {
            guard maxHealth > 1 else {
                fatalError("")
            }
        }
    }
    private var getHealed: Int = 4
    
    func heal() {
        guard getHealed != 0 else {
            print("Нельзя исцелиться")
            return
        }
        health += maxHealth + maxHealth*(30 / 100)
        if (health > maxHealth) {
            health = maxHealth
        }
        getHealed -= 1
        
    }
}

class Monster: Creature {
    
}

open class Game {
    
    private var monsters: Array<Monster>
    private var player: Player?
    var round: Int = 1
    
    func addPlayer(p: Player){
        
        guard player == nil else {
            fatalError("")
        }
        player = p
    }
    
    func addMonster(m: Monster) {
        monsters.append(m)
    }
    
    private func hit(attacking: Creature, defending: Creature) {
        var attackModifier: Int
        
        guard attacking.attack < defending.protection else {
            attackModifier == attacking.attack - defending.protection + 1
        }
        attackModifier = 1
        
        var isSuccess = false
        
        var dice = Int.random(in: 1...6)
        if dice == 5 || dice == 6 {
            isSuccess = true
        }
        
        guard isSuccess == true else {
            print("Неудачная атака")
        }
        defending.takeHealth(damage: Int.random(in: 1...6))
        print("Успешная атака")
    }
    
    func start() {
        guard player != nil else {
            print("")
            return
        }
        guard player == nil && monsters.isEmpty else {
            print("")
        }
        guard round % 2 == 1 else {
            monsterHit()
        }
        playerHit()
        
        removeDeadCreature()
        
        round += 1
    }
    
    func playerHit() {
        var randMonster = monsters.randomElement()
        
        hit(attacking: player!, defending: randMonster!)
    }
    
    func monsterHit() {
        var randMonster = monsters.randomElement()
        
        hit(attacking: randMonster!, defending: player!)
    }
    
    private func removeDeadCreature() -> Monster {
        for monster in monsters {
            guard var monsterIndex = monsters.firstIndex(where:{$0 === monster}) else {
                return monster
            }
            if monster.health < 1 {
                monsters.remove(at: monsterIndex)
            }
        }
        
        if player!.health < 1 {
            player = nil
        }
    }
}

private var game: Game

var pl: Player
var m1: Monster
var m2: Monster
var m3: Monster

game.addPlayer(p: pl)
game.addMonster(m: m1)
game.addMonster(m: m2)
game.addMonster(m: m3)

game.start()
