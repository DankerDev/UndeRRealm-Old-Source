#region
using System;
using wServer.networking.cliPackets;
using wServer.networking.svrPackets;
using wServer.realm;
using wServer.realm.entities;
#endregion

namespace wServer.realm.entities.player
{
    public partial class Player
    {
        internal Projectile PlayerShootProjectile(
            byte id, ProjectileDesc desc, ushort objType,
            int time, Position position, float angle)           
        {
            if (StatsManager.GetAttackDamage(desc.MinDamage, desc.MaxDamage) > 2100 && Client.Account.Rank < 2)
            {
                Client.Player.SendError(Client.Player.Name +" stop using modified client.");
                Client.Disconnect();
            }
            

            ProjectileId = id;
            return CreateProjectile(desc, objType, (int)StatsManager.GetAttackDamage(desc.MinDamage, desc.MaxDamage), time, position, angle);                 
        }
    }
}