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
    public class Visit
    {
        private int[] staffIds;
        private int clientId = 0; 
        private string visitTime = " ";
        private int visitType = 0;

        public int VisitType { get => visitType;  set => visitType
                = value; }

        public string VisitTime { get => visitTime; set => visitTime = value; }

        public int ClientIdentifier { get => clientId; set => clientId = value; }


      public int[] StaffIdsVector
        {
            get
            {
                return staffIds;
            }
            set
            {
                staffIds = value;
            }
        }
    } //End of the class 
}     //End of the namespace 