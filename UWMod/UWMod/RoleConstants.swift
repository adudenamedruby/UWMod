//
//  RoleConstants.swift
//  UWMod
//
//  Created by roux g. buciu on 2017-07-26.
//  Copyright © 2017 roux g. buciu. All rights reserved.
//

import Foundation
import UIKit

// Roles in the game

let pregame_tempRoles: [Role] = [BEHOLDER,
                                 BODYGUARD,
                                 CULTLEADER,
                                 CUPID,
                                 CURSED,
                                 DISEASED,
                                 DREAMWOLF,
                                 GHOST,
                                 HUNTER,
                                 INSOMNIAC,
                                 LONE_WOLF,
                                 LYCAN,
                                 MAD_BOMBER,
                                 MASON_ONE, MASON_TWO, MASON_THREE,
                                 MAYOR,
                                 MINION,
                                 PACIFIST,
                                 PRIEST,
                                 SEER,
                                 SORCERESS,
                                 SPELLCASTER,
                                 TANNER,
                                 THE_BLOB,
                                 THE_COUNT,
                                 THING,
                                 TROUBLEMAKER,
                                 VILLAGE_IDIOT,
                                 VILLAGER_ONE, VILLAGER_TWO, VILLAGER_THREE, VILLAGER_FOUR, VILLAGER_FIVE, VILLAGER_SIX, VILLAGER_SEVEN, VILLAGER_EIGHT, VILLAGER_NINE, VILLAGER_TEN, VILLAGER_ELEVEN, VILLAGER_TWELVE, VILLAGER_THIRTEEN, VILLAGER_FOURTEEN, VILLAGER_FIFTEEN,
                                 VIRGINIA_WOOLF,
                                 WEREWOLF_ONE, WEREWOLF_TWO, WEREWOLF_THREE, WEREWOLF_FOUR, WEREWOLF_FIVE, WEREWOLF_SIX, WEREWOLF_SEVEN, WEREWOLF_EIGHT, WEREWOLF_NINE, WEREWOLF_TEN, WEREWOLF_ELEVEN, WEREWOLF_TWELVE,
                                 WITCH,
                                 WOLFCUB,
                                 WOLFMAN,
                                 ZOMBIE]

let pregame_VillageRoleType: [RoleType]     = [.CultLeader, .Tanner, .Ghost, .Bodyguard, .Hunter, .Revealer, .Cupid, .Pacifist, .Huntress, .Cursed, .Diseased, .Drunk, .VirginiaWoolf, .BloodyMary, .Leprechaun, .TheCount, .MadBomber, .Martyr, .Witch, .Mayor, .Mentalist, .Nostradamus, .OldHag, .ParanormalInvestigator, .Prince, .Sasquatch, .Spellcaster, .TheMummy, .TheThing, .Doppelganger, .FrankensteinsMonster, .ToughGuy, .Priest, .Troublemaker, .ApprenticeSeer, .Seer, .AuraSeer, .MysticSeer, .Beholder, .Insomniac, .Lycan, .VillageIdiot, .Villager, .Hoodlum, .Mason]
let pregame_WerewolfRoleType: [RoleType]    = [.WolfCub, .TeenageWerewolf, .WolfMan, .Dreamwolf, .FangFace, .FruitBrute, .Werewolf, .DireWolf, .AlphaWolf, .BigBadWolf, .Wolverine, .Minion, .Sorceress, .LoneWolf]
let pregame_OtherRoleType: [RoleType]       = [.TheBlob, .Bogeyman, .Chupacabra, .CountDracula, .Vampire, .Zombie]

let VILLAGE_ROLES:  [Role]                  = filterBy(roleTypeList: pregame_VillageRoleType)
let WEREWOLF_ROLES: [Role]                  = filterBy(roleTypeList: pregame_WerewolfRoleType)
let OTHER_ROLES:    [Role]                  = filterBy(roleTypeList: pregame_OtherRoleType)
let ALL_GAME_ROLES: [Role]                  = pregame_tempRoles.sorted(by: { $0.name < $1.name})

func filterBy(roleTypeList: [RoleType]) -> [Role] {
    var tempList: [Role]    = []
    
    for role in pregame_tempRoles {
        if roleTypeList.contains(role.type) {
            tempList.append(role)
        }
    }
    
    tempList.sort(by: { $0.name < $1.name})
    
    return tempList
    
}

// Roles get instantiated here! Fancy!
// Alphabetical order

let BEHOLDER = Role(name: "Beholder",
                    type: .Beholder,
                    description: "Wakes up during the first night to learn the identity of the Seer.",
                    roleExplanation: "The Beholder learns who the Seer is on the first night. They should be careful how they use this information because they may inadventantly give the Seer away. They might try to secretly let the Seer know that they are a Villager on their team, but if a Werewolf finds out, it could be disastrous for the village team.\n\n[The Beholder is a street urchin that, daily, struggles to survive in the village. Despite his destitute situation, no-one in the village pays attention to him, which makes him a perfect spy. Perchance, he, one day, accidentally saw something he wasn't supposed to see and now knows the secret identity of the Seer.]",
                    impact: 2,
                    priority: 193,
                    team: [.TeamVillage],
                    availableEffects: [],
                    image: #imageLiteral(resourceName: "beholder"),
                    isNightActiveRole: .NotNightActiveRole)



let BODYGUARD = Role(name: "Bodyguard", type: .Bodyguard, description: "Chooses a player to protect from elimination. Activated each night; chosen player must be different from the previous night.", roleExplanation: "The Bodyguard is woken up every night and must choose a player to protect. That player is safe from elimination by any means that night. The chosen player must cannot be the same player twice in a row, but the same player may be chosen multiple times per game. The Moderator does not point out to the Bodyguard who is going to be eliminated that night. Finally, the Bodyguard cannot protect himself.[]", impact: 3, priority: 52, team: [.TeamVillage], availableEffects: [.Protection], image: #imageLiteral(resourceName: "bodyguard"), isNightActiveRole: .NightActiveRole)



let CULTLEADER = Role(name: "Cult Leader", type: .CultLeader, description: "Wakes up every night to choose a player to join their cult. If all living players in the game are part of the cult, the Cult Leader wins.", roleExplanation: "The Cult Leader wakes up every night and points to a person that will join the cult. All players that are part of the cult do not know they are part of the cult - just like in real life! Even though he appears as a villager, the Cult Leader only wins if all players left in the game are part of the cult. Other teams may still fulfill victory contidions. The Cult Leader does not need to be alive to win.[]", impact: 1, priority: 70, team: [.TeamCult], availableEffects: [], image: #imageLiteral(resourceName: "cultLeader"), isNightActiveRole: .NightActiveRole)



let CUPID = Role(name: "Eros", type: .Cupid, description: "Wakes up on the first night and chooses two players to be linked together. If one of them is eliminated, the other is eliminated as well.", roleExplanation: "The god-child Eros has assumed human disguise and walks, hidden, amongst the villagers. Eros wakes up during the first night and points at two players. He may choose himself, as one of the two players. The Moderator then wakes up the two lovebirds the first night by tapping them on the shoulder so they can see who the other sweetheart is. If either of the lovers is eliminated, for any reason, the other is also eliminated instantly, because of a broken heart.\n\nThe lovers fall under a few special victory conditions. If both lovers are on the village team, they win with the village team. Similarly, ff they are both on the werewolf team, they win with the werewolf team. However, if the two lovers find themselves on different teams, they relinquish all other ties, become their own team, and only win if they are the last two players in the game. Being a Lovebird overrides all other winning conditions.[]", impact: -3, priority: 76, team: [.TeamVillage], availableEffects: [.Lovestruck], image: #imageLiteral(resourceName: "cupid"), isNightActiveRole: .NotNightActiveRole)



let CURSED = Role(name: "Cursed", type: .Cursed, description: "Start on the village team. If eliminated by the werewolves, turn into a werewolf and join their team.", roleExplanation: "The Cursed was once hexxed by a travelling circus witch. They start the game on the village team and they act for the benefit of the village. That is, unless they are targeted for elimination by the werewolves, at which point they then join the werewolf team instead of being eliminated.\n\nEvery night, the Moderator should wake the Cursed to let them know if they have switched teams. Once the Cursed has switched teams, the Moderator should continue to call the role, so the players do not know he has been changed.).[]", impact: -3, priority: 5, team: [.TeamVillage], availableEffects: [], image: #imageLiteral(resourceName: "cursed"), isNightActiveRole: .NightActiveRole)

let CURSED_WEREWOLF = Role(name: "Werewolf", type: .Werewolf, description: "Each night, wake with the other Werewolves and choose a player to eliminate.", roleExplanation: "The Werewolves learn the identity of the other Werewolves the first night; they do not kill the first night. Every night afterwards, the Werewolves must agree (only a majority is needed, and need not be unanimous) on a target to eliminate. If the Werewolves spend more than the alloted time determining a target for the night, they do not get to choose a target that night. The Werewolves may not target another Werewolf at night, unless the Leprechaun is in play.[]", impact: -6, priority: 25, team: [.TeamWerewolf], availableEffects: [], image: #imageLiteral(resourceName: "werewolf"), isNightActiveRole: .NightActiveRole)



let DISEASED = Role(name: "Diseased", type: .Diseased, description: "If you are eliminated by the Werewolves, they don't get to eliminate anyone the following night.", roleExplanation: "If the Werewolves target the Diseased player for elimination, they catch a viral infection which prevents them from eliminating anyone during the next night. If the game does not have role reveal, the werewolves still pick a target the following night, but that target is not eliminated.[]", impact: 3, priority: 88, team: [.TeamVillage], availableEffects: [], image: #imageLiteral(resourceName: "diseased"), isNightActiveRole: .NotNightActiveRole)



let DREAMWOLF = Role(name: "Dreamwolf", type: .Dreamwolf, description: "You only wake with the other Werewolves after a Werewolf has been killed.", roleExplanation: "The Dreamwolf is a werewolf, but doesn’t know who his fellow werewolves are and doesn’t wake up in the night with them until another werewolf is eliminated. His fellow werewolves don’t know who he is until he awakes with them at night. The Seer seems the Dreamwolf as a werewolf from the beginning of the game.[]", impact: -5, priority: 16, team: [.TeamWerewolf], availableEffects: [], image: #imageLiteral(resourceName: "dreamwolf"), isNightActiveRole: .NightActiveRole)



let GHOST = Role(name: "Phantom", type: .Ghost, description: "Perish on the first night. Observe the night round, and provide the village a single letter clue each day.", roleExplanation: "The Phantom is the spirit of a villager that has perished the first night. The Phantom will watch each night round and, for the first ten rounds, will provide a single letter clue, as a message from beyond to the village. There are a few limitations: the Phantom may not attempt to identify any player by name or initials. The Phantom should try to be as helpful as possible with their clues, but, must try and remain calm if people are mis-interpreting their clues.[]", impact: 2, priority: 1, team: [.TeamVillage], availableEffects: [], image: #imageLiteral(resourceName: "ghost"), isNightActiveRole: .NotNightActiveRole)



let HUNTER = Role(name: "Huntsman", type: .Hunter, description: "If you are eliminated, you may immediately eliminate another player.", roleExplanation: "When the Huntsman, a hunter of legendary fame, is eliminated - whether by wolves or by being lynched, he goes down fighting, letting loose an arrow from his crossbow. He will choose another player to be his target, and that player is also eliminated. The Huntsman may also choose to die nobly, if he doesn't suspect anyone, and fire his weapon in the air, resulting in no additional elimination. No one may speak while the Huntsman chooses a target. If eliminated at night, the Huntsman chooses his target first thing in the morning.[]", impact: 3, priority: 61, team: [.TeamVillage], availableEffects: [], image: #imageLiteral(resourceName: "hunter"), isNightActiveRole: .NotNightActiveRole)



let INSOMNIAC = Role(name: "Insomniac", type: .Insomniac, description: "Each night, learn if at least one of your neighbors has taken a night action.", roleExplanation: "Every night, the Insomniac wakes up last, and is told by the Moderator if anyone woke up at night who is sitting next to them.\n\nImportant note: the Moderator does not tell the Insomniac if which player sitting next to them woke up at night, just that at least one of those players woke up that night. Regular adjanceny rules apply with the expection that if a player next to to the Insomniac is eliminated at night, he is informed about that player's actions and not the player next to the eliminated player.[]", impact: 3, priority: 199, team: [.TeamVillage], availableEffects: [], image: #imageLiteral(resourceName: "insomniac"), isNightActiveRole: .NightActiveRole)



let LONE_WOLF = Role(name: "Lone Wolf", type: .LoneWolf, description: "Wake with the other Werewolves at night, but only win if you are the last wolf in the game.", roleExplanation: "The Lone Wolf only wins if he is the last player standing (or achieves parity with the village by having only one other non-werewolf player left in the game). The Lone Wolf wakes up with the werewolves to choose a target each night.[]", impact: -5, priority: 202, team: [.TeamWerewolf], availableEffects: [], image: #imageLiteral(resourceName: "loneWolf"), isNightActiveRole: .NightActiveRole)



let LYCAN = Role(name: "Lycan", type: .Lycan, description: "You are a Villager, but appear to the Seer as a Werewolf.", roleExplanation: "The Lycan is a villager of questionable parentage. Turns out, people were right to be slightly suspicios as the Lycan has a dormant drain of werewolfism, and appears to be a werewolf to the Seer even though she's not.[]", impact: -1, priority: 205, team: [.TeamVillage], availableEffects: [], image: #imageLiteral(resourceName: "lycan"), isNightActiveRole: .NotNightActiveRole)



let MAD_BOMBER = Role(name: "Mad Bomber", type: .MadBomber, description: "If you are eliminated, the players immediately to your left and right are eliminated as well.", roleExplanation: "If the Mad Bomber is eliminated, the player closest to him on both the right and left of him is eliminated instantly. The right player is eliminated before the left player (this can matter in certain situations).[]", impact: -2, priority: 109, team: [.TeamVillage], availableEffects: [], image: #imageLiteral(resourceName: "madBomber"), isNightActiveRole: .NotNightActiveRole)



let MAYOR = Role(name: "Mayor", type: .Mayor, description: "Your vote counts twice.", roleExplanation: "As the democratically elected leader of the village, the Mayor’s voice carries weight in the community and, as such, their vote counts twice when voting to eliminate a player. This is done by the moderator secretly counting the Mayor’s vote twice.[]", impact: 2, priority: 124, team: [.TeamVillage], availableEffects: [], image: #imageLiteral(resourceName: "mayor"), isNightActiveRole: .NotNightActiveRole)



let MASON_ONE = Role(name: "Mason", type: .Mason, description: "The first night, wake up to see who the other Masons are.", roleExplanation: "The first night the Moderator calls for the Masons to open their eyes and look for the other Masons. Starting on the first day, no one in the village may directly or indirectly speak of the Masons. There are two penalties for players that speak of them: the first person to speak of the Masons is visited by the Masons at night and is silenced... for the rest of the game! Any players that mention the Masons afterwards are eliminated that night by the secret society in order to keep it a secret. If they are eliminated by the secret society, they automatically lose, even if they are on a winning team.\n\nImportant notes for the Moderator: use discretion. It's much better for gameplay if the subject is never discussed directly or indirectly by the players. If a player says, 'Well, we know these three are safe.' that's a clear reference to the Masons, so that player should be eliminated.[]", impact: 2, priority: 121, team: [.TeamVillage], availableEffects: [], image: #imageLiteral(resourceName: "mason"), isNightActiveRole: .NotNightActiveRole)

let MASON_TWO = Role(name: "Mason", type: .Mason, description: "The first night, wake up to see who the other Masons are.", roleExplanation: "The first night the Moderator calls for the Masons to open their eyes and look for the other Masons. Starting on the first day, no one in the village may directly or indirectly speak of the Masons. There are two penalties for players that speak of them: the first person to speak of the Masons is visited by the Masons at night and is silenced... for the rest of the game! Any players that mention the Masons afterwards are eliminated that night by the secret society in order to keep it a secret. If they are eliminated by the secret society, they automatically lose, even if they are on a winning team.\n\nImportant notes for the Moderator: use discretion. It's much better for gameplay if the subject is never discussed directly or indirectly by the players. If a player says, 'Well, we know these three are safe.' that's a clear reference to the Masons, so that player should be eliminated.[]", impact: 2, priority: 121, team: [.TeamVillage], availableEffects: [], image: #imageLiteral(resourceName: "mason"), isNightActiveRole: .NotNightActiveRole)

let MASON_THREE = Role(name: "Mason", type: .Mason, description: "The first night, wake up to see who the other Masons are.", roleExplanation: "The first night the Moderator calls for the Masons to open their eyes and look for the other Masons. Starting on the first day, no one in the village may directly or indirectly speak of the Masons. There are two penalties for players that speak of them: the first person to speak of the Masons is visited by the Masons at night and is silenced... for the rest of the game! Any players that mention the Masons afterwards are eliminated that night by the secret society in order to keep it a secret. If they are eliminated by the secret society, they automatically lose, even if they are on a winning team.\n\nImportant notes for the Moderator: use discretion. It's much better for gameplay if the subject is never discussed directly or indirectly by the players. If a player says, 'Well, we know these three are safe.' that's a clear reference to the Masons, so that player should be eliminated.[]", impact: 2, priority: 121, team: [.TeamVillage], availableEffects: [], image: #imageLiteral(resourceName: "mason"), isNightActiveRole: .NotNightActiveRole)



let MINION = Role(name: "Minion", type: .Minion, description: "You know who the werewolves are, but you do not wake up with them at night.", roleExplanation: "The first night, the Minion learns who the werewolves are, but does not wake with them at night. The Seer sees the Minion as a villager. They should use this information to sow disinformation and distrust amongst the villagers.[]", impact: -6, priority: 40, team: [.TeamWerewolf], availableEffects: [], image: #imageLiteral(resourceName: "minion"), isNightActiveRole: .NotNightActiveRole)



let PACIFIST = Role(name: "Pacifist", type: .Pacifist, description: "You must always vote for players to not be eliminated.", roleExplanation: "The Pacifist, abhorring violence, always votes agaist a lynch. They are a very helpful for the Werewolves because it's one vote that they must not worry about, even if they don't know who the Pacifist is.[]", impact: -1, priority: 79, team: [.TeamVillage], availableEffects: [], image: #imageLiteral(resourceName: "pacifist"), isNightActiveRole: .NotNightActiveRole)



let PRIEST = Role(name: "Priest", type: .Priest, description: "One night, once per game, choose a player to be protected. That player may not be eliminated at night.", roleExplanation: "Every game, once per night, the Priest can choose someone to protect. The Moderator should wake the Priest, show them who is going to be eliminated, and give them the option to use their power to save that player from any form of elimination. The Priest cannot choose himself, even if he hasn't used his power and he is the current target.[]", impact: 3, priority: 172, team: [.TeamVillage], availableEffects: [.Protection], image: #imageLiteral(resourceName: "priest"), isNightActiveRole: .NightActiveRole)



let SEER = Role(name: "Seer", type: .Seer, description: "Each night choose a player to learn if he is a Villager or a Werewolf.", roleExplanation: "Each night, the Seer chooses a player by pointing at them, and the Moderator tells her, through a thumbs up - for villager - or a thumbs down - for a werewolf - what that player's affiliation is. While this is generally great information, the Seer should be careful when certain roles are in the game, like the Minior or the Lycan, as what they see is imperfect.[]", impact: 4, priority: 181, team: [.TeamVillage], availableEffects: [.Protection], image: #imageLiteral(resourceName: "seer"), isNightActiveRole: .NightActiveRole)



let SORCERESS = Role(name: "Sorceress", type: .Sorceress, description: "Each night, you wake up and try to find the Seer.", roleExplanation: "After the first night, the Sorceress looks for the Seer each night (the Moderator shows a thumbs up if the Sorceress points to the Seer). The Werewolves do not know who the Sorceress is, and the Sorceress does not know who the Werewolves are. The Seer sees the Sorceress as a villager.[]", impact: -3, priority: 190, team: [.TeamWerewolf], availableEffects: [], image: #imageLiteral(resourceName: "sorceress"), isNightActiveRole: .NightActiveRole)



let SPELLCASTER = Role(name: "Spellcaster", type: .Spellcaster, description: "Each night, choose a player to silence the following day.", roleExplanation: "Each night, the Spellcaster may choose one player to be muted for the following day (that player may not speak but may communicate any other way). The Spellcaster may choose to mute themselves, but may not mute the same player twice during a single game.[]", impact: 1, priority: 148, team: [.TeamVillage], availableEffects: [.Silence], image: #imageLiteral(resourceName: "spellcaster"), isNightActiveRole: .NightActiveRole)



let THE_BLOB = Role(name: "The Blob", type: .TheBlob, description: "Each night, the player to the right of The Blob is absorbed. If all players are part of The Blob, you win.", roleExplanation: "Each night, the Blob absorbs one player to the right of the Blob. If all players are part of The Blob, The Blob player wins, even if he has been eliminated.[]", impact: -1, priority: 151, team: [.TeamBlob], availableEffects: [], image: #imageLiteral(resourceName: "theBlob"), isNightActiveRole: .NightActiveRole)



let THE_COUNT = Role(name: "The Count", type: .TheCount, description: "The first night you are told how many Werewolves are in each half of the village.", roleExplanation: "The first night, The Count is told how many Werewolves are in each half of the village. The Moderator should indicate where the 'halfway' point is (ideally, across from the Count) and tell him the number of werewolves in each half.\n\nThe smaller the game, the more impact this has. It’s a bad idea to add the Count to a game where there is only one Werewolf (from the werewolves point of view).[]", impact: 5, priority: 106, team: [.TeamVillage], availableEffects: [], image: #imageLiteral(resourceName: "theCount"), isNightActiveRole: .NotNightActiveRole)



let TANNER = Role(name: "Tanner", type: .Tanner, description: "You hate your job and your life. You win if you are eliminated.", roleExplanation: "The Tanner only wins if he is eliminated. Victory conditions for the other teams are still present; the game continues after the Tanner wins.[]", impact: -2, priority: 58, team: [.TeamTanner], availableEffects: [], image: #imageLiteral(resourceName: "tanner"), isNightActiveRole: .NotNightActiveRole)



let THING = Role(name: "The Thing", type: .TheThing, description: "Each night, tap a player sitting immediately next to you.", roleExplanation: "The Thing (that goes bump in the night) awakes each night and must tap one of the players next to him. He may tap a player he’s already tapped, or pick a different player each night (as long as that player is next to him). If the player next to the Thing is eliminated, the Thing may tap the next player over. But each night, he must tap one of his neighbours (even if his original neighbours are eliminated).\n\nThe good 'thing' about the Thing is that if he is sitting next to players on the village team, they know they can trust him. However, if he is sitting next to even one Werewolf, it’s probably in the werewolves’ best interest to kill him off quickly, because otherwise he’ll be compelled to 'defend' the Thing during the day in order not to raise suspicion upon himself.\n\nNo other players may tap or touch anyone else during the Thing’s 'awakening' or at any other time during the night.[]", impact: 3, priority: 157, team: [.TeamVillage], availableEffects: [], image: #imageLiteral(resourceName: "theThing"), isNightActiveRole: .NightActiveRole)



let TROUBLEMAKER = Role(name: "Troublemaker", type: .Troublemaker, description: "One night per game, stir up trouble by calling for players to be eliminated the following day.", roleExplanation: "Once per game, the Troublemaker can call for two eliminations the following day. Until she does this, she is woken up by the Moderator each night.[]", impact: -3, priority: 175, team: [.TeamVillage], availableEffects: [.Delinquency], image: #imageLiteral(resourceName: "troublemaker"), isNightActiveRole: .NightActiveRole)



let VILLAGE_IDIOT = Role(name: "Village Idiot", type: .VillageIdiot, description: "Always votes for players to be eliminated.", roleExplanation: "The Village Idiot always votes to lynch players, causing havok amongst players' suspicions.[]", impact: 2, priority: 208, team: [.TeamVillage], availableEffects: [], image: #imageLiteral(resourceName: "villageIdiot"), isNightActiveRole: .NotNightActiveRole)



let VILLAGER_ONE = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "Villager’s sole purpose is to find the Werewolves and eliminate them.[]", impact: 3, priority: 250, team: [.TeamVillage], availableEffects: [], image: #imageLiteral(resourceName: "villager"), isNightActiveRole: .NotNightActiveRole)

let VILLAGER_TWO = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "Villager’s sole purpose is to find the Werewolves and eliminate them.[]", impact: 3, priority: 251, team: [.TeamVillage], availableEffects: [], image: #imageLiteral(resourceName: "villager"), isNightActiveRole: .NotNightActiveRole)

let VILLAGER_THREE = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "Villager’s sole purpose is to find the Werewolves and eliminate them.[]", impact: 3, priority: 252, team: [.TeamVillage], availableEffects: [], image: #imageLiteral(resourceName: "villager"), isNightActiveRole: .NotNightActiveRole)

let VILLAGER_FOUR = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "Villager’s sole purpose is to find the Werewolves and eliminate them.[]", impact: 3, priority: 253, team: [.TeamVillage], availableEffects: [], image: #imageLiteral(resourceName: "villager"), isNightActiveRole: .NotNightActiveRole)

let VILLAGER_FIVE = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "Villager’s sole purpose is to find the Werewolves and eliminate them.[]", impact: 3, priority: 254, team: [.TeamVillage], availableEffects: [], image: #imageLiteral(resourceName: "villager"), isNightActiveRole: .NotNightActiveRole)

let VILLAGER_SIX = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "Villager’s sole purpose is to find the Werewolves and eliminate them.[]", impact: 3, priority: 255, team: [.TeamVillage], availableEffects: [], image: #imageLiteral(resourceName: "villager"), isNightActiveRole: .NotNightActiveRole)

let VILLAGER_SEVEN = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "Villager’s sole purpose is to find the Werewolves and eliminate them.[]", impact: 3, priority: 256, team: [.TeamVillage], availableEffects: [], image: #imageLiteral(resourceName: "villager"), isNightActiveRole: .NotNightActiveRole)

let VILLAGER_EIGHT = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "Villager’s sole purpose is to find the Werewolves and eliminate them.[]", impact: 3, priority: 257, team: [.TeamVillage], availableEffects: [], image: #imageLiteral(resourceName: "villager"), isNightActiveRole: .NotNightActiveRole)

let VILLAGER_NINE = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "Villager’s sole purpose is to find the Werewolves and eliminate them.[]", impact: 3, priority: 258, team: [.TeamVillage], availableEffects: [], image: #imageLiteral(resourceName: "villager"), isNightActiveRole: .NotNightActiveRole)

let VILLAGER_TEN = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "Villager’s sole purpose is to find the Werewolves and eliminate them.[]", impact: 3, priority: 259, team: [.TeamVillage], availableEffects: [], image: #imageLiteral(resourceName: "villager"), isNightActiveRole: .NotNightActiveRole)

let VILLAGER_ELEVEN = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "Villager’s sole purpose is to find the Werewolves and eliminate them.[]", impact: 3, priority: 260, team: [.TeamVillage], availableEffects: [], image: #imageLiteral(resourceName: "villager"), isNightActiveRole: .NotNightActiveRole)

let VILLAGER_TWELVE = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "Villager’s sole purpose is to find the Werewolves and eliminate them.[]", impact: 3, priority: 261, team: [.TeamVillage], availableEffects: [], image: #imageLiteral(resourceName: "villager"), isNightActiveRole: .NotNightActiveRole)

let VILLAGER_THIRTEEN = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "Villager’s sole purpose is to find the Werewolves and eliminate them.[]", impact: 3, priority: 262, team: [.TeamVillage], availableEffects: [], image: #imageLiteral(resourceName: "villager"), isNightActiveRole: .NotNightActiveRole)

let VILLAGER_FOURTEEN = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "Villager’s sole purpose is to find the Werewolves and eliminate them.[]", impact: 3, priority: 263, team: [.TeamVillage], availableEffects: [], image: #imageLiteral(resourceName: "villager"), isNightActiveRole: .NotNightActiveRole)

let VILLAGER_FIFTEEN = Role(name: "Villager", type: .Villager, description: "Find the werewolves and eliminate them.", roleExplanation: "Villager’s sole purpose is to find the Werewolves and eliminate them.[]", impact: 3, priority: 264, team: [.TeamVillage], availableEffects: [], image: #imageLiteral(resourceName: "villager"), isNightActiveRole: .NotNightActiveRole)



let VIRGINIA_WOOLF = Role(name: "The Provider", type: .VirginiaWoolf, description: "The first night, choose a player that depends on you. If you are eliminated, that player is also eliminated.", roleExplanation: "The Provider is a caring and giving individual. So much so, that some people come to rely soley on them. The first night, the Provider chooses someone who has become dependent on them. That player is woken up and shown who they depend on. If the Provider is eliminated, so is that player.[]", impact: -2, priority: 97, team: [.TeamVillage], availableEffects: [.Dependent], image: #imageLiteral(resourceName: "virginiaWoolf"), isNightActiveRole: .NotNightActiveRole)




let WEREWOLF_ONE = Role(name: "Werewolf", type: .Werewolf, description: "Each night, wake with the other Werewolves and choose a player to eliminate.", roleExplanation: "The Werewolves learn the identity of the other Werewolves the first night; they do not kill the first night. Every night afterwards, the Werewolves must agree (only a majority is needed, and need not be unanimous) on a target to eliminate. If the Werewolves spend more than the alloted time determining a target for the night, they do not get to choose a target that night. The Werewolves may not target another Werewolf at night, unless the Leprechaun is in play.[]", impact: -6, priority: 25, team: [.TeamWerewolf], availableEffects: [], image: #imageLiteral(resourceName: "werewolf"), isNightActiveRole: .NightActiveRole)

let WEREWOLF_TWO = Role(name: "Werewolf", type: .Werewolf,description: "Each night, wake with the other Werewolves and choose a player to eliminate.", roleExplanation: "The Werewolves learn the identity of the other Werewolves the first night; they do not kill the first night. Every night afterwards, the Werewolves must agree (only a majority is needed, and need not be unanimous) on a target to eliminate. If the Werewolves spend more than the alloted time determining a target for the night, they do not get to choose a target that night. The Werewolves may not target another Werewolf at night, unless the Leprechaun is in play.[]", impact: -6, priority: 25, team: [.TeamWerewolf], availableEffects: [], image: #imageLiteral(resourceName: "werewolf"), isNightActiveRole: .NightActiveRole)

let WEREWOLF_THREE = Role(name: "Werewolf", type: .Werewolf, description: "Each night, wake with the other Werewolves and choose a player to eliminate.", roleExplanation: "The Werewolves learn the identity of the other Werewolves the first night; they do not kill the first night. Every night afterwards, the Werewolves must agree (only a majority is needed, and need not be unanimous) on a target to eliminate. If the Werewolves spend more than the alloted time determining a target for the night, they do not get to choose a target that night. The Werewolves may not target another Werewolf at night, unless the Leprechaun is in play.[]", impact: -6, priority: 25, team: [.TeamWerewolf], availableEffects: [], image: #imageLiteral(resourceName: "werewolf"), isNightActiveRole: .NightActiveRole)

let WEREWOLF_FOUR = Role(name: "Werewolf", type: .Werewolf, description: "Each night, wake with the other Werewolves and choose a player to eliminate.", roleExplanation: "The Werewolves learn the identity of the other Werewolves the first night; they do not kill the first night. Every night afterwards, the Werewolves must agree (only a majority is needed, and need not be unanimous) on a target to eliminate. If the Werewolves spend more than the alloted time determining a target for the night, they do not get to choose a target that night. The Werewolves may not target another Werewolf at night, unless the Leprechaun is in play.[]", impact: -6, priority: 25, team: [.TeamWerewolf], availableEffects: [], image: #imageLiteral(resourceName: "werewolf"), isNightActiveRole: .NightActiveRole)

let WEREWOLF_FIVE = Role(name: "Werewolf", type: .Werewolf, description: "Each night, wake with the other Werewolves and choose a player to eliminate.", roleExplanation: "The Werewolves learn the identity of the other Werewolves the first night; they do not kill the first night. Every night afterwards, the Werewolves must agree (only a majority is needed, and need not be unanimous) on a target to eliminate. If the Werewolves spend more than the alloted time determining a target for the night, they do not get to choose a target that night. The Werewolves may not target another Werewolf at night, unless the Leprechaun is in play.[]", impact: -6, priority: 25, team: [.TeamWerewolf], availableEffects: [], image: #imageLiteral(resourceName: "werewolf"), isNightActiveRole: .NightActiveRole)

let WEREWOLF_SIX = Role(name: "Werewolf", type: .Werewolf, description: "Each night, wake with the other Werewolves and choose a player to eliminate.", roleExplanation: "The Werewolves learn the identity of the other Werewolves the first night; they do not kill the first night. Every night afterwards, the Werewolves must agree (only a majority is needed, and need not be unanimous) on a target to eliminate. If the Werewolves spend more than the alloted time determining a target for the night, they do not get to choose a target that night. The Werewolves may not target another Werewolf at night, unless the Leprechaun is in play.[]", impact: -6, priority: 25, team: [.TeamWerewolf], availableEffects: [], image: #imageLiteral(resourceName: "werewolf"), isNightActiveRole: .NightActiveRole)

let WEREWOLF_SEVEN = Role(name: "Werewolf", type: .Werewolf, description: "Each night, wake with the other Werewolves and choose a player to eliminate.", roleExplanation: "The Werewolves learn the identity of the other Werewolves the first night; they do not kill the first night. Every night afterwards, the Werewolves must agree (only a majority is needed, and need not be unanimous) on a target to eliminate. If the Werewolves spend more than the alloted time determining a target for the night, they do not get to choose a target that night. The Werewolves may not target another Werewolf at night, unless the Leprechaun is in play.[]", impact: -6, priority: 25, team: [.TeamWerewolf], availableEffects: [], image: #imageLiteral(resourceName: "werewolf"), isNightActiveRole: .NightActiveRole)

let WEREWOLF_EIGHT = Role(name: "Werewolf", type: .Werewolf, description: "Each night, wake with the other Werewolves and choose a player to eliminate.", roleExplanation: "The Werewolves learn the identity of the other Werewolves the first night; they do not kill the first night. Every night afterwards, the Werewolves must agree (only a majority is needed, and need not be unanimous) on a target to eliminate. If the Werewolves spend more than the alloted time determining a target for the night, they do not get to choose a target that night. The Werewolves may not target another Werewolf at night, unless the Leprechaun is in play.[]", impact: -6, priority: 25, team: [.TeamWerewolf], availableEffects: [], image: #imageLiteral(resourceName: "werewolf"), isNightActiveRole: .NightActiveRole)

let WEREWOLF_NINE = Role(name: "Werewolf", type: .Werewolf, description: "Each night, wake with the other Werewolves and choose a player to eliminate.", roleExplanation: "The Werewolves learn the identity of the other Werewolves the first night; they do not kill the first night. Every night afterwards, the Werewolves must agree (only a majority is needed, and need not be unanimous) on a target to eliminate. If the Werewolves spend more than the alloted time determining a target for the night, they do not get to choose a target that night. The Werewolves may not target another Werewolf at night, unless the Leprechaun is in play.[]", impact: -6, priority: 25, team: [.TeamWerewolf], availableEffects: [], image: #imageLiteral(resourceName: "werewolf"), isNightActiveRole: .NightActiveRole)

let WEREWOLF_TEN = Role(name: "Werewolf", type: .Werewolf, description: "Each night, wake with the other Werewolves and choose a player to eliminate.", roleExplanation: "The Werewolves learn the identity of the other Werewolves the first night; they do not kill the first night. Every night afterwards, the Werewolves must agree (only a majority is needed, and need not be unanimous) on a target to eliminate. If the Werewolves spend more than the alloted time determining a target for the night, they do not get to choose a target that night. The Werewolves may not target another Werewolf at night, unless the Leprechaun is in play.[]", impact: -6, priority: 25, team: [.TeamWerewolf], availableEffects: [], image: #imageLiteral(resourceName: "werewolf"), isNightActiveRole: .NightActiveRole)

let WEREWOLF_ELEVEN = Role(name: "Werewolf", type: .Werewolf, description: "Each night, wake with the other Werewolves and choose a player to eliminate.", roleExplanation: "The Werewolves learn the identity of the other Werewolves the first night; they do not kill the first night. Every night afterwards, the Werewolves must agree (only a majority is needed, and need not be unanimous) on a target to eliminate. If the Werewolves spend more than the alloted time determining a target for the night, they do not get to choose a target that night. The Werewolves may not target another Werewolf at night, unless the Leprechaun is in play.[]", impact: -6, priority: 25, team: [.TeamWerewolf], availableEffects: [], image: #imageLiteral(resourceName: "werewolf"), isNightActiveRole: .NightActiveRole)

let WEREWOLF_TWELVE = Role(name: "Werewolf", type: .Werewolf, description: "Each night, wake with the other Werewolves and choose a player to eliminate.", roleExplanation: "The Werewolves learn the identity of the other Werewolves the first night; they do not kill the first night. Every night afterwards, the Werewolves must agree (only a majority is needed, and need not be unanimous) on a target to eliminate. If the Werewolves spend more than the alloted time determining a target for the night, they do not get to choose a target that night. The Werewolves may not target another Werewolf at night, unless the Leprechaun is in play.[]", impact: -6, priority: 25, team: [.TeamWerewolf], availableEffects: [], image: #imageLiteral(resourceName: "werewolf"), isNightActiveRole: .NightActiveRole)



let WITCH = Role(name: "Witch", type: .Witch, description: "You may save or eliminate a player at night, once each per game.", roleExplanation: "The Witch may use her power to prevent someone from being eliminated once during the game to save someone targeted at night. She may also use her other power to eliminate a player once during the game to eliminate the player of her choice. The Moderator should call the With every night and ask if she would like to use either or both of her special powers, even if they have been used. Both powers may be used on the same night.[]", impact: 4, priority: 118, team: [.TeamVillage], availableEffects: [.Protection, .Poison], image: #imageLiteral(resourceName: "witch"), isNightActiveRole: .NightActiveRole)



let WOLFCUB = Role(name: "Wolf Cub", type: .WolfCub, description: "Each night, wake with the Werewolves. If you are eliminated, the Werewolves eliminate two players the following night.", roleExplanation: "The Wolf Cub is a Werewolf, and wakes with them each night. If the Wolf Cub is eliminated, the Werewolves get to eliminate two players the next night.[]", impact: -8, priority: 7, team: [.TeamWerewolf], availableEffects: [], image: #imageLiteral(resourceName: "wolfCub"), isNightActiveRole: .NotNightActiveRole)



let WOLFMAN = Role(name: "Wolf Man", type: .WolfMan, description: "Each night, wake with the other Werewolves. The Seer sees you as a Villager.", roleExplanation: "The Wolf Man is a Werewolf but the Seer sees him as a Villager. The Wolf Man is a very powerful Werewolf team role.[]", impact: -9, priority: 13, team: [.TeamWerewolf], availableEffects: [], image: #imageLiteral(resourceName: "wolfMan"), isNightActiveRole: .NightActiveRole)



let ZOMBIE = Role(name: "Zombie", type: .Zombie, description: "Each night, pick a player and eat their brains. That player may no longer vote.", roleExplanation: "The zombie eats the brains of a different player each night. The Moderator says whose brain was eaten when the village awakes. From that point on in the game, players with no brains may not take part in the vote to lynch during the day. If at any time all remaining players have no brains, the Zombie wins.[]", impact: -3, priority: 112, team: [.TeamZombie], availableEffects: [.Lobotomy], image: #imageLiteral(resourceName: "zombie"), isNightActiveRole: .NightActiveRole)


// MARK: - Team roles

let BLOB_TEAM = Role(name: "The Blob", type: .TheBlob, description: "Each night, the player to the right of The Blob is absorbed. If all players are part of The Blob, the original Blob players wins.", roleExplanation: "Each night, the Blob absorbs one player to the right of the Blob. If all players are part of The Blob, The Blob player wins, even if he has been eliminated.[]", impact: -1, priority: 151, team: [.TeamBlob], availableEffects: [], image: #imageLiteral(resourceName: "theBlob"), isNightActiveRole: .NightActiveRole)



let WEREWOLF_TEAM = Role(name: "The Werewolves", type: .Werewolf, description: "All werewolves wake up and choose a player to eliminate.", roleExplanation: "The Werewolf team members learn the identity of the other Werewolves the first night. Every night after the first night, the Werewolves must agree on a target to eliminate. If the Werewolves spend more than a minute determining a target for the night, they do not get to choose a target that night. The Werewolves may not target another Werewolf at night. Werewolves try to keep their identity a secret during the day.[]", impact: 0, priority: 25, team: [.TeamWerewolf], availableEffects: [], image: #imageLiteral(resourceName: "werewolf"), isNightActiveRole: .NightActiveRole)
