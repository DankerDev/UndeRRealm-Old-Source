using wServer.logic.behaviors;
using wServer.logic.transitions;
using wServer.logic.loot;

namespace wServer.logic
{
    partial class BehaviorDb
    {
        private _ SpiderDen = () => Behav()
            .Init("Arachna the Spider Queen",
                 new State(
                     new State("idle",
                         new ConditionalEffect(ConditionEffectIndex.Invulnerable),
                         new PlayerWithinTransition(12, "WEB!")
                         ),
                     new State("WEB!",
                         new ConditionalEffect(ConditionEffectIndex.Invulnerable),
                         new TossObject("Arachna Web Spoke 1", range: 10, angle: 0, coolDown: 100000),
                        new TossObject("Arachna Web Spoke 7", range: 6, angle: 0, coolDown: 100000),
                        new TossObject("Arachna Web Spoke 2", range: 10, angle: 60, coolDown: 100000),
                        new TossObject("Arachna Web Spoke 3", range: 10, angle: 120, coolDown: 100000),
                        new TossObject("Arachna Web Spoke 8", range: 6, angle: 120, coolDown: 100000),
                        new TossObject("Arachna Web Spoke 4", range: 10, angle: 180, coolDown: 100000),
                        new TossObject("Arachna Web Spoke 5", range: 10, angle: 240, coolDown: 100000),
                        new TossObject("Arachna Web Spoke 9", range: 6, angle: 240, coolDown: 100000),
                        new TossObject("Arachna Web Spoke 6", range: 10, angle: 300, coolDown: 100000),
                         new TimedTransition(2000, "attack")
                         ),
                     new State("attack",
                         new Wander(1.0),
                         new Shoot(3000, count: 12, projectileIndex: 0, fixedAngle: fixedAngle_RingAttack2),
                         new Shoot(10, 1, 0, defaultAngle: 0, angleOffset: 0, projectileIndex: 0, predictive: 1,
                         coolDown: 1000, coolDownOffset: 0),
                         new Shoot(10, 1, 0, defaultAngle: 0, angleOffset: 0, projectileIndex: 1, predictive: 1,
                         coolDown: 2000, coolDownOffset: 0)
                         )
                         ),
                    new ItemLoot("Golden Dagger", 0.2),
                    new ItemLoot("Spider's Eye Ring", 0.2),
                    new ItemLoot("Poison Fang Dagger", 0.2),
                 new Threshold(0.32,
                    new ItemLoot("Healing Ichor", 1)
                     )
            )
        .Init("Arachna Web Spoke 1",
                new State(
                    new ConditionalEffect(ConditionEffectIndex.Invulnerable),
                new Shoot(200, count: 1, fixedAngle: 180, coolDown: 150),
                new Shoot(200, count: 1, fixedAngle: 120, coolDown: 150),
                new Shoot(200, count: 1, fixedAngle: 240, coolDown: 150)
                    )
            )
           .Init("Arachna Web Spoke 2",
                new State(
                    new ConditionalEffect(ConditionEffectIndex.Invulnerable),
                new Shoot(200, count: 1, fixedAngle: 240, coolDown: 150),
                new Shoot(200, count: 1, fixedAngle: 180, coolDown: 150),
                new Shoot(200, count: 1, fixedAngle: 300, coolDown: 150)
                    )
            )
           .Init("Arachna Web Spoke 3",
                new State(
                    new ConditionalEffect(ConditionEffectIndex.Invulnerable),
                new Shoot(200, count: 1, fixedAngle: 300, coolDown: 150),
                new Shoot(200, count: 1, fixedAngle: 240, coolDown: 150),
                new Shoot(200, count: 1, fixedAngle: 0, coolDown: 150)
                    )
            )
           .Init("Arachna Web Spoke 4",
                new State(
                    new ConditionalEffect(ConditionEffectIndex.Invulnerable),
                new Shoot(200, count: 1, fixedAngle: 0, coolDown: 150),
                new Shoot(200, count: 1, fixedAngle: 60, coolDown: 150),
                new Shoot(200, count: 1, fixedAngle: 300, coolDown: 150)
                    )
            )
           .Init("Arachna Web Spoke 5",
                new State(
                    new ConditionalEffect(ConditionEffectIndex.Invulnerable),
                new Shoot(200, count: 1, fixedAngle: 60, coolDown: 150),
                new Shoot(200, count: 1, fixedAngle: 0, coolDown: 150),
                new Shoot(200, count: 1, fixedAngle: 120, coolDown: 150)
     )
            )
           .Init("Arachna Web Spoke 6",
                new State(
                    new ConditionalEffect(ConditionEffectIndex.Invulnerable),
                new Shoot(200, count: 1, fixedAngle: 120, coolDown: 150),
                new Shoot(200, count: 1, fixedAngle: 60, coolDown: 150),
                new Shoot(200, count: 1, fixedAngle: 180, coolDown: 150)
                    )
            )
           .Init("Arachna Web Spoke 7",
                new State(
                    new ConditionalEffect(ConditionEffectIndex.Invulnerable),
                new Shoot(200, count: 1, fixedAngle: 180, coolDown: 150),
                new Shoot(200, count: 1, fixedAngle: 120, coolDown: 150),
                new Shoot(200, count: 1, fixedAngle: 240, coolDown: 150)
                    )
            )
           .Init("Arachna Web Spoke 8",
                new State(
                    new ConditionalEffect(ConditionEffectIndex.Invulnerable),
                new Shoot(200, count: 1, fixedAngle: 360, coolDown: 150),
                new Shoot(200, count: 1, fixedAngle: 240, coolDown: 150),
                new Shoot(200, count: 1, fixedAngle: 300, coolDown: 150)
                    )
            )
           .Init("Arachna Web Spoke 9",
                new State(
                new ConditionalEffect(ConditionEffectIndex.Invulnerable),
                new Shoot(200, count: 1, fixedAngle: 0, coolDown: 150),
                new Shoot(200, count: 1, fixedAngle: 60, coolDown: 150),
                new Shoot(200, count: 1, fixedAngle: 120, coolDown: 150)
                    )            
        )
        .Init("Black Den Spider",
            new State(
                new State("idle",
                    new Wander(0.8),
                    new Charge(0.9, 20f, 2000),
                    new Shoot(10, 1, 0, defaultAngle: 0, angleOffset: 0, projectileIndex: 0, predictive: 1,
                    coolDown: 500, coolDownOffset: 0)
                         )
                     ),
                    new ItemLoot("Healing Ichor", 0.2)
            )
        .Init("Black Spotted Den Spider",
            new State(
                new State("idle",
                    new Wander(0.8),
                    new Charge(0.9, 40f, 2000),
                    new Shoot(10, 1, 0, defaultAngle: 0, angleOffset: 0, projectileIndex: 0, predictive: 1,
                    coolDown: 500, coolDownOffset: 0)
                         )
                     ),
                    new ItemLoot("Healing Ichor", 0.2)
            )
       .Init("Brown Den Spider",
            new State(
                new State("idle",
                    new Wander(0.8),
                    new Follow(0.8, 0.3, 0),
                    new Shoot(10, 3, 20, angleOffset: 0 / 3, projectileIndex: 0, coolDown: 500)
                    )
                ),
                new ItemLoot("Healing Ichor", 0.2)
           )
       .Init("Green Den Spider Hatchling",
            new State(
                new State("idle",
                    new Wander(0),
                    new Follow(0.8, 0.8, 0),
                    new Shoot(10, 1, 0, defaultAngle: 0, angleOffset: 0, projectileIndex: 0, predictive: 1,
                    coolDown: 1000, coolDownOffset: 0)
                    )
                )
             )
       .Init("Spider Egg Sac",
            new State(
                new TransformOnDeath("Green Den Spider Hatchling", 2, 7),
                new State("idle",
                    new PlayerWithinTransition(0.5, "suicide")
                    ),
                new State("suicide",
                    new Suicide()
                    )
                )
            )
       .Init("Red Spotted Den Spider",
            new State(
                new State("idle",
                    new Wander(0),
                    new Follow(1.0, 0.8, 0),
                    new Shoot(10, 1, 0, defaultAngle: 0, angleOffset: 0, projectileIndex: 0, predictive: 1,
                    coolDown: 500, coolDownOffset: 0)
                    )
                ),
                new ItemLoot("Healing Ichor", 0.2)
            )
       .Init("Arachna Summoner",
            new State(
                new ConditionalEffect(ConditionEffectIndex.Invincible, true),
                new RealmPortalDrop(),
                new State("idle",
                     new EntitiesNotExistsTransition(300, "Death", "Arachna the Spider Queen")
                    ),
                new State("Death",
                    new Suicide()
                    )
                )
            );
     }
}
