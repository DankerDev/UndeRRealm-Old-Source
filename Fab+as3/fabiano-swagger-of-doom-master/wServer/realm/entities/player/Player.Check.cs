using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace wServer.realm.entities.player
{
    partial class Player
    {
        public int lastShootTime = -1;
        public int shootCounter = 0;

        public int lastMoveTime = -1;
        public int outOfBoundsCount = 0;
        public int goodCount = 0;

        public int lastSwapTime = -1;
    }
}