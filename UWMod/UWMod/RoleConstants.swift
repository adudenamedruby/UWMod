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



let BODYGUARD = Role(name: "Bodyguard",
                     type: .Bodyguard,
                     description: "Chooses a player to protect from elimination. Activated each night; chosen player must be different from previous night.",
                     roleExplanation: "The Bodyguard is woken every night and must choose a player to protect. That player is safe from elimination by any means that night. The chosen player cannot be the same player twice in a row, but the same player may be chosen multiple times per game. The Moderator does not point out to the Bodyguard who is going to be eliminated that night. Finally, the Bodyguard cannot protect himself.\n\n[Once a mercenary, the Bodyguard settled in the Village wanting to leave constantly travelling behind him. He now makes a living by selling his protection services to anyone in the village that is willing to hire him. His unwavering trust in his shield has not, so far, let him down.]",
                     impact: 3,
                     priority: 52,
                     team: [.TeamVillage],
                     availableEffects: [.Protection],
                     image: #imageLiteral(resourceName: "bodyguard"),
                     isNightActiveRole: .NightActiveRole)



let CULTLEADER = Role(name: "Cult Leader",
                      type: .CultLeader,
                      description: "Wake every night. Must choose a player to join their cult. If all living players in the game are part of the cult, the Cult Leader wins.",
                      roleExplanation: "The Cult Leader is woken up every night and points to a person that will join the cult. All players that are part of the cult do not know they are part of the cult - just like in real life! Even though he appears as a villager, the Cult Leader only wins if all players left in the game are part of the cult. Other teams may still fulfill victory contidions. The Cult Leader does not need to be alive to win.\n\n[Plagued by disturbing dreams, this former farmer began to preach to anyone that would listen. Slowly, over time, more and more people began to pay attention and joined the secret gatherings he held while he promised them a utopian paradise on earth. If only the others realized that they had become cultists in his fevered scheme.]",
                      impact: 1,
                      priority: 70,
                      team: [.TeamCult],
                      availableEffects: [],
                      image: #imageLiteral(resourceName: "cultLeader"),
                      isNightActiveRole: .NightActiveRole)



let CUPID = Role(name: "Eros",
                 type: .Cupid,
                 description: "Wakeon the first night. Chooses two players to be linked together. If one of them is eliminated, the other dies as well.",
                 roleExplanation: "Eros wakes up during the first night and points at two players. He may choose himself, as one of the two players. The Moderator then wakes up the two lovebirds the first night by tapping them on the shoulder so they can see who the other sweetheart is. Eros should have closed their eyes by this point in time, if not one of the two lovers. If either of the lovers is eliminated, for any reason, the other is also eliminated instantly.\n\nThe lovers fall under a few special victory conditions. If both lovers are on the village team, they win with the village team. Similarly, ff they are both on the werewolf team, they win with the werewolf team. However, if the two lovers find themselves on different teams, they relinquish all other ties, become their own team, and only win if they are the last two players in the game. Being a Lovebird overrides all other winning conditions.\n\n[The god-child Eros has assumed human disguise and walks, hidden, amongst the villagers. Though thought long extinct, these possessive walkabouts greatly amused the ethereal gods, until, of course, people became suspicious of the posessed and decided to do something about it. However, Eros was a simple being, whose pleasure lay in making others fall, dangerously, in love. To the point that if one of the lovers died, the other would literally drop of heartbreak.]",
                 impact: -3,
                 priority: 76,
                 team: [.TeamVillage],
                 availableEffects: [.Lovestruck],
                 image: #imageLiteral(resourceName: "cupid"),
                 isNightActiveRole: .NotNightActiveRole)



let CURSED = Role(name: "Cursed",
                  type: .Cursed,
                  description: "Starts on the village team. If eliminated by werewolves, turns into a werewolf and joins that team.",
                  roleExplanation: "The Cursed starts the game on the village team and they act for the benefit of the village. That is, unless they are targeted for elimination by the werewolves, at which point they then join the werewolf team instead of being eliminated. Every night, the Moderator should wake the Cursed to let them know if they have switched teams. Once the Cursed has switched teams, the Moderator should continue to call the role, so the players do not know he has been changed.).\n\n[His family had long been cursed, it had been said. Of course, no-one took these sorts of things seriously. Ancient curses were just stories, after all, told to childern to quiet them at night. Little did any villager know that this curse was bound by blood and bone and was as real as the Old Man's arthiritis. Hopefully, the werewolves don't attack him, for if they do, the villagers not only lose a trusted member of their community, but their enemiens grow in numbers.]",
                  impact: -3,
                  priority: 5,
                  team: [.TeamVillage],
                  availableEffects: [],
                  image: #imageLiteral(resourceName: "cursed"),
                  isNightActiveRole: .NightActiveRole)

let CURSED_WEREWOLF = Role(name: "Werewolf",
                           type: .Werewolf,
                           description: "Each night, wake with the other Werewolves and choose a player to eliminate.",
                           roleExplanation: "The Werewolves wake up the first night to learn the identity of the other Werewolves. They do not kill at this time. Every night afterwards, the Werewolves must agree (only a majority is needed, and the victim need not be unanimously selected) on a target to eliminate. If the Werewolves spend more than the alloted time determining a target for the night, they do not get to choose a target that night. The Werewolves may not target another Werewolf at night, unless the Leprechaun is in play.\n\n[No-one knows where the Werewolves come from. Some say they are as old as fear itself, born of the terror of human's early days. Whatever their origin, one thing is for sure: they are an unwanted, violent predator. The best hope for people to survive this sudden onslaught, is to band together, figure out who to trust, and lynch the werewolves once and for all.]",
                           impact: -6,
                           priority: 25,
                           team: [.TeamWerewolf],
                           availableEffects: [],
                           image: #imageLiteral(resourceName: "werewolf"),
                           isNightActiveRole: .NightActiveRole)



let DISEASED = Role(name: "Diseased",
                    type: .Diseased,
                    description: "If this player is eliminated by the Werewolves, they don't get to eliminate anyone the following night.",
                    roleExplanation: "If the Werewolves target the Diseased player for elimination, they catch a viral infection which prevents them from eliminating anyone during the next night. If the game does not have role reveal, the werewolves still pick a target the following night, but that target is not eliminated.\n\n[Sick and bedridden with some unidentified disease that is wreaking havock upon his body, this villager seems to be an easy target for the werewolves. Few villagers have even dared to step in the patient's home for fear of catching the disease.]",
                    impact: 3,
                    priority: 88,
                    team: [.TeamVillage],
                    availableEffects: [],
                    image: #imageLiteral(resourceName: "diseased"),
                    isNightActiveRole: .NotNightActiveRole)



let DREAMWOLF = Role(name: "Dreamwolf",
                     type: .Dreamwolf,
                     description: "Only wakes with the other werewolves once the village has killed a werewolf.",
                     roleExplanation: "The Dreamwolf is a werewolf, but doesn’t know who the other werewolves are as she doesn't wake up with them the first night. Furthermore, she doesn’t wake up in the night with her fellow pack until another werewolf is eliminated. The other werewolves don’t know who she is until she awakes with them at night. The Seer sees the Dreamwolf as a werewolf from the beginning of the game.\n\n[Spelled by an enchantress in the forest, the Dreamwolf is trapped in a deep sleep that can only be broken by the smell of a fellow werewolves' spilled blood. And so she sleeps, unbeknownst to anyone in the village. Woe to the village if they kill a werewolf and awaken her wrath.]",
                     impact: -5,
                     priority: 16,
                     team: [.TeamWerewolf],
                     availableEffects: [],
                     image: #imageLiteral(resourceName: "dreamwolf"),
                     isNightActiveRole: .NightActiveRole)



let GHOST = Role(name: "Phantom",
                 type: .Ghost,
                 description: "Dies on the first night and observes the night round. Then provides the village a single letter clue each day.",
                 roleExplanation: "The Phantom is the spirit of a villager that has perished the first night. The Phantom will watch each night round and, for the first ten rounds, will provide a single letter clue, as a message from beyond to the village. There are a few limitations: the Phantom may not attempt to identify any player by name or initials. The Phantom should try to be as helpful as possible with their clues, but, must try and remain calm if people are mis-interpreting their clues.\n\n[An old woman, loved by her family friends, passes away in the night. Her soul, however, seems to linger, tied to her ancestral family home. That very soul witnesses the brutal werewolf attacks and tries to warn the village by leaving messages on steamed mirrors or in wet tea leaves at the bottom of empty cups.]",
                 impact: 2,
                 priority: 1,
                 team: [.TeamVillage],
                 availableEffects: [],
                 image: #imageLiteral(resourceName: "ghost"),
                 isNightActiveRole: .NotNightActiveRole)



let HUNTER = Role(name: "Huntsman",
                  type: .Hunter,
                  description: "If eliminated, the Huntsman may immediately eliminate another player.",
                  roleExplanation: "When the Huntsman is eliminated - whether by wolves or by being lynched -  he will choose another player to be his target, and that player is also eliminated. The Huntsman may also choose to die nobly, if he doesn't suspect anyone, and fire his weapon in the air, resulting in no additional elimination. No one may speak while the Huntsman chooses a target. If eliminated at night, the Huntsman chooses his target first thing in the morning.\n\n[His legend preceeded him as he rode into the village and everyone instantly recognized the Huntsman as he sat astride his horse. Hired by the town's mayor to help kill the werewolves, the Huntsman knows that paranoia and fear can often lead a town astray, causing suspicion where there should be none. His face grim, he is prepared to go down fighting.]",
                  impact: 3,
                  priority: 61,
                  team: [.TeamVillage],
                  availableEffects: [],
                  image: #imageLiteral(resourceName: "hunter"),
                  isNightActiveRole: .NotNightActiveRole)



let INSOMNIAC = Role(name: "Insomniac",
                     type: .Insomniac,
                     description: "Each night, they are told if least one of their neighbors has taken a night action.",
                     roleExplanation: "Waking up last every night, the Insomniac is told by the Moderator if anyone woke up at night who is sitting next to them. They are told this informaiton even if that role has an option to not use it's action - like the Witch. The Moderator should not tell the Insomniac which player sitting next to them woke up at night, just that at least one of those players woke up that night. Regular adjaceny rules apply with the expection that if a player next to to the Insomniac is eliminated at night, he is informed about that player's actions and not the player next to the eliminated player.\n\n[The night is long and some villagers can only manage a fitful sleep. Noises, natural or unnatural, easily startle the Insomniac, who, anxiously, waits for the night to pass under the covers.]",
                     impact: 3,
                     priority: 199,
                     team: [.TeamVillage],
                     availableEffects: [],
                     image: #imageLiteral(resourceName: "insomniac"),
                     isNightActiveRole: .NightActiveRole)



let LONE_WOLF = Role(name: "Lone Wolf",
                     type: .LoneWolf,
                     description: "Wakes with the other Werewolves at night, but only wins if they are the last wolf in the game.",
                     roleExplanation: "The Lone Wolf only wins if he is the last player standing (or achieves parity with the village by having only one other non-werewolf player left in the game). The Lone Wolf, however, does wake up with the werewolves to choose a target each night.\n\n[Most wolves are pack animals... but this werewolf still retains much of the personality from when he was human. Strong willed and intelligent, the Lone Wolf prefers to spend time alone, away from the pack. Perhaps because he thinks that seeking cover in the crowd is an easy way to bring suspicion upon one's self.]",
                     impact: -5,
                     priority: 202,
                     team: [.TeamWerewolf],
                     availableEffects: [],
                     image: #imageLiteral(resourceName: "loneWolf"),
                     isNightActiveRole: .NightActiveRole)



let LYCAN = Role(name: "Lycan",
                 type: .Lycan,
                 description: "A villager that appears as a Werewolf to the Seer.",
                 roleExplanation: "The Lycan is a villager and plays for the village team. However, when the seer investigates her, she appears as a Werewolf.\n\n[An orphan whose parentage was always questionable, she learned to read and write and now works as a town notary. Unbeknownst to anyone, however, she has found out that her maily was affected by werewolfism far back in her family history. Trying to keep this information secret, she has burned all official documentation that makes mention of this. For now her secret is safe... unless the Seer decides to turn his gaze to her.]",
                 impact: -1,
                 priority: 205,
                 team: [.TeamVillage],
                 availableEffects: [],
                 image: #imageLiteral(resourceName: "lycan"),
                 isNightActiveRole: .NotNightActiveRole)



let MAD_BOMBER = Role(name: "Mad Bomber",
                      type: .MadBomber,
                      description: "If eliminated, the players immediately to the bomber's left and right are eliminated as well.",
                      roleExplanation: "If the Mad Bomber is eliminated, the player closest to him on both the right and left of him is eliminated instantly. The right player is eliminated before the left player (this can matter in certain situations). The Moderator may also allow only one player to be eliminated. In that case, the Bomber chooses to eliminate either the player to their left or right.\n\n[Bombs! He loves bombs! Bom-bom-bom ba-bom-bom-bom bombs!!]",
                      impact: -2,
                      priority: 109,
                      team: [.TeamVillage],
                      availableEffects: [],
                      image: #imageLiteral(resourceName: "madBomber"),
                      isNightActiveRole: .NotNightActiveRole)



let MAYOR = Role(name: "Mayor",
                 type: .Mayor,
                 description: "The Mayor's vote counts twice.",
                 roleExplanation: "As the democratically elected leader of the village, the Mayor’s voice carries weight in the community and, as such, their vote counts twice when voting to eliminate a player. This is done by the Moderator secretly counting the Mayor’s vote twice.\n\n[They called it democracy, but the last time an election was held in the village... well, dinasoaurs were what people were worried about then, not werewolves.]",
                 impact: 2,
                 priority: 124,
                 team: [.TeamVillage],
                 availableEffects: [],
                 image: #imageLiteral(resourceName: "mayor"),
                 isNightActiveRole: .NotNightActiveRole)



let MASON_ONE = Role(name: "Mason",
                     type: .Mason,
                     description: "Wakes up the first night to see who the other Masons are.",
                     roleExplanation: "The first night the Moderator calls for the Masons to open their eyes and look for the other Masons. Starting on the first day, no one in the village may directly or indirectly speak of the Masons. There are two penalties for players that speak of them: the first person to speak of the Masons is visited by the Masons at night and is silenced... for the rest of the game! Any players that mention the Masons afterwards are eliminated that night by the secret society in order to keep it a secret. If they are eliminated by the secret society, they automatically lose, even if they are on a winning team.\n\nImportant notes for the Moderator: use discretion. It's much better for gameplay if the subject is never discussed directly or indirectly by the players. If a player says, 'Well, we know these three are safe.' that's a clear reference to the Masons, so that player should be eliminated.\n\n[The first rule of the Masons Club is that you......]",
                     impact: 2,
                     priority: 121,
                     team: [.TeamVillage],
                     availableEffects: [],
                     image: #imageLiteral(resourceName: "mason"),
                     isNightActiveRole: .NotNightActiveRole)

let MASON_TWO = Role(name: "Mason",
                     type: .Mason,
                     description: "Wakes up the first night to see who the other Masons are.",
                     roleExplanation: "The first night the Moderator calls for the Masons to open their eyes and look for the other Masons. Starting on the first day, no one in the village may directly or indirectly speak of the Masons. There are two penalties for players that speak of them: the first person to speak of the Masons is visited by the Masons at night and is silenced... for the rest of the game! Any players that mention the Masons afterwards are eliminated that night by the secret society in order to keep it a secret. If they are eliminated by the secret society, they automatically lose, even if they are on a winning team.\n\nImportant notes for the Moderator: use discretion. It's much better for gameplay if the subject is never discussed directly or indirectly by the players. If a player says, 'Well, we know these three are safe.' that's a clear reference to the Masons, so that player should be eliminated.\n\n[The first rule of the Masons Club is that you......]",
                     impact: 2,
                     priority: 121,
                     team: [.TeamVillage],
                     availableEffects: [],
                     image: #imageLiteral(resourceName: "mason"),
                     isNightActiveRole: .NotNightActiveRole)

let MASON_THREE = Role(name: "Mason",
                       type: .Mason,
                       description: "Wakes up the first night to see who the other Masons are.",
                       roleExplanation: "The first night the Moderator calls for the Masons to open their eyes and look for the other Masons. Starting on the first day, no one in the village may directly or indirectly speak of the Masons. There are two penalties for players that speak of them: the first person to speak of the Masons is visited by the Masons at night and is silenced... for the rest of the game! Any players that mention the Masons afterwards are eliminated that night by the secret society in order to keep it a secret. If they are eliminated by the secret society, they automatically lose, even if they are on a winning team.\n\nImportant notes for the Moderator: use discretion. It's much better for gameplay if the subject is never discussed directly or indirectly by the players. If a player says, 'Well, we know these three are safe.' that's a clear reference to the Masons, so that player should be eliminated.\n\n[The first rule of the Masons Club is that you......]",
                       impact: 2,
                       priority: 121,
                       team: [.TeamVillage],
                       availableEffects: [],
                       image: #imageLiteral(resourceName: "mason"),
                       isNightActiveRole: .NotNightActiveRole)



let MINION = Role(name: "Minion",
                  type: .Minion,
                  description: "Finds out, on the first night, who the werewolves are, but does not wake up with them at night.",
                  roleExplanation: "The first night, the Minion learns who the werewolves are, but does not wake with them at night. The Seer sees the Minion as a villager.\n\n[There's always one, isn't there? That one guy on the good guy team who tries to infiltrate the bad guys but gets lots and ends up being a puppet for them. This, is that guy.]",
                  impact: -6,
                  priority: 40,
                  team: [.TeamWerewolf],
                  availableEffects: [],
                  image: #imageLiteral(resourceName: "minion"),
                  isNightActiveRole: .NotNightActiveRole)



let PACIFIST = Role(name: "Pacifist",
                    type: .Pacifist,
                    description: "Always votes for players to not be eliminated.",
                    roleExplanation: "The Pacifist, abhorring violence, always votes agaist a lynch.\n\n[Damn hippies.]",
                    impact: -1,
                    priority: 79,
                    team: [.TeamVillage],
                    availableEffects: [],
                    image: #imageLiteral(resourceName: "pacifist"),
                    isNightActiveRole: .NotNightActiveRole)



let PRIEST = Role(name: "Monk",
                  type: .Priest,
                  description: "One night, once per game, chooses a player to bless. That player may not be eliminated at night.",
                  roleExplanation: "Every game, once per night, the Priest can choose someone to protect. The Moderator should wake the Priest, show them who is going to be eliminated, and give them the option to use their power to save that player from any form of elimination. The Priest cannot choose himself, even if he hasn't used his power and he is the current target.\n\n[Tending to the monestary at the edge of town, the Monk lives a solitary life. Despite the recent attacks on the village, he refuses to leave his home. He is ever ready to bless those who come seeking salvation.]",
                  impact: 3,
                  priority: 172,
                  team: [.TeamVillage],
                  availableEffects: [.Protection],
                  image: #imageLiteral(resourceName: "priest"),
                  isNightActiveRole: .NightActiveRole)



let SEER = Role(name: "Seer",
                type: .Seer,
                description: "Each night chooses a player to learn if they are a Villager or a Werewolf.",
                roleExplanation: "Each night, the Seer chooses a player by pointing at them, and the Moderator tells her, through a thumbs up - for villager - or a thumbs down - for a werewolf - what that player's affiliation is. While this is generally great information, the Seer should be careful when certain roles are in the game, like the Minion, the Wolfman or the Lycan, as the information they are receiving can be imperfect.\n\n[Despite being feared in the village, the village has begrudgingly come to accept and rely on the Seer. For everything from what the crops will be like to finding lost children, villagers visit the Seer's house on a daily basis and leave food, clothes and other items of sustenance as payment. The Seer, in return, helps as much as they can, knowing that their survival relies on the goodwill of the village.]",
                impact: 4,
                priority: 181,
                team: [.TeamVillage],
                availableEffects: [.Protection],
                image: #imageLiteral(resourceName: "seer"),
                isNightActiveRole: .NightActiveRole)




let SORCERESS = Role(name: "Sorceress",
                     type: .Sorceress,
                     description: "Wakes up every night tries to find the Seer.",
                     roleExplanation: "Following the first night, the Sorceress wakes up and inspects a player each night to find out if that player is the Seer. The Moderator confirms the role with a simple thumbs up or thumbs down. Unlike the Minion, not only do the werewolves not know who the Sorceress is, she does not know who the werewolves are either.\n\n[The Sorceress arrived in the village but a fortnight ago and already, the men of the village have been captivated by her beauty. The women of the village are wary, for they know this sort of woman is dangerous, and so are trying to keep their husbands heads clear of her influence. But it may be too late, for she may have seduced information about the Seer from some weak willed men.]",
                     impact: -3,
                     priority: 190,
                     team: [.TeamWerewolf],
                     availableEffects: [],
                     image: #imageLiteral(resourceName: "sorceress"),
                     isNightActiveRole: .NightActiveRole)



let SPELLCASTER = Role(name: "Spellslinger",
                       type: .Spellcaster,
                       description: "Each night, chooses a player to silence the following day.",
                       roleExplanation: "The Spellslinger's power is optional. However, they may use it each night to silence a player for the next day. That player cannot speak, but may try and communicate another way. If the Spellslinger wishes, they may silence themselves. Furthermore, they may only silence each player once per game.\n\n[Born to a wealthy land-owner, the Spellslinger realized their power at a young age and, wisely, decided to hide it. Now, they delight is causing some panic by secretly silencing people, unbeknownst to anyone else as to why people sometimes go mute.]",
                       impact: 1,
                       priority: 148,
                       team: [.TeamVillage],
                       availableEffects: [.Silence],
                       image: #imageLiteral(resourceName: "spellcaster"),
                       isNightActiveRole: .NightActiveRole)



let THE_BLOB = Role(name: "The Hivemind",
                    type: .TheBlob,
                    description: "Each night, the Hivemind assimilates another player to the right of the last assimilated player. If all players are part of the Hivemind, you win.",
                    roleExplanation: "Each night, the Hivemind absorbs one player to the right of last player added that's currently alive. If all players are part of the Hivemind, the Hivemind player wins, even if he has been eliminated.\n\n[It started off with a child that stumbled into the forest in the middle of the night, chasing a shadow hanging in the sky. The next day, he was... different. And anyone that visited him and tried to help always came out of the hut acting the same way as the child. Nobody knows what's happening.]",
                    impact: -1,
                    priority: 151,
                    team: [.TeamBlob],
                    availableEffects: [],
                    image: #imageLiteral(resourceName: "theBlob"),
                    isNightActiveRole: .NightActiveRole)



let THE_COUNT = Role(name: "The Count",
                     type: .TheCount,
                     description: "Is told, on the first night, how many Werewolves are in each half of the village.",
                     roleExplanation: "The Count wakes up on the first night. The Moderator, after indicating where the village splits in half directly across from the Count, shows the Count how many wolves are in each half of the village. He can do this by pointing to a half and holding up the number of fingers equal to the number of werewolves in that half. It should be noted that the smaller the game, the more effective this role is. It is also strongly reccommended to not use this role if there is only one werewolf in the game... unless everyone is a very experienced player.\n\n[The most important noble in the region, the Count keeps meticulous track of his accounts, crop yelds, and anything, really, that affects the village. As much a scholar as he is a gentleman of leisure, the Count frequently comes to some startling realizations about the village as he combs over the numbers in his ledgers.]",
                     impact: 5,
                     priority: 106,
                     team: [.TeamVillage],
                     availableEffects: [],
                     image: #imageLiteral(resourceName: "theCount"),
                     isNightActiveRole: .NotNightActiveRole)



let TANNER = Role(name: "Tanner",
                  type: .Tanner,
                  description: "Only wins if he is eliminated.",
                  roleExplanation: "The Tanner only wins if he is eliminated. Victory conditions for the other teams are still present and the game continues after the Tanner wins.\n\n[After years of tanning leather and hides, being surrounded by the smell of death handling the viscera of animals, the Tanner has lost sight of what makes life worth living. Now, all he can think about, is dying. But, as a religious man, he cannot kill himself. So his new purpose in life is to convince the village or the secret werewolves, that he should be killed.]",
                  impact: -2,
                  priority: 58,
                  team: [.TeamTanner],
                  availableEffects: [],
                  image: #imageLiteral(resourceName: "tanner"),
                  isNightActiveRole: .NotNightActiveRole)



let THING = Role(name: "The Bother",
                 type: .TheThing,
                 description: "Each night, taps a player sitting immediately next to him.",
                 roleExplanation: "The Bother wakes up each night and must tap one of the players that sits next to him. Regular adjacency rules apply: the person next to you is the person next to you that is currently alive this round, regardless of what has happened this far (ie. even if they've been marked for elimination). While the Bother is in play, no other players may tap or touch anyone else or at any other time during the night.\n\n[He's that villger that always stands slightly too close, speaks slightly too loud, is friendlier with his hands than he should be. He has no concept of personal space and many people in the village always try to avoid him.]",
                 impact: 3,
                 priority: 157,
                 team: [.TeamVillage],
                 availableEffects: [],
                 image: #imageLiteral(resourceName: "theThing"),
                 isNightActiveRole: .NightActiveRole)



let TROUBLEMAKER = Role(name: "Troublemaker",
                        type: .Troublemaker,
                        description: "One night per game, calls for an additional player to be eliminated the following day.",
                        roleExplanation: "Once per game, the Troublemaker can call for two eliminations the following day. Until she does this, she is woken up by the Moderator each night.\n\n[Raised in the city, the Troublemaker was kicked out of the city after inciting trouble for the city guard. After wandering around for a while, she's decided to kick back and relax in the village inn for a while. Some might say, with the recent werewolves attack, that it was poor timing. But she just sees it as an interesting opportunity to raise more trouble.]",
                        impact: -3,
                        priority: 175,
                        team: [.TeamVillage],
                        availableEffects: [.Delinquency],
                        image: #imageLiteral(resourceName: "troublemaker"),
                        isNightActiveRole: .NightActiveRole)



let VILLAGE_IDIOT = Role(name: "Village Idiot",
                         type: .VillageIdiot,
                         description: "Always votes for players to be eliminated.",
                         roleExplanation: "The Village Idiot always votes to lynch players, causing havok amongst players' suspicions.\n\n[Always in the wrong place, at the wrong time, doing the wrong thing, to the wrong person. Will he never learn?]",
                         impact: 2,
                         priority: 208,
                         team: [.TeamVillage],
                         availableEffects: [],
                         image: #imageLiteral(resourceName: "villageIdiot"),
                         isNightActiveRole: .NotNightActiveRole)



let VILLAGER_ONE = Role(name: "Villager",
                        type: .Villager,
                        description: "Doesn't do anything special aside from finding the werewolves to eliminate them.",
                        roleExplanation: "The Villager’s sole purpose is to find the Werewolves and eliminate them.\n\n[A farmer. A sheppard. A potter. A daughter. These are the innocents, average citizens of the village.]", impact: 3,
                        priority: 250,
                        team: [.TeamVillage],
                        availableEffects: [],
                        image: #imageLiteral(resourceName: "villager"),
                        isNightActiveRole: .NotNightActiveRole)

let VILLAGER_TWO = Role(name: "Villager",
                        type: .Villager,
                        description: "Doesn't do anything special aside from finding the werewolves to eliminate them.",
                        roleExplanation: "The Villager’s sole purpose is to find the Werewolves and eliminate them.\n\n[A farmer. A sheppard. A potter. A daughter. These are the innocents, average citizens of the village.]",
                        impact: 3,
                        priority: 251,
                        team: [.TeamVillage],
                        availableEffects: [],
                        image: #imageLiteral(resourceName: "villager"),
                        isNightActiveRole: .NotNightActiveRole)

let VILLAGER_THREE = Role(name: "Villager",
                          type: .Villager,
                          description: "Doesn't do anything special aside from finding the werewolves to eliminate them.",
                          roleExplanation: "The Villager’s sole purpose is to find the Werewolves and eliminate them.\n\n[A farmer. A sheppard. A potter. A daughter. These are the innocents, average citizens of the village.]",
                          impact: 3,
                          priority: 252,
                          team: [.TeamVillage],
                          availableEffects: [],
                          image: #imageLiteral(resourceName: "villager"),
                          isNightActiveRole: .NotNightActiveRole)

let VILLAGER_FOUR = Role(name: "Villager",
                         type: .Villager,
                         description: "Doesn't do anything special aside from finding the werewolves to eliminate them.",
                         roleExplanation: "The Villager’s sole purpose is to find the Werewolves and eliminate them.\n\n[A farmer. A sheppard. A potter. A daughter. These are the innocents, average citizens of the village.]",
                         impact: 3,
                         priority: 253,
                         team: [.TeamVillage],
                         availableEffects: [],
                         image: #imageLiteral(resourceName: "villager"),
                         isNightActiveRole: .NotNightActiveRole)

let VILLAGER_FIVE = Role(name: "Villager",
                         type: .Villager,
                         description: "Doesn't do anything special aside from finding the werewolves to eliminate them.",
                         roleExplanation: "The Villager’s sole purpose is to find the Werewolves and eliminate them.\n\n[A farmer. A sheppard. A potter. A daughter. These are the innocents, average citizens of the village.]",
                         impact: 3,
                         priority: 254,
                         team: [.TeamVillage],
                         availableEffects: [],
                         image: #imageLiteral(resourceName: "villager"),
                         isNightActiveRole: .NotNightActiveRole)

let VILLAGER_SIX = Role(name: "Villager",
                        type: .Villager,
                        description: "Doesn't do anything special aside from finding the werewolves to eliminate them.",
                        roleExplanation: "The Villager’s sole purpose is to find the Werewolves and eliminate them.\n\n[A farmer. A sheppard. A potter. A daughter. These are the innocents, average citizens of the village.]",
                        impact: 3,
                        priority: 255,
                        team: [.TeamVillage],
                        availableEffects: [],
                        image: #imageLiteral(resourceName: "villager"),
                        isNightActiveRole: .NotNightActiveRole)

let VILLAGER_SEVEN = Role(name: "Villager",
                          type: .Villager,
                          description: "Doesn't do anything special aside from finding the werewolves to eliminate them.",
                          roleExplanation: "The Villager’s sole purpose is to find the Werewolves and eliminate them.\n\n[A farmer. A sheppard. A potter. A daughter. These are the innocents, average citizens of the village.]",
                          impact: 3,
                          priority: 256,
                          team: [.TeamVillage],
                          availableEffects: [],
                          image: #imageLiteral(resourceName: "villager"),
                          isNightActiveRole: .NotNightActiveRole)

let VILLAGER_EIGHT = Role(name: "Villager",
                          type: .Villager,
                          description: "Doesn't do anything special aside from finding the werewolves to eliminate them.",
                          roleExplanation: "The Villager’s sole purpose is to find the Werewolves and eliminate them.\n\n[A farmer. A sheppard. A potter. A daughter. These are the innocents, average citizens of the village.]",
                          impact: 3,
                          priority: 257,
                          team: [.TeamVillage],
                          availableEffects: [],
                          image: #imageLiteral(resourceName: "villager"),
                          isNightActiveRole: .NotNightActiveRole)

let VILLAGER_NINE = Role(name: "Villager",
                         type: .Villager,
                         description: "Doesn't do anything special aside from finding the werewolves to eliminate them.",
                         roleExplanation: "The Villager’s sole purpose is to find the Werewolves and eliminate them.\n\n[A farmer. A sheppard. A potter. A daughter. These are the innocents, average citizens of the village.]",
                         impact: 3,
                         priority: 258,
                         team: [.TeamVillage],
                         availableEffects: [],
                         image: #imageLiteral(resourceName: "villager"),
                         isNightActiveRole: .NotNightActiveRole)

let VILLAGER_TEN = Role(name: "Villager",
                        type: .Villager,
                        description: "Doesn't do anything special aside from finding the werewolves to eliminate them.",
                        roleExplanation: "The Villager’s sole purpose is to find the Werewolves and eliminate them.\n\n[A farmer. A sheppard. A potter. A daughter. These are the innocents, average citizens of the village.]",
                        impact: 3,
                        priority: 259,
                        team: [.TeamVillage],
                        availableEffects: [],
                        image: #imageLiteral(resourceName: "villager"),
                        isNightActiveRole: .NotNightActiveRole)

let VILLAGER_ELEVEN = Role(name: "Villager",
                           type: .Villager,
                           description: "Doesn't do anything special aside from finding the werewolves to eliminate them.",
                           roleExplanation: "The Villager’s sole purpose is to find the Werewolves and eliminate them.\n\n[A farmer. A sheppard. A potter. A daughter. These are the innocents, average citizens of the village.]",
                           impact: 3,
                           priority: 260,
                           team: [.TeamVillage],
                           availableEffects: [],
                           image: #imageLiteral(resourceName: "villager"),
                           isNightActiveRole: .NotNightActiveRole)

let VILLAGER_TWELVE = Role(name: "Villager",
                           type: .Villager,
                           description: "Doesn't do anything special aside from finding the werewolves to eliminate them.",
                           roleExplanation: "The Villager’s sole purpose is to find the Werewolves and eliminate them.\n\n[A farmer. A sheppard. A potter. A daughter. These are the innocents, average citizens of the village.]",
                           impact: 3,
                           priority: 261,
                           team: [.TeamVillage],
                           availableEffects: [],
                           image: #imageLiteral(resourceName: "villager"),
                           isNightActiveRole: .NotNightActiveRole)

let VILLAGER_THIRTEEN = Role(name: "Villager",
                             type: .Villager,
                             description: "Doesn't do anything special aside from finding the werewolves to eliminate them.",
                             roleExplanation: "The Villager’s sole purpose is to find the Werewolves and eliminate them.\n\n[A farmer. A sheppard. A potter. A daughter. These are the innocents, average citizens of the village.]",
                             impact: 3,
                             priority: 262,
                             team: [.TeamVillage],
                             availableEffects: [],
                             image: #imageLiteral(resourceName: "villager"),
                             isNightActiveRole: .NotNightActiveRole)

let VILLAGER_FOURTEEN = Role(name: "Villager",
                             type: .Villager,
                             description: "Doesn't do anything special aside from finding the werewolves to eliminate them.",
                             roleExplanation: "The Villager’s sole purpose is to find the Werewolves and eliminate them.\n\n[A farmer. A sheppard. A potter. A daughter. These are the innocents, average citizens of the village.]",
                             impact: 3,
                             priority: 263,
                             team: [.TeamVillage],
                             availableEffects: [],
                             image: #imageLiteral(resourceName: "villager"),
                             isNightActiveRole: .NotNightActiveRole)

let VILLAGER_FIFTEEN = Role(name: "Villager",
                            type: .Villager,
                            description: "Doesn't do anything special aside from finding the werewolves to eliminate them.",
                            roleExplanation: "The Villager’s sole purpose is to find the Werewolves and eliminate them.\n\n[A farmer. A sheppard. A potter. A daughter. These are the innocents, average citizens of the village.]",
                            impact: 3,
                            priority: 264,
                            team: [.TeamVillage],
                            availableEffects: [],
                            image: #imageLiteral(resourceName: "villager"),
                            isNightActiveRole: .NotNightActiveRole)



let VIRGINIA_WOOLF = Role(name: "The Provider", type: .VirginiaWoolf, description: "Chooses a player on the first night. If the Provider is eliminated, that player is also eliminated.", roleExplanation: "The first night, the Provider chooses someone who has become dependent on them. That player is woken up and shown who they depend on. If the Provider is eliminated, so is that player.\n\n[The Provider is a caring and giving villager, doing charity work to help the poor and helpless. So much so, that some people come to rely soley on them. So much so that if something were to ever happen to the Provider, those villagers would surely perish.]", impact: -2, priority: 97, team: [.TeamVillage], availableEffects: [.Dependent], image: #imageLiteral(resourceName: "virginiaWoolf"), isNightActiveRole: .NotNightActiveRole)




let WEREWOLF_ONE = Role(name: "Werewolf",
                        type: .Werewolf,
                        description: "Each night, wakes with the other Werewolves and chooses a player to eliminate.",
                        roleExplanation: "The Werewolves wake up the first night to learn the identity of the other Werewolves. They do not kill at this time. Every night afterwards, the Werewolves must agree (only a majority is needed, and the victim need not be unanimously selected) on a target to eliminate. If the Werewolves spend more than the alloted time determining a target for the night, they do not get to choose a target that night. The Werewolves may not target another Werewolf at night, unless the Leprechaun is in play.\n\n[No-one knows where the Werewolves come from. Some say they are as old as fear itself, born of the terror of human's early days. Whatever their origin, one thing is for sure: they are an unwanted, violent predator. The best hope for people to survive this sudden onslaught, is to band together, figure out who to trust, and lynch the werewolves once and for all.]",
                        impact: -6,
                        priority: 25,
                        team: [.TeamWerewolf],
                        availableEffects: [],
                        image: #imageLiteral(resourceName: "werewolf"),
                        isNightActiveRole: .NightActiveRole)

let WEREWOLF_TWO = Role(name: "Werewolf",
                        type: .Werewolf,
                        description: "Each night, wakes with the other Werewolves and chooses a player to eliminate.",
                        roleExplanation: "The Werewolves wake up the first night to learn the identity of the other Werewolves. They do not kill at this time. Every night afterwards, the Werewolves must agree (only a majority is needed, and the victim need not be unanimously selected) on a target to eliminate. If the Werewolves spend more than the alloted time determining a target for the night, they do not get to choose a target that night. The Werewolves may not target another Werewolf at night, unless the Leprechaun is in play.\n\n[No-one knows where the Werewolves come from. Some say they are as old as fear itself, born of the terror of human's early days. Whatever their origin, one thing is for sure: they are an unwanted, violent predator. The best hope for people to survive this sudden onslaught, is to band together, figure out who to trust, and lynch the werewolves once and for all.]",
                        impact: -6,
                        priority: 25,
                        team: [.TeamWerewolf],
                        availableEffects: [],
                        image: #imageLiteral(resourceName: "werewolf"),
                        isNightActiveRole: .NightActiveRole)

let WEREWOLF_THREE = Role(name: "Werewolf",
                          type: .Werewolf,
                          description: "Each night, wakes with the other Werewolves and chooses a player to eliminate.",
                          roleExplanation: "The Werewolves wake up the first night to learn the identity of the other Werewolves. They do not kill at this time. Every night afterwards, the Werewolves must agree (only a majority is needed, and the victim need not be unanimously selected) on a target to eliminate. If the Werewolves spend more than the alloted time determining a target for the night, they do not get to choose a target that night. The Werewolves may not target another Werewolf at night, unless the Leprechaun is in play.\n\n[No-one knows where the Werewolves come from. Some say they are as old as fear itself, born of the terror of human's early days. Whatever their origin, one thing is for sure: they are an unwanted, violent predator. The best hope for people to survive this sudden onslaught, is to band together, figure out who to trust, and lynch the werewolves once and for all.]",
                          impact: -6,
                          priority: 25,
                          team: [.TeamWerewolf],
                          availableEffects: [],
                          image: #imageLiteral(resourceName: "werewolf"),
                          isNightActiveRole: .NightActiveRole)

let WEREWOLF_FOUR = Role(name: "Werewolf",
                         type: .Werewolf,
                         description: "Each night, wakes with the other Werewolves and chooses a player to eliminate.",
                         roleExplanation: "The Werewolves wake up the first night to learn the identity of the other Werewolves. They do not kill at this time. Every night afterwards, the Werewolves must agree (only a majority is needed, and the victim need not be unanimously selected) on a target to eliminate. If the Werewolves spend more than the alloted time determining a target for the night, they do not get to choose a target that night. The Werewolves may not target another Werewolf at night, unless the Leprechaun is in play.\n\n[No-one knows where the Werewolves come from. Some say they are as old as fear itself, born of the terror of human's early days. Whatever their origin, one thing is for sure: they are an unwanted, violent predator. The best hope for people to survive this sudden onslaught, is to band together, figure out who to trust, and lynch the werewolves once and for all.]",
                         impact: -6,
                         priority: 25,
                         team: [.TeamWerewolf],
                         availableEffects: [],
                         image: #imageLiteral(resourceName: "werewolf"),
                         isNightActiveRole: .NightActiveRole)

let WEREWOLF_FIVE = Role(name: "Werewolf",
                         type: .Werewolf,
                         description: "Each night, wakes with the other Werewolves and chooses a player to eliminate.",
                         roleExplanation: "The Werewolves wake up the first night to learn the identity of the other Werewolves. They do not kill at this time. Every night afterwards, the Werewolves must agree (only a majority is needed, and the victim need not be unanimously selected) on a target to eliminate. If the Werewolves spend more than the alloted time determining a target for the night, they do not get to choose a target that night. The Werewolves may not target another Werewolf at night, unless the Leprechaun is in play.\n\n[No-one knows where the Werewolves come from. Some say they are as old as fear itself, born of the terror of human's early days. Whatever their origin, one thing is for sure: they are an unwanted, violent predator. The best hope for people to survive this sudden onslaught, is to band together, figure out who to trust, and lynch the werewolves once and for all.]",
                         impact: -6,
                         priority: 25,
                         team: [.TeamWerewolf],
                         availableEffects: [],
                         image: #imageLiteral(resourceName: "werewolf"),
                         isNightActiveRole: .NightActiveRole)

let WEREWOLF_SIX = Role(name: "Werewolf",
                        type: .Werewolf,
                        description: "Each night, wakes with the other Werewolves and chooses a player to eliminate.",
                        roleExplanation: "The Werewolves wake up the first night to learn the identity of the other Werewolves. They do not kill at this time. Every night afterwards, the Werewolves must agree (only a majority is needed, and the victim need not be unanimously selected) on a target to eliminate. If the Werewolves spend more than the alloted time determining a target for the night, they do not get to choose a target that night. The Werewolves may not target another Werewolf at night, unless the Leprechaun is in play.\n\n[No-one knows where the Werewolves come from. Some say they are as old as fear itself, born of the terror of human's early days. Whatever their origin, one thing is for sure: they are an unwanted, violent predator. The best hope for people to survive this sudden onslaught, is to band together, figure out who to trust, and lynch the werewolves once and for all.]",
                        impact: -6,
                        priority: 25,
                        team: [.TeamWerewolf],
                        availableEffects: [],
                        image: #imageLiteral(resourceName: "werewolf"),
                        isNightActiveRole: .NightActiveRole)

let WEREWOLF_SEVEN = Role(name: "Werewolf",
                          type: .Werewolf,
                          description: "Each night, wakes with the other Werewolves and chooses a player to eliminate.",
                          roleExplanation: "The Werewolves wake up the first night to learn the identity of the other Werewolves. They do not kill at this time. Every night afterwards, the Werewolves must agree (only a majority is needed, and the victim need not be unanimously selected) on a target to eliminate. If the Werewolves spend more than the alloted time determining a target for the night, they do not get to choose a target that night. The Werewolves may not target another Werewolf at night, unless the Leprechaun is in play.\n\n[No-one knows where the Werewolves come from. Some say they are as old as fear itself, born of the terror of human's early days. Whatever their origin, one thing is for sure: they are an unwanted, violent predator. The best hope for people to survive this sudden onslaught, is to band together, figure out who to trust, and lynch the werewolves once and for all.]",
                          impact: -6,
                          priority: 25,
                          team: [.TeamWerewolf],
                          availableEffects: [],
                          image: #imageLiteral(resourceName: "werewolf"),
                          isNightActiveRole: .NightActiveRole)

let WEREWOLF_EIGHT = Role(name: "Werewolf",
                          type: .Werewolf,
                          description: "Each night, wakes with the other Werewolves and chooses a player to eliminate.",
                          roleExplanation: "The Werewolves wake up the first night to learn the identity of the other Werewolves. They do not kill at this time. Every night afterwards, the Werewolves must agree (only a majority is needed, and the victim need not be unanimously selected) on a target to eliminate. If the Werewolves spend more than the alloted time determining a target for the night, they do not get to choose a target that night. The Werewolves may not target another Werewolf at night, unless the Leprechaun is in play.\n\n[No-one knows where the Werewolves come from. Some say they are as old as fear itself, born of the terror of human's early days. Whatever their origin, one thing is for sure: they are an unwanted, violent predator. The best hope for people to survive this sudden onslaught, is to band together, figure out who to trust, and lynch the werewolves once and for all.]",
                          impact: -6,
                          priority: 25,
                          team: [.TeamWerewolf],
                          availableEffects: [],
                          image: #imageLiteral(resourceName: "werewolf"),
                          isNightActiveRole: .NightActiveRole)

let WEREWOLF_NINE = Role(name: "Werewolf",
                         type: .Werewolf,
                         description: "Each night, wakes with the other Werewolves and chooses a player to eliminate.",
                         roleExplanation: "The Werewolves wake up the first night to learn the identity of the other Werewolves. They do not kill at this time. Every night afterwards, the Werewolves must agree (only a majority is needed, and the victim need not be unanimously selected) on a target to eliminate. If the Werewolves spend more than the alloted time determining a target for the night, they do not get to choose a target that night. The Werewolves may not target another Werewolf at night, unless the Leprechaun is in play.\n\n[No-one knows where the Werewolves come from. Some say they are as old as fear itself, born of the terror of human's early days. Whatever their origin, one thing is for sure: they are an unwanted, violent predator. The best hope for people to survive this sudden onslaught, is to band together, figure out who to trust, and lynch the werewolves once and for all.]",
                         impact: -6,
                         priority: 25,
                         team: [.TeamWerewolf],
                         availableEffects: [],
                         image: #imageLiteral(resourceName: "werewolf"),
                         isNightActiveRole: .NightActiveRole)

let WEREWOLF_TEN = Role(name: "Werewolf",
                        type: .Werewolf,
                        description: "Each night, wakes with the other Werewolves and chooses a player to eliminate.",
                        roleExplanation: "The Werewolves wake up the first night to learn the identity of the other Werewolves. They do not kill at this time. Every night afterwards, the Werewolves must agree (only a majority is needed, and the victim need not be unanimously selected) on a target to eliminate. If the Werewolves spend more than the alloted time determining a target for the night, they do not get to choose a target that night. The Werewolves may not target another Werewolf at night, unless the Leprechaun is in play.\n\n[No-one knows where the Werewolves come from. Some say they are as old as fear itself, born of the terror of human's early days. Whatever their origin, one thing is for sure: they are an unwanted, violent predator. The best hope for people to survive this sudden onslaught, is to band together, figure out who to trust, and lynch the werewolves once and for all.]",
                        impact: -6,
                        priority: 25,
                        team: [.TeamWerewolf],
                        availableEffects: [],
                        image: #imageLiteral(resourceName: "werewolf"),
                        isNightActiveRole: .NightActiveRole)

let WEREWOLF_ELEVEN = Role(name: "Werewolf",
                           type: .Werewolf,
                           description: "Each night, wakes with the other Werewolves and chooses a player to eliminate.",
                           roleExplanation: "The Werewolves wake up the first night to learn the identity of the other Werewolves. They do not kill at this time. Every night afterwards, the Werewolves must agree (only a majority is needed, and the victim need not be unanimously selected) on a target to eliminate. If the Werewolves spend more than the alloted time determining a target for the night, they do not get to choose a target that night. The Werewolves may not target another Werewolf at night, unless the Leprechaun is in play.\n\n[No-one knows where the Werewolves come from. Some say they are as old as fear itself, born of the terror of human's early days. Whatever their origin, one thing is for sure: they are an unwanted, violent predator. The best hope for people to survive this sudden onslaught, is to band together, figure out who to trust, and lynch the werewolves once and for all.]",
                           impact: -6,
                           priority: 25,
                           team: [.TeamWerewolf],
                           availableEffects: [],
                           image: #imageLiteral(resourceName: "werewolf"),
                           isNightActiveRole: .NightActiveRole)

let WEREWOLF_TWELVE = Role(name: "Werewolf",
                           type: .Werewolf,
                           description: "Each night, wakes with the other Werewolves and chooses a player to eliminate.",
                           roleExplanation: "The Werewolves wake up the first night to learn the identity of the other Werewolves. They do not kill at this time. Every night afterwards, the Werewolves must agree (only a majority is needed, and the victim need not be unanimously selected) on a target to eliminate. If the Werewolves spend more than the alloted time determining a target for the night, they do not get to choose a target that night. The Werewolves may not target another Werewolf at night, unless the Leprechaun is in play.\n\n[No-one knows where the Werewolves come from. Some say they are as old as fear itself, born of the terror of human's early days. Whatever their origin, one thing is for sure: they are an unwanted, violent predator. The best hope for people to survive this sudden onslaught, is to band together, figure out who to trust, and lynch the werewolves once and for all.]",
                           impact: -6,
                           priority: 25,
                           team: [.TeamWerewolf],
                           availableEffects: [],
                           image: #imageLiteral(resourceName: "werewolf"),
                           isNightActiveRole: .NightActiveRole)



let WITCH = Role(name: "Witch",
                 type: .Witch,
                 description: "May choose to save or eliminate a player at night, once each per game.",
                 roleExplanation: "The Witch may use her power to prevent someone from being eliminated, once during the game. The Moderator will point out who the night target is and she may choose to save them or not. She may also poison someone of her choice, effectively eliminating that player, once during the game. The Moderator should call the Witch every night and ask if she would like to use either or both of her special powers, even if they have been used. Both powers may be used on the same night.\n\n[Beautiful as she is dangerous. The Witch is a fickle woman, ruled by emotion as much as by logic. Though capricious in nature, the village can at least rest easy that she has the village's best interests at heart.]",
                 impact: 4,
                 priority: 118,
                 team: [.TeamVillage],
                 availableEffects: [.Protection, .Poison],
                 image: #imageLiteral(resourceName: "witch"),
                 isNightActiveRole: .NightActiveRole)



let WOLFCUB = Role(name: "Wolf Cub",
                   type: .WolfCub,
                   description: "Each night, wakes with the Werewolves. If eliminated, the Werewolves eliminate two players the following night.",
                   roleExplanation: "The Wolf Cub is a Werewolf, and wakes with them each night. If the Wolf Cub is eliminated, the Werewolves get to eliminate two players the next night.\n\n[What a cute, widdle, pupp.... AAARRRRGGGGHHHHHH!]",
                   impact: -8,
                   priority: 7,
                   team: [.TeamWerewolf],
                   availableEffects: [],
                   image: #imageLiteral(resourceName: "wolfCub"),
                   isNightActiveRole: .NotNightActiveRole)



let WOLFMAN = Role(name: "Wolf Man",
                   type: .WolfMan,
                   description: "Wakes with the other Werewolves every night. Seen as a villager by the Seer.",
                   roleExplanation: "The Wolf Man is a Werewolf but the Seer sees him as a Villager.\n\n[There are stories of a werewolf that doesn't change into wolf form, but looks like a man. No-one can even imagine what havok this wolf would wreak upon the village if those stories are true. Thank god they're just stories. Right?]",
                   impact: -9,
                   priority: 13,
                   team: [.TeamWerewolf],
                   availableEffects: [],
                   image: #imageLiteral(resourceName: "wolfMan"),
                   isNightActiveRole: .NightActiveRole)



let ZOMBIE = Role(name: "Zombie",
                  type: .Zombie,
                  description: "Each night, picks a player that player may no longer vote.",
                  roleExplanation: "During the night, the Zombie chooses to bite another player. When the village wakes up in the morning, the Moderator informs the village who was infected. From that point on in the game, players with no brains may not take part in the vote to lynch during the day. To clarify, if there are ten players, and three are bitten, only seven players may vote, and the vote will pass with four votes, instead of the six that would normally be required. If at any time all remaining players have no brains, the Zombie wins.\n\n[Somehow, the walking dead has risen and walks around the village. And what does it eat? Brains. It eats brains.]",
                  impact: -3,
                  priority: 112,
                  team: [.TeamZombie],
                  availableEffects: [.Lobotomy],
                  image: #imageLiteral(resourceName: "zombie"),
                  isNightActiveRole: .NightActiveRole)


// MARK: - Team roles

let BLOB_TEAM = Role(name: "The Hivemind",
                     type: .TheBlob,
                     description: "Each night, the Hivemind assimilates another player to the right of the last assimilated player. If all players are part of the Hivemind, you win.",
                     roleExplanation: "Each night, the Hivemind absorbs one player to the right of the Blob. If all players are part of the Hivemind, the Hivemind player wins, even if he has been eliminated.\n\n[It started off with a child that stumbled into the forest in the middle of the night, chasing a shadow hanging in the sky. The next day, he was... different. And anyone that visited him and tried to help always came out of the hut acting the same way as the child. Nobody knows what's happening.]",
                     impact: -1,
                     priority: 151,
                     team: [.TeamBlob],
                     availableEffects: [],
                     image: #imageLiteral(resourceName: "theBlob"),
                     isNightActiveRole: .NightActiveRole)



let WEREWOLF_TEAM = Role(name: "Werewolf",
                         type: .Werewolf,
                         description: "Wake and choose a player to eliminate.",
                         roleExplanation: "The Werewolves wake up the first night to learn the identity of the other Werewolves. They do not kill at this time. Every night afterwards, the Werewolves must agree (only a majority is needed, and the victim need not be unanimously selected) on a target to eliminate. If the Werewolves spend more than the alloted time determining a target for the night, they do not get to choose a target that night. The Werewolves may not target another Werewolf at night, unless the Leprechaun is in play.\n\n[No-one knows where the Werewolves come from. Some say they are as old as fear itself, born of the terror of human's early days. Whatever their origin, one thing is for sure: they are an unwanted, violent predator. The best hope for people to survive this sudden onslaught, is to band together, figure out who to trust, and lynch the werewolves once and for all.]",
                         impact: -6,
                         priority: 25,
                         team: [.TeamWerewolf],
                         availableEffects: [],
                         image: #imageLiteral(resourceName: "werewolf"),
                         isNightActiveRole: .NightActiveRole)
