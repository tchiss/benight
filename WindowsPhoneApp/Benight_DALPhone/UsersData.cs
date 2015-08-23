using Benight_CommonPhone;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
//using Parse;

namespace Benight_DALPhone
{
    public class UsersData
    {
        public async Task<UserCommon> GetUsers()
        {
            List<UserCommon> AllUsers = new List<UserCommon>();

            //var users = await (from user in ParseUser.Query
            //                   where user.Get<string>("username") == "totoro"
            //                   select user).FindAsync();

            return null;
        }

        public void add(UserCommon user)
        {
            // créer objet user parse
            // save
        }

        public void remove(UserCommon user)
        {

        }
    }
}
