using Parse;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;

namespace Benight_application
{
    public class TodoEv : INotifyPropertyChanged
    {
        public static readonly string ClassName = "Event";

        public TodoEv() : this(new ParseObject(ClassName)) { }
        public TodoEv(ParseObject backingObject)
        {
            if (backingObject.ClassName != ClassName)
            {
                throw new ArgumentException("Must create TodoItems with the proper ClassName");
            }
            //this.BackingObject = backingObject;
            BackingObject = backingObject;
        }

        static public string myEvName(string name)
        {
            return (name);
        }



        static public ParseObject BackingObject { get; private set; }

        public bool IsDirty
        {
            get
            {
                return BackingObject.IsDirty;
            }
        }

        static public string name
        {
            get
            {
                return BackingObject.ContainsKey("name") ? BackingObject.Get<string>("name") : null;

            }
            set
            {
                if (value != name)
                {
                    BackingObject["name"] = value;
                    //OnPropertyChanged();
                }
            }
        }

        static public DateTime date
        {
            get
            {
                return BackingObject.ContainsKey("date") ? BackingObject.Get<DateTime>("date") : date;

            }
            set
            {
                if (value != date)
                {
                    BackingObject["date"] = value;
                    //OnPropertyChanged();
                }
            }
        }

        static public string objectId
        {
            get
            {
                return BackingObject.ContainsKey("objectId") ? BackingObject.Get<string>("objectId") : null;

            }
            set
            {
                if (value != objectId)
                {
                    BackingObject["objectId"] = value;
                    //OnPropertyChanged();
                }
            }
        }

        public string Description
        {
            get
            {
                return BackingObject.ContainsKey("Description") ? BackingObject.Get<string>("Description") : null;
            }
            set
            {
                if (value != Description)
                {
                    BackingObject["Description"] = value;
                    //OnPropertyChanged();
                }
            }
        }

        private void OnPropertyChanged([CallerMemberName] string propertyName = null)
        {
            var del = PropertyChanged;
            if (del != null)
            {
                del(this, new PropertyChangedEventArgs(propertyName));
                del(this, new PropertyChangedEventArgs("IsDirty"));
            }
        }

        public async Task SaveAsync()
        {
            await BackingObject.SaveAsync();
            OnPropertyChanged("IsDirty");
        }

        public void Revert()
        {
            BackingObject.Revert();
            OnPropertyChanged(String.Empty);
        }

        public event PropertyChangedEventHandler PropertyChanged;
    }
}
