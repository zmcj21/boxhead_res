package Thing
{
    public class CPickup_Ammo extends CThingPickup
    {
         
        
        public function CPickup_Ammo(param1:Object)
        {
            super(param1,SheetPickup_Ammo);
            AddSound("Pickup",Pickup_Ammo);
        }
        
        override public function Pickup(param1:*) : void
        {
            super.Pickup(param1);
            param1.PickupAmmo(this);
        }
        
        override public function get _CLASSID_() : String
        {
            return "CPickup_Ammo";
        }
    }
}
