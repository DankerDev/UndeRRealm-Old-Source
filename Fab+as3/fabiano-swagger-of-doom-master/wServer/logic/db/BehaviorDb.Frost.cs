#region

using wServer.logic.behaviors;
using wServer.logic.transitions;
using wServer.logic.loot;

#endregion

namespace wServer.logic
{
    partial class BehaviorDb
    {
        private _ Frost = () => Behav()
        .Init("Frost Pillar",
            new State(
                new State("shoot",
                    new Shoot(10, 2, projectileIndex: 0, predictive: 1, coolDown: 700, coolDownOffset: 600),
                    new Shoot(10, 4, projectileIndex: 0, predictive: 1, coolDown: 1400, coolDownOffset: 1000),
                    new Shoot(10, 5, projectileIndex: 0, predictive: 1, coolDown: 1500, coolDownOffset: 1400),
                    new Shoot(10, 6, projectileIndex: 0, predictive: 1, coolDown: 1600, coolDownOffset: 1800),
                    new EntityNotExistsTransition("Frost Protector", 1000, "spawn")
                    ),
                new State("spawn",
                        new TossObject("Frost Protector", 4, 45, coolDown: 5000, randomToss: false),
                        new TossObject("Frost Protector", 4, 135, coolDown: 5100, randomToss: false),
                        new TossObject("Frost Protector", 4, 225, coolDown: 5200, randomToss: false),
                        new TossObject("Frost Protector", 4, 315, coolDown: 5300, randomToss: false),
                        new TimedTransition(500, "shoot")
                    )
                )
            )
        .Init ("Frost King",
            new State(
                new State("start",
                    new ConditionalEffect(ConditionEffectIndex.Invulnerable),
                    new Taunt("Freezzz!!"),
                    new EntityNotExistsTransition("Frost Pillar", 1000, "hey")
                    ),
                new State("hey",
                 new Shoot(5, count: 8, projectileIndex: 0, predictive: 1, coolDown: 1600, coolDownOffset: 1200),
                 new Shoot(5, count: 8, projectileIndex: 0, coolDown: 1800, coolDownOffset: 1400),
                 new Shoot(10, count: 10, projectileIndex: 1, predictive: 1, coolDown: 2000, coolDownOffset: 1600),
                 new Shoot(5, count: 8, projectileIndex: 0, coolDown: 2200, coolDownOffset: 1800),
                 new Shoot(5, count: 8, projectileIndex: 0, predictive: 1, coolDown: 2400, coolDownOffset: 2000),
                 new Shoot(10, count: 10, projectileIndex: 1, coolDown: 2600, coolDownOffset: 2200),
                 new HpLessTransition(0.8, "fight")
                    ),
                new State("fight",
                 new ConditionalEffect(ConditionEffectIndex.Invulnerable),
                 new TossObject("Frost Protector", 3, 1, coolDown: 5000000),
                 new TimedTransition(1000, "fight2")
                    ),
                new State("fightrest",
                    new ConditionalEffect(ConditionEffectIndex.Invulnerable),
                    new Taunt("Mortal you have no chance"),
                    new EntityNotExistsTransition("Frost Protector", 1000, "fight2")
                    ),
                new State("fight2",
                      new Shoot(20, 1, 0, 1, 70, coolDownOffset: 200),
                        new Shoot(20, 1, 0, 1, 130, coolDownOffset: 200),
                        new Shoot(20, 1, 0, 1, 190, coolDownOffset: 200),
                        new Shoot(20, 1, 0, 1, 250, coolDownOffset: 200),
                        new Shoot(20, 1, 0, 1, 310, coolDownOffset: 200),
                        new Shoot(20, 1, 0, 1, 10, coolDownOffset: 200),
                        new Shoot(20, 1, 0, 1, 80, coolDownOffset: 400),
                        new Shoot(20, 1, 0, 1, 140, coolDownOffset: 400),
                        new Shoot(20, 1, 0, 1, 200, coolDownOffset: 400),
                        new Shoot(20, 1, 0, 1, 260, coolDownOffset: 400),
                        new Shoot(20, 1, 0, 1, 320, coolDownOffset: 400),
                        new Shoot(20, 1, 0, 1, 20, coolDownOffset: 400),
                        new Shoot(20, 1, 0, 1, 90, coolDownOffset: 600),
                        new Shoot(20, 1, 0, 1, 150, coolDownOffset: 600),
                        new Shoot(20, 1, 0, 1, 210, coolDownOffset: 600),
                        new Shoot(20, 1, 0, 1, 270, coolDownOffset: 600),
                        new Shoot(20, 1, 0, 1, 330, coolDownOffset: 600),
                        new Shoot(20, 1, 0, 1, 30, coolDownOffset: 600),
                        new Shoot(20, 1, 0, 1, 100, coolDownOffset: 800),
                        new Shoot(20, 1, 0, 1, 160, coolDownOffset: 800),
                        new Shoot(20, 1, 0, 1, 220, coolDownOffset: 800),
                        new Shoot(20, 1, 0, 1, 280, coolDownOffset: 800),
                        new Shoot(20, 1, 0, 1, 340, coolDownOffset: 800),
                        new Shoot(20, 1, 0, 1, 40, coolDownOffset: 800),
                        new Shoot(20, 1, 0, 1, 110, coolDownOffset: 1000),
                        new Shoot(20, 1, 0, 1, 170, coolDownOffset: 1000),
                        new Shoot(20, 1, 0, 1, 230, coolDownOffset: 1000),
                        new Shoot(20, 1, 0, 1, 290, coolDownOffset: 1000),
                        new Shoot(20, 1, 0, 1, 350, coolDownOffset: 1000),
                        new Shoot(20, 1, 0, 1, 50, coolDownOffset: 1000),
                        new Shoot(20, 1, 0, 1, 120, coolDownOffset: 1200),
                        new Shoot(20, 1, 0, 1, 180, coolDownOffset: 1200),
                        new Shoot(20, 1, 0, 1, 240, coolDownOffset: 1200),
                        new Shoot(20, 1, 0, 1, 300, coolDownOffset: 1200),
                        new Shoot(20, 1, 0, 1, 0, coolDownOffset: 1200),
                        new Shoot(20, 1, 0, 1, 60, coolDownOffset: 1200),
                        new Shoot(20, 1, 0, 1, 130, coolDownOffset: 1400),
                        new Shoot(20, 1, 0, 1, 190, coolDownOffset: 1400),
                        new Shoot(20, 1, 0, 1, 250, coolDownOffset: 1400),
                        new Shoot(20, 1, 0, 1, 310, coolDownOffset: 1400),
                        new Shoot(20, 1, 2, 1, 10, coolDownOffset: 1400),
                        new Shoot(20, 1, 2, 1, 70, coolDownOffset: 1400),
                        new Shoot(20, 1, 2, 1, 140, coolDownOffset: 1600),
                        new Shoot(20, 1, 2, 1, 200, coolDownOffset: 1600),
                        new Shoot(20, 1, 2, 1, 260, coolDownOffset: 1600),
                        new Shoot(20, 1, 2, 1, 320, coolDownOffset: 1600),
                        new Shoot(20, 1, 2, 1, 20, coolDownOffset: 1600),
                        new Shoot(20, 1, 2, 1, 80, coolDownOffset: 1600),
                        new Shoot(20, 1, 2, 1, 150, coolDownOffset: 2000),
                        new Shoot(20, 1, 2, 1, 210, coolDownOffset: 2000),
                        new Shoot(20, 1, 2, 1, 250, coolDownOffset: 2000),
                        new Shoot(20, 1, 2, 1, 330, coolDownOffset: 2000),
                        new Shoot(20, 1, 2, 1, 30, coolDownOffset: 2000),
                        new Shoot(20, 1, 2, 1, 90, coolDownOffset: 2000),
                        new HpLessTransition(0.6, "rage")
                        ),
                new State("rage",
                        new Prioritize(
                            new Follow(1, acquireRange: 15, range: 8),
                            new Wander(1)
                            ),
                        new Shoot(10, 20, projectileIndex: 2, predictive: 1, coolDown: 1000),
                        new Shoot(10, predictive: 1, projectileIndex: 0, coolDown: 2000),
                        new HpLessTransition(0.4, "laststage")
                        ),
                new State("laststage",
                    new Taunt("I can no longer sustain my form!"),
                    new Taunt("You will pay..."),
                    new Suicide()
                    )
                    ),
                new MostDamagers(3,
                    new ItemLoot("Potion of Wisdom", 1.0)
                ),
                new MostDamagers(2,
                    new ItemLoot("Potion of Defense", 1.0)
                ),
                new GoldLoot(100, 150),
                new Threshold(0.025,
                    new TierLoot(5, ItemType.Ability, 0.1),
                    new TierLoot(6, ItemType.Ring, 0.05),
                    new TierLoot(11, ItemType.Armor, 0.05),
                    new TierLoot(11, ItemType.Weapon, 0.05),
                    new ItemLoot("Blade of Eternal Frost", 0.02),
                     new ItemLoot("Staff of Eternal Frost", 0.02),
                     new ItemLoot("Dagger of Eternal Frost", 0.02),
                     new ItemLoot("Eternal Forst Bow", 0.02)
                )
            )
        .Init("Frost Protector",
                new State(
                    new State("start",
                        new Orbit(0.3, 3, 20, "Frost Pillar"),
                        new Shoot(8.4, count: 2, projectileIndex: 0, shootAngle: 10, coolDown: 700),
                        new Spawn("Frost Knight", 1, 0, 5000)
                        )
                    )
            )
        .Init("Frost Knight",
                new State(
                    new Prioritize(
                        new Follow(1.5, 8, 5),
                        new Wander(0.25)
                        ),
                    new State("start",
                        new Shoot(8.4, count: 2, projectileIndex: 0, shootAngle: 10, coolDown: 1000),
                        new TimedTransition(200, "grow")
                        ),
                    new State("grow",
                        new ConditionalEffect(ConditionEffectIndex.Invulnerable),
                        new TimedTransition(200, "start")
                        )
                    )
            )
        .Init("Frosted Human",
                new State(
                    new Prioritize(
                        new Follow(0.8, 8, 1),
                        new Wander(0.25)
                        ),
                    new State("start",
                        new Shoot(8, 3, shootAngle: 10, coolDown: 1000)
                        )
                    )
            )
           ;
    }
}
