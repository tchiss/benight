using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Benight_DALPhone;
using Benight_CommonPhone;

namespace Benight_BLLPhone
{
    public class UsersBusiness
    {
        private UsersData userData;

        public Task<UserCommon> GetUsers()
        {
            UsersData usersData = new UsersData();
            return usersData.GetUsers();
        }

        public void AddUser(UserCommon user)
        {
            userData.add(user);
        }

        public void RemoveUser(UserCommon user)
        {
            userData.remove(user);
        }
    }
}
