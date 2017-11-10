#region

using wServer.logic.behaviors;
using wServer.logic.transitions;
using wServer.logic.loot;

#endregion

namespace wServer.logic
{
    partial class BehaviorDb
    {
        private _ WackObject = () => Behav()

        .Init("Golden Wack",
            new State(
                new State("Start",
                    new Taunt("Oh Shiny"),
                    new TimedTransition(400, "Suicide")
                ),
            new State("Suicide",
                    new Suicide()
                    )
                ),
            new GoldLoot(50, 200)
            )

            .Init("Black Wack",
            new State(
                new State("Start",
                    new Taunt("Don't Touch Me!"),
                    new TimedTransition(2000, "Suicide")
                ),
            new State("Suicide",
                    new Suicide()
                    )
                ),
            new GoldLoot(-10, 0)
            )
            
        .Init("Normal Wack",
                new State(
                    new State("Idle",
                        new TimedTransition(1500, "Bridge")
                    ),
                new State("Bridge",
                    new Suicide()
                )
                ),
                new GoldLoot(10, 30)
            );
    }
}