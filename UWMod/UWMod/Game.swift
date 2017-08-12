//
//  Game.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-07-25.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import Foundation

enum GamePhase {
    case NightPhase
    case DayPhase
}

class Game {
    
    // MARK: - Variable declaration
    
    // Player & roles before they are assigned to each other.
    // availablePlayers, after the end of the first night will be a list of all players
    // currently in the game, regardless of status
    var availableRoster:                            [Role]
    var availablePlayers:                           [Player]
    
    // Game related variables
    private var _currentNight:                      Int
    private var _currentDay:                        Int
    private var _firstNight:                        Bool
    private var _werewolfEliminationsThisNight:     Int
    private var _timeGameStarted:                   Date
    var areThereDeadPlayers:                        Bool
    
    // Game settings
    var settings:                                   GameSettings
    
    // Actor related variables
    private var _nightActors:                       [Player]
    private var _consolidatedNightActors:           [Player]
    private var _chosenPlayer:                      Player?
    var livingActors:                               [Player]
    var playersToBeEliminated:                      [Player]
    var deadActors:                                 [Player]
    var playersEliminatedThisPhase:                 String
    var playersProtectedThisPhase:                  String

    // Team related variables
    private var _rolesInTheGame:                    [RoleType]
    var daytimeInfoCards:                           [DaytimeCardType]

    
    // Role related variables
    private var _werewolvesHaveKilledThisNight:     Bool
    private var _werewolvesAreDiseased:             Bool
    private var _wolfRoles:                         [RoleType]
    var aWerewolfHasBeenSlain:                      Bool

    
    // Custom, private getters
    private var availableVillagerRoles: Int {
        get {
            var roleCount = 0
            for role in self.availableRoster {
                if role.type == .Villager {
                    roleCount += 1
                }
            }
            
            return roleCount
        }
    }
    
    private var numberOfUnassignedPlayers: Int {
        get {
            var playerCount = 0
            for player in self.availablePlayers {
                if !player.isAssigned {
                    playerCount += 1
                }
            }
            
            return playerCount
        }
    }
    
    
    // Public getters for private variables
    var currentNight: Int {
        get { return _currentNight }
    }
    
    var currentDay: Int {
        get { return _currentDay }
    }
    
    var firstNight: Bool {
        get { return _firstNight }
    }
    
    var nightActors: [Player] {
        get {
            
            if _consolidatedNightActors.count > 0 {
                return _consolidatedNightActors
            }
            
            return _nightActors
        }
    }
    
    var werewolfEliminationsThisNight: Int {
        get { return _werewolfEliminationsThisNight }
    }
    
    var wolfRoles: [RoleType] {
        get { return _wolfRoles }
    }
    
    
    // MARK: - Initializer
    
    init(availableRoster: [Role], availablePlayers: [Player], withSettings: GameSettings = GameSettings()) {
        // Sort the roles by the role priority. This makes it easier to present the 
        // player list in some semblance of a correct order.
        self.availablePlayers               = availablePlayers.sorted(by: { ($0.name) < ($1.name) })
        self.availableRoster                = availableRoster.sorted(by: { ($0.priority) < ($1.priority) })

        // Game related variables
        self._firstNight                    = true
        self._currentNight                  = 1
        self._currentDay                    = 1
        self._werewolfEliminationsThisNight = 0
        self._timeGameStarted               = Date()
        self.areThereDeadPlayers            = false
        
        // Game settings
        self.settings                       = withSettings
        
        // Actor related variables
        self._nightActors                   = []
        self._consolidatedNightActors       = []
        self.livingActors                   = []
        self.playersToBeEliminated          = []
        self.deadActors                     = []
        self.playersEliminatedThisPhase     = ""
        self.playersProtectedThisPhase      = ""
        
        
        // Team related variables
        self._rolesInTheGame                = []
        self.daytimeInfoCards               = []
        
        // Role related variables
        self._werewolvesHaveKilledThisNight = true
        self._werewolvesAreDiseased         = false
        self._wolfRoles                     = [.Werewolf,
                                               .WolfMan,
                                               .WolfCub,
                                               .DireWolf,
                                               .TeenageWerewolf,
                                               .BigBadWolf,
                                               .Dreamwolf,
                                               .FangFace,
                                               .AlphaWolf,
                                               .FruitBrute,
                                               .Wolverine]
        self.aWerewolfHasBeenSlain          = false
        
    }

    
    // MARK: - Game setup & teardown
    
    /// Call this to end the game. Check if the user wants to actually do it. If YES, then
    /// presentEndGameInfo(). After hitting OK, call resetGame().
    public func endGame() {
        
    }
    
    public func resetGame() {
        GAME = Game(availableRoster: [], availablePlayers: [])
    }
    
    public func presentEndGameInfo () {
//        let timeGameEnded = Date()
//        let timePassed = timeGameEnded.timeIntervalSince(_timeGameStarted)
    }
    
    
    // MARK: - Victory related functions
    
    private func checkForVictory() {
        
    }
    
    private func reportTeamEndGameStatus() {
        
    }
    
    
    // MARK: - Player related functions
    
    public func addPlayerToLivingActors(player: Player) {
        livingActors.append(player)
    }
    
    private func assignInfoCardsToPlayers() {
        for actor in livingActors {
            actor.determineDaytimeInfoCardForActor()
        }
    }
    
    // Player elimination should happen at the END of each round after effects have been
    // applied by the different roles in order to accout for effects taking.... effect.
    public func prepareToEliminatePlayer(victim: Player) {
        if !self.playersToBeEliminated.contains(where: { $0 === victim }) {
            playersToBeEliminated.append(victim)
        }
    }
    
    private func eliminatePlayers() {
        
        for victim in playersToBeEliminated {
            if !victim.isAffectedBy(condition: .Protection) {
                if self.livingActors.contains(where: { $0 === victim }) {
                    addToPhaseReport(player: victim)
                    self.deadActors.append(victim)
                    victim.isAlive = false
                    
                    if let tempIndex = self.livingActors.index(where: { $0 === victim }) {
                        self.livingActors.remove(at: tempIndex)
                    }
                    
                    if victim.roleType() == .WolfCub {
                        increasePossibleWerewolfTargets()
                    }
                    
                    if victim.killedBy != nil {
                        if _wolfRoles.contains(victim.killedBy!) && victim.roleType() == .Diseased {
                            _werewolvesAreDiseased = true
                        }
                    }
                }
                
            } else {
                addToPhaseReport(player: victim)
            }
        }
        
        playersToBeEliminated.removeAll()
    }
    
    // Add to the string report for the end of the game.
    private func addToPhaseReport(player: Player) {
        let textToAdd = retrievePlayerNameWithRole(player: player)
        
        if player.isAffectedBy(condition: .Protection) {
            playersProtectedThisPhase = playersProtectedThisPhase + textToAdd
        } else {
            playersEliminatedThisPhase = playersEliminatedThisPhase + textToAdd
        }
    }
    
    private func clearPhaseReport() {
        playersEliminatedThisPhase = ""
        playersProtectedThisPhase = ""
    }
    
    
    // The following function enable a chosen player in the select player screen.
    public func identifyChosenPlayer() -> Player {
        return _chosenPlayer!
    }
    
    public func useChosenPlayer() -> Player {
        let tempPlayer: Player = _chosenPlayer!
        _chosenPlayer = nil
        
        return tempPlayer
    }
    
    public func setChosenPlayer(player: Player) {
        _chosenPlayer = player
    }
    
    
    // MARK: - Player name retrieval functions for various uses
    
    public func fetchPlayersAffectedByEffect(fromList: [Player], affectedBy effect: PlayerEffects, withRole: Bool = false, separatedByComma: Bool = false) -> String {
        var players = ""
        
        for player in fromList {
            if player.isAffectedBy(condition: effect) {
                let temp = fetchSinglePlayer(player: player, withRole: withRole, separatedByComma: separatedByComma)
                players = players + temp
            }
        }
        
        return players
    }
    
    public func fetchPlayersWithTeamType(fromList: [Player], ofTeamType: UWTeam, withRole: Bool = false, separatedByComma: Bool = false) -> String {
        var players = ""
        
        for player in fromList {
            for teamType in player.team {
                if teamType == ofTeamType {
                    let temp = fetchSinglePlayer(player: player, withRole: withRole, separatedByComma: separatedByComma)
                    players = players + temp
                }
            }
        }
        
        return players
    }
    
    public func fetchPlayersWithRoleType(fromList: [Player], ofRoleType: RoleType, withRole: Bool = false, separatedByComma: Bool = false) -> String {
        var players = ""
        
        for player in fromList {
            if player.roleType() == ofRoleType {
                let temp = fetchSinglePlayer(player: player, withRole: withRole, separatedByComma: separatedByComma)
                players = players + temp
            }
        }
        
        return players
    }
    
    public func fetchAllPlayers(fromList: [Player], withRole: Bool = false, separatedByComma: Bool = false) -> String {
        var players = ""
        
        for player in fromList {
            let temp = fetchSinglePlayer(player: player, withRole: withRole, separatedByComma: separatedByComma)
            players = players + temp
        }
        
        return players
    }
    
    public func fetchSinglePlayer(player: Player, withRole: Bool, separatedByComma: Bool = false) -> String {
        var temp: String
        
        if withRole {
            temp = retrievePlayerNameWithRole(player: player, separatedByComma: separatedByComma)
        } else {
            temp = retrievePlayerNameWithoutRole(player: player, separatedByComma: separatedByComma)
        }
        
        return temp
    
    }

    private func retrievePlayerNameWithRole(player: Player, separatedByComma: Bool = false) -> String {
        var separator = "\n"
        if separatedByComma {
            separator = ", "
        }
        
        return "\(player.name) (\(player.roleName()))\(separator)"
    }
    
    private func retrievePlayerNameWithoutRole(player: Player, separatedByComma: Bool = false) -> String {
        var separator = "\n"
        if separatedByComma {
            separator = ", "
        }
        
        return "\(player.name)\(separator)"
    }

    
    // MARK: - Phase end related functions
    
    public func finishNight() {
        
        if firstNight {
            _firstNight = false
            availablePlayers.removeAll()
            availablePlayers = livingActors
            livingActors.sort(by: { $0.name < $1.name } )
            determineRolesInTheGame()
        }
        
        clearPhaseReport()
        assignInfoCardsToPlayers()
        eliminatePlayers()
        resetPlayerNightActions()
        determineNightActors()
        setDeadPlayerCheck()
        setupInfoCards()
        
        _currentNight += 1
    }
    
    public func finishDay() {
        
        clearPhaseReport()
        assignInfoCardsToPlayers()
        eliminatePlayers()
        resetPlayerDayActions()
        determineNumberOfWerewolfEliminations()
        determineNightActors()
        setDeadPlayerCheck()
        
        aWerewolfHasBeenSlain = false
        _currentDay += 1
    }
    
    private func resetPlayerNightActions() {
        for player in livingActors {
            player.hasActedTonight = false
            player.cleanupAfterRound(nightRound: true)
        }
    }
    
    private func resetPlayerDayActions() {
        for player in livingActors {
            player.hasActedToday = false
            player.cleanupAfterRound(nightRound: false)
        }
    }
    
    private func setDeadPlayerCheck() {
        if !areThereDeadPlayers {
            if deadActors.count > 0 {
                areThereDeadPlayers = true
            }
        }
    }
    
    
    // MARK: - General game functions
    
    /// Check whethere there are an equal number of Villager roles and unassigned players
    public func shouldPerformMagicAssignment() -> Bool {
        if availableVillagerRoles == numberOfUnassignedPlayers {
            return true
        }
        return false
    }
    
    /// Assign unassigned players to Villager roles
    public func magicVillagerAssignment() {
        if shouldPerformMagicAssignment() {
            
            var backwardsIndex = availableRoster.count - 1
            
            for player in availablePlayers {
                if !player.isAssigned {
                    player.assignRole(role: availableRoster[backwardsIndex])
                    addPlayerToLivingActors(player: player)
                    backwardsIndex -= 1
                }
            }
        }
    }
    
    private func setupInfoCards() {
        var tempArray: [DaytimeCardType] = [.GeneralInfoCard]
        
        for player in livingActors {
            let daytimeInfoCards = player.daytimeInfoCards
            for cardType in daytimeInfoCards {
                if !tempArray.contains(cardType) {
                    tempArray.append(cardType)
                }
            }
        }
        
        if areThereDeadPlayers {
            tempArray.append(.GraveyardCard)
        }
        
        self.daytimeInfoCards.removeAll()
        self.daytimeInfoCards = tempArray
    }
    
    private func determineNumberOfWerewolfEliminations() {
        
        if _werewolvesHaveKilledThisNight {
            increasePossibleWerewolfTargets()
            _werewolvesHaveKilledThisNight = false
        }
        
        for player in livingActors {
            if player.roleType() == .BigBadWolf {
                increasePossibleWerewolfTargets()
            }
        }
        
        
        // This is a last check!
        if _werewolvesAreDiseased {
            _werewolfEliminationsThisNight  = 0
            _werewolvesAreDiseased          = false
            _werewolvesHaveKilledThisNight  = true
        }
    }
    
    private func determineRolesInTheGame() {
        for player in availablePlayers {
            if !_rolesInTheGame.contains(player.roleType()) {
                _rolesInTheGame.append(player.roleType())
            }
        }
    }
    
    private func determineNightActors() {
        regularNightActorFill()
        consolidateNightActors()
    }
    
    private func consolidateNightActors() {
        let vampireList: [RoleType]             = [.Vampire]
        
        let roleCount = checkIfShouldConsolitade(wolfList: _wolfRoles,
                                                 vampireList: vampireList)
        
        _consolidatedNightActors.removeAll()
        _consolidatedNightActors = buildConsolidatedNightActors(withWerevolvesPresent: roleCount.werewolves,
                                                                withVampiresPresent: roleCount.vampires,
                                                                wolfList: _wolfRoles,
                                                                vampireList: vampireList)
    }
    
    private func buildConsolidatedNightActors(withWerevolvesPresent werewolves: Int, withVampiresPresent vampires: Int, wolfList: [RoleType], vampireList: [RoleType]) -> [Player] {
        
        var consolidatedPlayers: [Player]           = []
        var alreadyAddedWerewolfTeamCard            = false
//        var alreadyAddedVampireTeamCard             = false
        
        let werewolfTeamPlayer = createTeamPlayer(roleCount: werewolves,
                                                  roleList: wolfList,
                                                  teamType: .TeamWerewolf)
//        let vampireTeamPlayer = createTeamPlayer(roleCount: vampires,
//                                                 roleList: vampireList,
//                                                 teamType: .TeamVamprie)
        
        var wolfRoles = wolfList
        wolfRoles.remove(at: (wolfRoles.index(of: .AlphaWolf))!)
        
        // Only create consolidated players if there is a need.
        if werewolves >= 2 || vampires >= 2 {
            for player in availablePlayers {
                if player.isNightActivePlayer {
                    let playerRole = player.roleType()
                    if wolfRoles.contains(playerRole) {
                        if !alreadyAddedWerewolfTeamCard {
                            consolidatedPlayers.append(werewolfTeamPlayer)
                            alreadyAddedWerewolfTeamCard = true
                        }
                        
                        //            } else if vampireList.contains(playerRole) {
                        //                if !alreadyAddedVampireTeamCard {
                        //                    consolidatedPlayers.append(vampireTeamPlayer)
                        //                    alreadyAddedVampireTeamCard = true
                        //                }
                        
                    } else {
                        consolidatedPlayers.append(player)
                    }
                }
            }
            
            if consolidatedPlayers.count > 0 {
                consolidatedPlayers.sort(by: { ($0.rolePriority()) < ($1.rolePriority()) })
            }
        }
        
        return consolidatedPlayers
    }
    
    private func createTeamPlayer(roleCount: Int, roleList: [RoleType], teamType: UWTeam) -> Player{
        // Create a Team Player to present as a card.
        var newName                         = ""
        let teamPlayer: Player              = Player(name: newName)
        
        if roleCount >= 2 {
            for player in livingActors {
                if roleList.contains(player.roleType()) {
                    let nameToAdd = fetchSinglePlayer(player: player, withRole: false, separatedByComma: true)
                    newName = newName + nameToAdd
                }
            }
        }
        
        if newName != "" {
            let truncatedName = newName.substring(to: newName.index(newName.endIndex, offsetBy: -2))
            teamPlayer.name = truncatedName
        }
        
        if teamType == .TeamWerewolf {
            teamPlayer.assignRole(role: WEREWOLF_TEAM)
        } else if teamType == .TeamVamprie {
            //teamPlayer.assignRole(role: VAMPIRE_TEAM)
        }
        
        return teamPlayer
    }
    
    private func checkIfShouldConsolitade(wolfList: [RoleType], vampireList: [RoleType]) -> (werewolves: Int, vampires: Int) {
        var werewolves = 0
        var vampires = 0
        
        for player in livingActors {
            
            let playerRole = player.roleType()
            if wolfList.contains(playerRole) {
                werewolves += 1
            } else if vampireList.contains(playerRole) {
                vampires += 1
            }
        }
        
        return (werewolves, vampires)
    }
    
    private func regularNightActorFill() {
        _nightActors.removeAll()
        for actor in self.availablePlayers {
            if actor.isNightActivePlayer {
                if actor.roleType() == .Werewolf {
                    if actor.isAlive {
                        _nightActors.append(actor)
                    }
                    
                } else {
                    _nightActors.append(actor)
                }
            }
        }
        
        _nightActors.sort(by: { ($0.rolePriority()) < ($1.rolePriority()) })
    }
    
    
    // MARK: - Role related functions
    
    public func increasePossibleWerewolfTargets() {
        _werewolfEliminationsThisNight += 1
    }
    
    public func decreasePossibleWerewolfTargets() {
        _werewolfEliminationsThisNight -= 1
    }
    
    public func werewolvesHaveKilled() {
        decreasePossibleWerewolfTargets()
        if !_werewolvesHaveKilledThisNight {
            _werewolvesHaveKilledThisNight = true
        }
    }
}
