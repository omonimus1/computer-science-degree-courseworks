/*
 *  Author: Davide Pollicino
 *  Date: 05/12/2019
*/

using System;
using System.Runtime.Serialization;
using System.Runtime.Serialization.Formatters.Binary;


namespace BusinessLayer 
{
    [Serializable]
    public class Person
    {
      
        private int id;

        private string name;

        private string surname;

        private string address1;

        private string address2;

        private double longitude;

        private double latitude;

        public string Name
        {
            get { return name; }

            set { name = value; }
        }

        public int Id
        {
            get { return id; }
            set { id = value; }
        }

        public string Surname
        {
            get { return surname; }
            set { surname = value; }
        }

        public string Address1
        {
            get { return Address1; }
            set { address1 = value; }
        }

        public string Address2
        {
            get { return address2; }
            set { address2 = value; }
        }

        public double Longitude
        {
            get { return longitude; }
            set { longitude = value; }
        }

        public double Latitude
        {
            get { return latitude; }
            set { longitude = value; }
        }
    } //End of the class 
}     //End of the namespace 
