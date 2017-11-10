#region

using wServer.logic.behaviors;
using wServer.logic.transitions;
using wServer.logic.loot;

#endregion

namespace wServer.logic
{
    partial class BehaviorDb
    {
        private _ XpChicken = () => Behav()
            .Init("Xp Gift",
            new State(
            new Prioritize(
                            new Wander(0.5)
                
                )
                )
                )
            .Init("Xp Gift A",
            new State(
            new Prioritize(
                            new Wander(0.5)
                )
                )
                )
                .Init("Xp Gift B",
            new State(
            new Prioritize(
                            new Wander(0.5)
                )
                )
                )
                .Init("Xp Gift C",
            new State(
            new Prioritize(
                            new Wander(0.5)
                )
                )
                )
                .Init("Xp Gift D",
            new State(
            new Prioritize(
                            new Wander(0.5)
                )
                )
                )
            .Init("Xp Gift E",
            new State(
            new Prioritize(
                            new Wander(0.5)
                )
                )
            )
        .Init("Xp Gift F",
            new State(
            new Prioritize(
                            new Wander(0.5)
                )
                )
            )
            .Init("Xp Gift G",
            new State(
            new Prioritize(
                            new Wander(0.5)
                )
                )

            );

    }
    }