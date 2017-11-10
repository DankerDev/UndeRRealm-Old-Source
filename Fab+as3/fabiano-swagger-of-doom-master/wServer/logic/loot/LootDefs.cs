#region

using System;
using System.Collections.Generic;
using System.Linq;
using wServer.networking.svrPackets;
using db.data;
using wServer.realm;
using wServer.realm.entities;
using wServer.realm.entities.player;
using log4net;

#endregion

namespace wServer.logic.loot
{
    public interface ILootDef
    {
        string Lootstate { get; set; }

        void Populate(RealmManager manager, Enemy enemy, Tuple<Player, int> playerDat,
            Random rand, string lootState, IList<LootDef> lootDefs);
    }

    public class ItemLoot : ILootDef
    {
        private readonly string item;
        private readonly double probability;

        public string Lootstate { get; set; }

        public ItemLoot(string item, double probability)
        {
            this.item = item;
            this.probability = probability;
        }

        public void Populate(RealmManager manager, Enemy enemy, Tuple<Player, int> playerDat,
            Random rand, string lootState, IList<LootDef> lootDefs)
        {
            Lootstate = lootState;
            if (playerDat != null) return;
            XmlData dat = manager.GameData;
            lootDefs.Add(new LootDef(dat.Items[dat.IdToObjectType[item]], probability, lootState));
        }
    }
    public class GoldLoot : ILootDef
    {
        private static readonly ILog log = LogManager.GetLogger(typeof(LootState));
        public string Lootstate { get; set; }
        private readonly int maxGold;
        private readonly int minGold;

        public GoldLoot(int minGold, int maxGold)
        {
            this.maxGold = maxGold;
            this.minGold = minGold;
        }

        public void Populate(RealmManager manager, Enemy enemy, Tuple<Player, int> playerDat,
            Random rand, string lootState, IList<LootDef> lootDefs)
        {
            int amount = rand.Next(minGold, maxGold + 1);
            if (playerDat == null)
                return;
            for (int i = 0; i < 3; i++)
                playerDat.Item1.Owner.BroadcastPacket(new ShowEffectPacket()
                {
                    EffectType = EffectType.Flow,
                    Color = new ARGB(0xccac00),
                    TargetId = playerDat.Item1.Id,
                    PosA = new Position() { X = enemy.X, Y = enemy.Y }
                }, null);
                manager.Database.DoActionAsync(db =>
                {
                    playerDat.Item1.Credits =
                        playerDat.Item1.Client.Account.Credits =
                            db.UpdateCredit(playerDat.Item1.Client.Account,
                                amount);
                });
            playerDat.Item1.UpdateCount++;
                foreach (var i in manager.Clients.Values)
                {
                    i.Player.SendInfo("You got " + amount + " gold from " + enemy.Name);
                    if (amount > 500)
                    {
                        i.Player.SendSpecialInfo("Wow you are a lucky bitch, you just got " + amount + " gold");
                    }
            }
                       
        }
    }

    public class LootState : ILootDef
    {
        private readonly ILootDef[] children;

        public string Lootstate { get; set; }

        public LootState(string subState, params ILootDef[] lootDefs)
        {
            children = lootDefs;
            Lootstate = subState;
        }

        public void Populate(RealmManager manager, Enemy enemy, Tuple<Player, int> playerDat, Random rand, string lootState, IList<LootDef> lootDefs)
        {
            foreach (ILootDef i in children)
                i.Populate(manager, enemy, playerDat, rand, Lootstate, lootDefs);
        }
    }

    public enum ItemType
    {
        Weapon,
        Ability,
        Armor,
        Ring,
        Potion
    }

    public enum EggRarity
    {
        Common,
        Uncommon,
        Rare,
        Legendary
    }

    public class EggLoot : ILootDef
    {
        private readonly EggRarity rarity;
        private readonly double probability;

        public string Lootstate { get; set; }

        public EggLoot(EggRarity rarity, double probability)
        {
            this.probability = probability;
            this.rarity = rarity;
        }

        public void Populate(RealmManager manager, Enemy enemy, Tuple<Player, int> playerDat,
            Random rand, string lootState, IList<LootDef> lootDefs)
        {
            Lootstate = lootState;
            if (playerDat != null) return;
            Item[] candidates = manager.GameData.Items
                .Where(item => item.Value.SlotType == 26)
                .Where(item => item.Value.Tier == (int)rarity)
                .Select(item => item.Value)
                .ToArray();
            foreach (Item i in candidates)
                lootDefs.Add(new LootDef(i, probability / candidates.Length, lootState));
        }
    }

    public class TierLoot : ILootDef
    {
        public static readonly int[] WeaponT = {1, 2, 3, 8, 17, 24};
        public static readonly int[] AbilityT = {4, 5, 11, 12, 13, 15, 16, 18, 19, 20, 21, 22, 23, 25};
        public static readonly int[] ArmorT = {6, 7, 14};
        public static readonly int[] RingT = {9};
        public static readonly int[] PotionT = {10};
        private readonly double probability;

        private readonly byte tier;
        private readonly int[] types;

        public string Lootstate { get; set; }

        public TierLoot(byte tier, ItemType type, double probability)
        {
            this.tier = tier;
            switch (type)
            {
                case ItemType.Weapon:
                    types = WeaponT;
                    break;
                case ItemType.Ability:
                    types = AbilityT;
                    break;
                case ItemType.Armor:
                    types = ArmorT;
                    break;
                case ItemType.Ring:
                    types = RingT;
                    break;
                case ItemType.Potion:
                    types = PotionT;
                    break;
                default:
                    throw new NotSupportedException(type.ToString());
            }
            this.probability = probability;
        }

        public void Populate(RealmManager manager, Enemy enemy, Tuple<Player, int> playerDat,
            Random rand, string lootState, IList<LootDef> lootDefs)
        {
            Lootstate = lootState;
            if (playerDat != null) return;
            Item[] candidates = manager.GameData.Items
                .Where(item => Array.IndexOf(types, item.Value.SlotType) != -1)
                .Where(item => item.Value.Tier == tier)
                .Select(item => item.Value)
                .ToArray();
            foreach (Item i in candidates)
                lootDefs.Add(new LootDef(i, probability/candidates.Length, lootState));
        }
    }

    public class Threshold : ILootDef
    {
        private readonly ILootDef[] children;
        private readonly double threshold;

        public string Lootstate { get; set; }

        public Threshold(double threshold, params ILootDef[] children)
        {
            this.threshold = threshold;
            this.children = children;
        }

        public void Populate(RealmManager manager, Enemy enemy, Tuple<Player, int> playerDat, Random rand,
            string lootState, IList<LootDef> lootDefs)
        {
            Lootstate = lootState;
            if (playerDat != null && playerDat.Item2/enemy.ObjectDesc.MaxHP >= threshold)
            {
                foreach (ILootDef i in children)
                    i.Populate(manager, enemy, null, rand, lootState, lootDefs);
            }
        }
    }

    internal class MostDamagers : ILootDef
    {
        private readonly ILootDef[] loots;
        private readonly int amount;

        public MostDamagers(int amount, params ILootDef[] loots)
        {
            this.amount = amount;
            this.loots = loots;
        }

        public string Lootstate { get; set; }

        public void Populate(RealmManager manager, Enemy enemy, Tuple<Player, int> playerDat, Random rand, string lootState, IList<LootDef> lootDefs)
        {
            var data = enemy.DamageCounter.GetPlayerData();
            var mostDamage = GetMostDamage(data);
            foreach (var loot in mostDamage.Where(pl => pl.Equals(playerDat)).SelectMany(pl => loots))
                loot.Populate(manager, enemy, null, rand, lootState, lootDefs);
        }

        private IEnumerable<Tuple<Player, int>> GetMostDamage(IEnumerable<Tuple<Player, int>> data)
        {
            var damages = data.Select(_ => _.Item2).ToList();
            var len = damages.Count < amount ? damages.Count : amount;
            for (var i = 0; i < len; i++)
            {
                var val = damages.Max();
                yield return data.FirstOrDefault(_ => _.Item2 == val);
                damages.Remove(val);
            }
        }
    }

    public class OnlyOne : ILootDef
    {
        private readonly ILootDef[] loots;

        public OnlyOne(params ILootDef[] loots)
        {
            this.loots = loots;
        }

        public string Lootstate { get; set; }

        public void Populate(RealmManager manager, Enemy enemy, Tuple<Player, int> playerDat, Random rand, string lootState, IList<LootDef> lootDefs)
        {
            loots[rand.Next(0, loots.Length)].Populate(manager, enemy, playerDat, rand, lootState, lootDefs);
        }
    }

    public static class LootTemplates
    {
        public static ILootDef[] DefaultEggLoot(EggRarity maxRarity)
        {
            switch(maxRarity)
            {
                case EggRarity.Common:
                    return new ILootDef[1] {new EggLoot(EggRarity.Common, 0.1) };
                case EggRarity.Uncommon:
                    return new ILootDef[2] { new EggLoot(EggRarity.Common, 0.1), new EggLoot(EggRarity.Uncommon, 0.05) };
                case EggRarity.Rare:
                    return new ILootDef[3] { new EggLoot(EggRarity.Common, 0.1), new EggLoot(EggRarity.Uncommon, 0.05), new EggLoot(EggRarity.Rare, 0.01) };
                case EggRarity.Legendary:
                    return new ILootDef[4] { new EggLoot(EggRarity.Common, 0.1), new EggLoot(EggRarity.Uncommon, 0.05), new EggLoot(EggRarity.Rare, 0.01), new EggLoot(EggRarity.Legendary, 0.001) };
                default:
                    throw new InvalidOperationException("Not a valid Egg Rarity");
            }
        }

        public static ILootDef[] StatIncreasePotionsLoot()
        {
            return new ILootDef[]
            {
                new OnlyOne(
                    new ItemLoot("Potion of Defense", 1),
                    new ItemLoot("Potion of Attack", 1),
                    new ItemLoot("Potion of Speed", 1),
                    new ItemLoot("Potion of Vitality", 1),
                    new ItemLoot("Potion of Wisdom", 1),
                    new ItemLoot("Potion of Dexterity", 1)
                )
            };
        }
    }
}