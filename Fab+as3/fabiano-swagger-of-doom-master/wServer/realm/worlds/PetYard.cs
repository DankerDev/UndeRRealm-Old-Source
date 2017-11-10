#region

using System.Collections.Generic;
using System.Linq;
using db;
using MySql.Data.MySqlClient;
using wServer.networking;
using wServer.realm.entities;
using wServer.realm.entities.player;

#endregion

namespace wServer.realm.worlds
{
    public class PetYard : World
    {
        private readonly Player player;

        public PetYard(Player player)
        {
            this.player = player;
            Name = "Pet Yard";
            ClientWorldName = "{nexus.Pet_Yard_" + player.Client.Account.PetYardType + "}";
            Background = 0;
            Difficulty = -1;
            ShowDisplays = true;
            AllowTeleport = false;
        }

        protected override void Init()
        {
            string petYard = "wServer.realm.worlds.maps.PetYard_Common.wmap";
            switch (player.Client.Account.PetYardType)
            {
                case 1: petYard = "wServer.realm.worlds.maps.PetYard_Common.wmap"; break;
                case 2: petYard = "wServer.realm.worlds.maps.PetYard_Uncommon.wmap"; break;
                case 3: petYard = "wServer.realm.worlds.maps.PetYard_Rare.wmap"; break;
                case 4: petYard = "wServer.realm.worlds.maps.PetYard_Legendary.wmap"; break;
                case 5: petYard = "wServer.realm.worlds.maps.PetYard_Divine.wmap"; break;
            }

            LoadMap(petYard, MapType.Wmap);
        }
    

        public override World GetInstance(Client psr)
        {
            return Manager.AddWorld(new PetYard(psr.Player));
        }
    }
}