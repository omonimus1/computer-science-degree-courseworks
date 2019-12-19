/*
 *  Author: Davide Pollicino
 *  Date: 05/12/2019
*/

/*
 * Facade.cs: Class the implement the Facade design pattern. 
*  Just this class represents theorically the entire Data Layer of the 3 Layer architecture. 
*  This class is used to serialize and deserialize the the three lists: staffList , clietList and visitList.
*  These three lists, will be stored in theree differnt binary files. 
*/

using System;
using System.Runtime.Serialization;
using System.Runtime.Serialization.Formatters.Binary;
using System.Collections.Generic;
using System.IO;
using System.Linq;


namespace BusinessLayer.DataLayer
{
     
    [Serializable]
    class Facade
    {
        // Path of the three binary files used to serialize and Deserialize the lists.                                                       
        private const string staffFilePath = "../../../BusinessLayer/DataLayer/staff.bin";
        private const string clientFilePath= "../../../BusinessLayer/DataLayer/client.bin";
        private const string visitFilePath = "../../../BusinessLayer/DataLayer/visit.bin";


        // Serialization of the lists 
        public void saveLists (List<Staff> staffList , List<Client> clientList, List<Visit> visitList)
        {
                // Serialization list of staff 
                using (Stream fileStream1 = File.Open( staffFilePath, FileMode.Create))
                {
                    BinaryFormatter serializer = new BinaryFormatter();
                    serializer.Serialize(fileStream1, staffList);
                }
                // Serialization list of clients
                using (Stream fileStream2 = File.Open(clientFilePath, FileMode.Create))
                {
                    BinaryFormatter serializer = new BinaryFormatter();
                    serializer.Serialize(fileStream2, clientList);
                }
                // Serialization list of visits
                using (Stream fileStream3 = File.Open(visitFilePath, FileMode.Create))
                {
                    BinaryFormatter serializer = new BinaryFormatter();
                    serializer.Serialize(fileStream3, visitList);
                }
        }

 
        // Desialization list of Staff
        public List<Staff> loadStaff()
        {
            try
            {
                List<Staff> staffList; 
                using (Stream fileStream = File.OpenRead(staffFilePath))
                {
                    BinaryFormatter deserializer = new BinaryFormatter();
                    staffList = (List<Staff>)deserializer.Deserialize(fileStream);
                }
                return staffList;
            }
            catch (Exception)
            {
                throw new Exception("Error staff Deserialization");
            }
        }

        // Desialization list of Client
        public List<Client> loadClient()
        {
            try
            {
                List<Client> clientList;
                using (Stream fileStream = File.OpenRead(clientFilePath))
                {
                    BinaryFormatter deserializer = new BinaryFormatter();
                    clientList = (List<Client>)deserializer.Deserialize(fileStream);
                }
                return clientList;
            }
            catch (Exception)
            {
                throw new Exception("Error client list Deserialization");
            }
        }

        // Desialization List of Visits
        public List<Visit> loadVisit()
        {
            try
            {
                List<Visit> visitList;
                using (Stream fileStream = File.OpenRead(visitFilePath))
                {
                    BinaryFormatter deserializer = new BinaryFormatter();
                    visitList = (List<Visit>)deserializer.Deserialize(fileStream);
                }
                return visitList;
            }
            catch (Exception)
            {
                throw new Exception("Error visit Deserialization");
            }
        }


    } //End of the class 
}     //End of the namespace 