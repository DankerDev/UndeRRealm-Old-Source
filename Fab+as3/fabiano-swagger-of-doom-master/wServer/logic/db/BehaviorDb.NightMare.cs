using wServer.logic.behaviors;
using wServer.logic.transitions;
using wServer.logic.loot;

namespace wServer.logic
{
    partial class BehaviorDb
    {
        private _ NightMare = () => Behav()
        .Init("Nightmare Reaper",
            new State(
                new State("Start State",
                    new PlayerWithinTransition(6, "Begin")
                    ),
                new State("Begin",
                    new ConditionalEffect(ConditionEffectIndex.Invulnerable),
                    new Taunt("Do you really want to fight me?"),
                    new ChatTransition("Start Fight", "Yes"),
                    new ChatTransition("Start Fight", "yes"),
                    new ChatTransition("Start Fight", "YES")
                    ),
                new State("Start Fight",
                    new ConditionalEffect(ConditionEffectIndex.Invulnerable),
                    new Taunt("Really... My Minions Attack Them!"),
                    new Spawn("Xp Gift", 2, 1, 1000000),
                    new EntityNotExistsTransition("Test Egg", 50, "FightReal")
                    ),
                new State("FightReal",
                    new Prioritize(
                        new Follow(0.5)
                        ),
                    new Shoot(10, 5, 10, 0, coolDown: 500),
                    new Shoot(10, 6, angleOffset: 20, projectileIndex: 1, coolDown:1000),
                    new TimedTransition(60000, "FightReal2")
                    ),
                new State("FightReal2"
                    



                    )
                )

            );
    }
}
