using Benight_CommonPhone;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Parse;

namespace Benight_DAL
{
    public class UsersData
    {
        public async Task<User> GetUsers()
        {
            List<User> AllUsers = new List<User>();

            var users = await (from user in ParseUser.Query
                               where user.Get<string>("username") == "totoro"
                               select user).FindAsync();

            return null;
        }
    }
}
