/*
 *  Author: Davide Pollicino
 *  Date: 05/12/2019
*/

using System;
using System.Collections.Generic;
using System.Text;
using System.Runtime.Serialization;
using System.Runtime.Serialization.Formatters.Binary;

namespace BusinessLayer
{
    [Serializable()]
    public class Staff : Person
    {

        private string category = "";
        private int id;

        public int Id { get => id; internal set => id = value; }
        public string Category { get => category; set => category = value; }

        public string Name { get; internal set; }
        public string Surname { get; internal set; }

        public string Address1 { get; internal set; }

        public string Address2 { get; internal set; }

        public double Longitude { get; internal set; }

        public double Latitude { get; internal set; }

        public override string ToString()
        {
            return string.Format(Convert.ToString(id), Name, Surname, Address1, Address2, Category , Convert.ToString(Longitude), Convert.ToString(Latitude));
        }
    }//End of the class 
}//End of the namespace 