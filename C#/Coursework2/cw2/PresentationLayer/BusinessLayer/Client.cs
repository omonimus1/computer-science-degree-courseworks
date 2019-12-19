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
    [Serializable]
   public class Client : Person
    {
       
        public int Id { get; internal set; }
        public string Name { get; internal set; }
        public string Surname { get; internal set; }

        public string Address1 { get; internal set; }

        public string Address2 { get; internal set; }

        public double Longitude { get; internal set; }

        public double Latitude { get; internal set; }

    } //End of the class 
}     //End of the namespace 