/*
 *  Author: Davide Pollicino
 *  Date: 05/12/2019
*/

/*
 * Singleton class: this class implement the Singleton Design Pattern.  
 *  It contains most of the methods used for the visit validation 
*/

using System;
using System.Collections.Generic;
using System.Text;


namespace BusinessLayer
{
    class Singleton
    {
        private Singleton() { }

        private static Singleton instance;

        // Used instead of a constrctorr , only created one instance and allways return that reference
        public static Singleton Instance
        {
            get
            {
                if (instance == null)
                {
                    instance = new Singleton();
                }
                return instance;
            }
        }

        // Check if two visits are going to start at the same day and time
        public Boolean areTwoDatesEquals(DateTime date, DateTime visitTimeFromList)
        {
            int directComparison = DateTime.Compare(date, visitTimeFromList);
            if (directComparison == 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        // Validate timeslot if the visit time is not already booked
        public Boolean isVisitInABookedSlot(double minute, DateTime date, DateTime visitTimeFromList)
        {
            DateTime visitEnd = visitTimeFromList.AddMinutes(minute);
            if (date >= visitTimeFromList && date <= visitEnd)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        // Validate visity type 
        public Boolean IsVisitTypeValid(int type)
        {
            if (type >= 0 && type <= 3)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        // Validate staff member category
        public Boolean isCategoryValid(string category)
        {
            if (category == "Social Worker" || category == "General Practitioner" || category == "Community Nurse" || category == "Care Worker")
            {
                return true;
            }
            else
            {
                return false; 
            }
        }

    }//End of the class 
}//End of the namespace 
