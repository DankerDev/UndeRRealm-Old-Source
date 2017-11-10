#region

using wServer.realm.entities.player;
using wServer.networking;

#endregion

namespace wServer.realm.worlds
{
    public class WackaMoleEntrance : World
    {
        public WackaMoleEntrance(bool IsLimbo)
        {
            Id = ENTRANCE_ID;
            Name = "WackaMoleEntrance";
            ClientWorldName = "WackaMoleEntrance";
            Background = 0;
            AllowTeleport = false;
            this.IsLimbo = IsLimbo;
        }

        protected override void Init()
        {
            if (!(IsLimbo != IsLimbo))
            {
                LoadMap("wServer.realm.worlds.maps.WackaEntrance.jm", MapType.Json);
            }
        }

        public override World GetInstance(Client psr)
        {
            return Manager.AddWorld(new WackaMoleEntrance(false));
        }
    }
}