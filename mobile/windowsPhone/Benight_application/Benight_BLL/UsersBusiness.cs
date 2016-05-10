using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Benight_DAL;
using Benight_CommonPhone;

namespace Benight_BLL
{
    public class UsersBusiness
    {

        public Task<User> GetUsers()
        {
            UsersData usersData = new UsersData();
            return usersData.GetUsers();
        }
    }
}
