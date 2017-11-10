using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Timers;

namespace wServer.realm.entities.player
{
    public partial class Player
    {
        public int Stamina { get; set; }
        public bool Tired = false;
        public bool NoEnergyLeft = false;
        public bool CanSprint = true;
        public bool Sprint = false;

        private void RateofLoss()
        {
            if (Sprint == true)
            {
                Timer timer = new Timer(250);
                timer.Start();
                timer.Elapsed += new ElapsedEventHandler(LossStamina);
            }
            else
            {
                Timer timer2 = new Timer(2000);
                timer2.Start();
                timer2.Elapsed += new ElapsedEventHandler(RegainStamina);
            }
        }

        public void GetStamina()
        {
            Stamina = 100;

            if (Stamina > 0)
            {
                CanSprint = true;
            }
            else
            {
                Client.Player.SendInfo("You are running low on stamina, So you can no longer sprint!");
                CanSprint = false;
            }
        }

        private void LossStamina(object o, ElapsedEventArgs e)
        {
            if (Stamina > 0)
            {
                Stamina -= 1;
            }
        }

        private void RegainStamina(object o, ElapsedEventArgs e)
        {
            if (Stamina < 100)
            {
                Stamina += 1;
            }
        }

        public void Sprintt(Player player)
        {
            if (CanSprint == true)
            {
                if (Sprint == true)
                {
                    ApplyConditionEffect(ConditionEffectIndex.Speedy);
                }
            }
            else
            {
                Sprint = false;
            }
        }
    }
}
