/*
 *  Author: Davide Pollicino
 *  Date: 05/12/2019
*/
/* 
 * HealthFacade class: Represents the core of the Logic Layer, 
 * it contains methods that allows to add:
 *  1) Add an element to the staff, client and visit list
 *  2) Remove every elemements from every list
 *  3) Invoke the load and save methods for the Serialization and Desealization of the lists
 */

using System.IO;
using System;
using System.Collections.Generic;
using System.Xml;
using System.Linq;
using System.Xml.Linq;
using System.Xml.Serialization;
using Newtonsoft.Json;
using BusinessLayer.DataLayer;
using System.Runtime.Serialization;
using System.Runtime.Serialization.Formatters.Binary;


namespace BusinessLayer
{
    public static class visitTypes
    {
        public const int assessment = 0;
        public const int medication = 1;
        public const int bath = 2;
        public const int meal = 3;
    }
    [Serializable]
     public class HealthFacade
    {

        private const string ClearErrorMessage = "Error during the elimination of the objects from the system - Clear Method";

        Singleton sin = Singleton.Instance;

        List<Staff> staffList = new List<Staff>();
        List<Client> clientList = new List<Client>();
        List<Visit> visitList = new List<Visit>();


        // Add an elemement to the staff list
        public Boolean addStaff(int id, string firstName, string surname, string address1, string address2, string category, double baseLocLat, double baseLocLon)
        {
            try
            {
                
                if (!doesStaffIdExist(id))
                {  // The staff id is not already registered
                    if (sin.isCategoryValid(category))
                    {   // The cateogry of staff member is valid 
                        Staff Person1 = new Staff();
                        Person1.Id = id;
                        Person1.Name = firstName;
                        Person1.Surname = surname;
                        Person1.Address1 = address1;
                        Person1.Address2 = address2;
                        Person1.Category = category;
                        Person1.Latitude = baseLocLat;
                        Person1.Longitude = baseLocLon;
                        staffList.Add(Person1);
                        return true;
                    }
                    return false;
                }
                else
                {
                    return false;
                }
            }
            catch (Exception)
            {
                throw new Exception("Error  while adding a new staff member");
            }
        }
      
        // Returns True if a staff Member ID is already stored in the list
        public Boolean doesStaffIdExist(int id)
        {
            try
            {
                foreach (Staff s in staffList)
                {
                    if ((int)s.Id == id)
                    {
                        return true;
                    }
                }
                return false;
            }
            catch (Exception)
            {
                throw new Exception("Error - doesStaffIdExists()");
            }
        }


        // Add client information to the client list
        public Boolean addClient(int id, string firstName, string surname, string address1, string address2, double locLat, double locLon)
        {
            try
            {
                if (!doesClientIdExist(id))
                {
                    Client patient = new Client();
                    patient.Id = id;
                    patient.Name = firstName;
                    patient.Surname = surname;
                    patient.Address1 = address1;
                    patient.Address2 = address2;
                    patient.Longitude = locLat;
                    patient.Latitude = locLon;
                    clientList.Add(patient);
                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch (Exception)
            {
                throw new Exception("Error - addClient()");
            }
        }


        // Return true if the client Id is already stored in out list
        
        public Boolean doesClientIdExist(int id)
        {
            foreach (Client s in clientList)
            {
                if ((int)s.Id == id)
                {
                    return true;
                }
            }
            return false;
        }
     

        

        // Add a visit in the visit List
        public Boolean addVisit(int[] staff, int patient, int type, string dateTime)
        {
            if (doesClientIdExist(patient))
            { 
                if (sin.IsVisitTypeValid(type))
                {   
                    if (visitStaffRequiredValidation(type, staff))
                    {
                        if (dateComparison(dateTime, type))
                        {
                            Visit visit = new Visit();
                            visit.StaffIdsVector = staff;
                            visit.ClientIdentifier = patient;
                            visit.VisitType = type;
                            visit.VisitTime = dateTime;
                            visitList.Add(visit);
                            return true;
                        }
                        else 
                        {
                            throw new Exception("Impossible to add the visit, time slot is already booked \n");
                        }
                    }
                    else
                    {
                        throw new Exception("Impossible to add the visit. the staff required is not adapt for visit type \n");
                    }
                }
                else
                {
                    throw new Exception("Impossible to add the visit , the visit type does not exists \n");
                }
            }
            else
            {
                throw new Exception("Impossible to add the visit, the patient ID does not exists \n");
            }

        }



        // Validate time of a ew visit. Returns false if the time slot is already booked
        public Boolean dateComparison(string date, int type)
        {
            if (!sin.IsVisitTypeValid(type))
            {
                return false;
            }
            else
            {
                if (type == 0)
                {
                    double minutes = 60;
                    foreach (Visit i in visitList)
                    {
                        DateTime visitTimeRegistrered = DateTime.Parse(i.VisitTime);
                        DateTime date1 = DateTime.Parse(date);
                        // Check if two visits start the same day at the same time
                        if (sin.areTwoDatesEquals(date1, visitTimeRegistrered))
                        {
                            return false;
                        }
                        else if (sin.isVisitInABookedSlot(minutes, date1, visitTimeRegistrered))
                        {
                            return false;
                        }
                        else
                        {
                            return true;
                        }

                    }
                    return true;
                }

                else if (type == 1)
                {
                    double minutes = 20;
                    foreach (Visit i in visitList)
                    {
                        DateTime visitTimeRegistrered = DateTime.Parse(i.VisitTime);
                        DateTime date1 = DateTime.Parse(date);
                        // Check if two visits start the same day at the same time
                        if (sin.areTwoDatesEquals(date1, visitTimeRegistrered))
                        {
                            return false;
                        }
                        else if (sin.isVisitInABookedSlot(minutes, date1, visitTimeRegistrered))
                        {
                            return false;
                        }
                        else
                        {
                            return true;
                        }
                    }
                    return true;
                }

                else if (type == 2)
                {
                    double minutes = 30;
                    foreach (Visit i in visitList)
                    {
                        DateTime visitTimeRegistrered = DateTime.Parse(i.VisitTime);
                        DateTime date1 = DateTime.Parse(date);
                        // Check if two visits start the same day at the same time
                        if (sin.areTwoDatesEquals(date1, visitTimeRegistrered))
                        {
                            return false;
                        }
                        else if (sin.isVisitInABookedSlot(minutes, date1, visitTimeRegistrered))
                        {
                            return false;
                        }
                        else
                        {
                            return true;
                        }
                    }
                    return true;
                }

                else if (type == 3)
                {
                    double minutes = 30;
                    foreach (Visit i in visitList)
                    {
                        DateTime visitTimeRegistrered = DateTime.Parse(i.VisitTime);
                        DateTime date1 = DateTime.Parse(date);
                        // Check if two visits start the same day at the same time
                        if (sin.areTwoDatesEquals(date1, visitTimeRegistrered))
                        {
                            return false;
                        }
                        else if (sin.isVisitInABookedSlot(minutes, date1, visitTimeRegistrered))
                        {
                            return false; 
                        }
                        else
                        {
                            return true;
                        }
                    }
                }
                return true;
            }
        }


        // Return content of the staff List
        public String getStaffList()
        {
            String result = "";
            foreach (Staff s in staffList)
            {
                result += s.Id.ToString() + " " + s.Name + " " + s.Surname + " " + s.Address1 + " " + s.Address2 + " " + s.Category + " " + s.Latitude.ToString() + " " + s.Longitude.ToString() + "\n";
            }
            return result;
        }


        // Return content of the list of clients
        public String getClientList()
        {
            String result = "";
            foreach (Client s in clientList)
            {
                result += s.Id.ToString() + " " + s.Name + " " + s.Surname + " " + s.Address1 + " " + s.Address2 + " " + s.Latitude.ToString() + " " + s.Longitude.ToString() + "\n";
            }
            return result;
        }


        // Return list of visits
        public String getVisitList()
        {
            String result = "";
            try
            {
                foreach (Visit v in visitList)
                {
                    //string.Join allows to return all all the element of an array as a string, where every element in this case is splitted by a comma
                    result += string.Join(",", v.StaffIdsVector) + " " + v.ClientIdentifier.ToString() + v.VisitType.ToString() + " " + Convert.ToDateTime(v.VisitTime) + "\n";
                }
                return result;
            }

            catch (Exception)
            {
                return "Error getVisitList() ";
            }
        }


        // Remove all the elements from the lists
        public void clear()
        {
            try
            {
                staffList.Clear();
                clientList.Clear();
                visitList.Clear();
            }
            catch (Exception)
            {
                throw new Exception(ClearErrorMessage);
            }
        }


        // Validate competence and number of staff member in according with the visit type
        public Boolean visitStaffRequiredValidation(int type, int[] staff)
        {
            foreach (Staff member in staffList)
            {
                foreach (int id in staff)
                {
                    if (member.Id == id)
                    {
                        if (type == 0 && !((member.Category == "Social Worker" || member.Category == "General Practitioner") && staff.Length == 2))
                            return false;
                        if (type == 1 && member.Category != "Community Nurse")
                            return false;
                        if (type == 2 && !(member.Category == "Care Worker" && staff.Length == 2))
                            return false;
                        if (type == 3 && member.Category != "Care Worker")
                            return false;
                        else
                            return true;
                    }
                }

            }
            return false;
        }

        // Invoke the methods that will Deserialize the lists from their files. 
        public Boolean load()
        {
            Facade dt = new Facade();
            clientList = dt.loadClient();
            staffList =  dt.loadStaff();
            visitList = dt.loadVisit();
            return true;
        }


        // Invoke the  method that will Serialize the lists
        public bool Save()
        {
            Facade dataLayerAccess = new Facade();
            dataLayerAccess.saveLists(staffList, clientList, visitList);
            return true;
        }

      
    }//End of the class 
}//End of the namespace 
